# Docker Swarm - Boas Praticas

## Visao Geral

Docker Swarm e o orquestrador nativo do Docker. Gerencia containers em um ou mais
servidores (nodes), distribuindo carga e garantindo disponibilidade.

---

## Conceitos Fundamentais

| Conceito | O que e | Analogia |
|----------|---------|----------|
| Node | Servidor no cluster | Funcionario |
| Manager | Node que coordena | Gerente |
| Worker | Node que executa | Operario |
| Service | Definicao do que rodar | Descricao do cargo |
| Task | Instancia rodando | Funcionario no posto |
| Stack | Grupo de services | Departamento |
| Overlay Network | Rede entre nodes | Telefone interno |

---

## Docker Compose para Swarm

### Estrutura Recomendada

```yaml
version: "3.8"

services:
  app:
    image: minha-app:1.2.3          # SEMPRE tag especifica

    # Deploy config (Swarm)
    deploy:
      mode: replicated
      replicas: 2                    # Minimo 2 para HA

      # Atualizacao gradual
      update_config:
        parallelism: 1               # Atualiza 1 de cada vez
        delay: 30s                   # Espera entre updates
        failure_action: rollback     # Rollback automatico se falhar
        order: start-first           # Novo inicia antes do antigo parar
        monitor: 60s                 # Monitora por 60s apos update

      # Rollback config
      rollback_config:
        parallelism: 1
        delay: 10s
        order: start-first

      # Restart policy
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s

      # Limites de recursos
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 128M

      # Placement
      placement:
        constraints:
          - node.role == worker       # Apenas em workers
        preferences:
          - spread: node.id           # Distribuir entre nodes

      # Labels para Traefik
      labels:
        - "traefik.enable=true"
        - "traefik.http.routers.app.rule=Host(`app.dominio.com`)"
        - "traefik.http.routers.app.entrypoints=websecure"
        - "traefik.http.routers.app.tls.certresolver=letsencrypt"
        - "traefik.http.services.app.loadbalancer.server.port=8080"

    # Health check
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

    # Variaveis de ambiente
    environment:
      - NODE_ENV=production
      - DB_HOST=postgres

    # Volumes
    volumes:
      - app_data:/app/data

    # Networks
    networks:
      - internal
      - public

    # Logging
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"

# Volumes persistentes
volumes:
  app_data:
    driver: local

# Networks
networks:
  internal:
    driver: overlay
    internal: true              # Sem acesso externo
  public:
    external: true              # Network compartilhada (Traefik)
```

---

## Regras de Ouro

### 1. Imagens
- **SEMPRE** usar tags especificas (`app:1.2.3`)
- **NUNCA** usar `:latest` em producao
- **SEMPRE** usar imagens de registries confiaveis
- Preferir imagens `alpine` ou `slim` (menores, menos vulnerabilidades)

### 2. Health Checks
**Obrigatorios** em todo service de producao.

```yaml
# Web app
healthcheck:
  test: ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 60s

# Database (PostgreSQL)
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U $POSTGRES_USER -d $POSTGRES_DB"]
  interval: 30s
  timeout: 10s
  retries: 5
  start_period: 30s

# Redis
healthcheck:
  test: ["CMD", "redis-cli", "ping"]
  interval: 15s
  timeout: 5s
  retries: 3
```

### 3. Resource Limits
**Sempre definir** para evitar que um container consuma todos os recursos.

```yaml
deploy:
  resources:
    limits:
      cpus: '2.0'
      memory: 2G
    reservations:
      cpus: '0.5'
      memory: 512M
```

**Guia de dimensionamento:**

| Tipo de App | CPU Limit | RAM Limit |
|-------------|-----------|-----------|
| Web app leve | 0.5-1.0 | 256M-512M |
| Web app media | 1.0-2.0 | 512M-1G |
| API pesada | 2.0-4.0 | 1G-2G |
| Database | 2.0-4.0 | 2G-4G |
| Redis/Cache | 0.5-1.0 | 256M-1G |
| Worker/Queue | 1.0-2.0 | 512M-1G |

### 4. Networks
Isolar stacks com networks overlay.

```yaml
# Network interna (apenas entre services da stack)
networks:
  internal:
    driver: overlay
    internal: true    # Bloqueia acesso externo

# Network publica (compartilhada com Traefik)
networks:
  public:
    external: true    # Ja deve existir
```

**Regra:** Servicos que NAO precisam de acesso externo ficam APENAS na network interna.

### 5. Volumes
Persistir dados que precisam sobreviver ao restart do container.

```yaml
volumes:
  # Named volume (gerenciado pelo Docker)
  postgres_data:
    driver: local

  # Bind mount (diretorio do host)
  # EVITAR em producao quando possivel
  # app_config:
  #   driver: local
  #   driver_opts:
  #     type: none
  #     device: /opt/app/config
  #     o: bind
```

### 6. Logging
Configurar limites de log para evitar estouro de disco.

```yaml
logging:
  driver: json-file
  options:
    max-size: "10m"    # Maximo 10MB por arquivo
    max-file: "3"      # Maximo 3 arquivos
```

### 7. Update Strategy
Atualizacao gradual (rolling update) e obrigatoria.

```yaml
deploy:
  update_config:
    parallelism: 1           # 1 de cada vez
    delay: 30s               # Espera 30s entre cada
    failure_action: rollback # Se falhar, volta
    order: start-first       # Novo sobe antes de derrubar o antigo
    monitor: 60s             # Monitora 60s pos-update
```

---

## Traefik como Reverse Proxy

### Stack Traefik Base

```yaml
version: "3.8"

services:
  traefik:
    image: traefik:v3.0
    command:
      # API e Dashboard
      - "--api.dashboard=true"
      - "--api.insecure=false"

      # Docker provider
      - "--providers.docker=true"
      - "--providers.docker.swarmMode=true"
      - "--providers.docker.exposedbydefault=false"
      - "--providers.docker.network=public"

      # Entrypoints
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"

      # Redirect HTTP → HTTPS
      - "--entrypoints.web.http.redirections.entrypoint.to=websecure"
      - "--entrypoints.web.http.redirections.entrypoint.scheme=https"

      # Let's Encrypt
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge=true"
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=web"
      - "--certificatesresolvers.letsencrypt.acme.email=SEU_EMAIL"
      - "--certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json"

      # Logging
      - "--log.level=WARN"
      - "--accesslog=true"
      - "--accesslog.bufferingsize=100"

    ports:
      - "80:80"
      - "443:443"

    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "letsencrypt:/letsencrypt"

    networks:
      - public

    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints:
          - node.role == manager
      resources:
        limits:
          cpus: '0.5'
          memory: 256M

volumes:
  letsencrypt:

networks:
  public:
    driver: overlay
    attachable: true
```

### Labels para Expor Service

```yaml
deploy:
  labels:
    # Habilitar Traefik
    - "traefik.enable=true"

    # Router
    - "traefik.http.routers.NOME.rule=Host(`dominio.com`)"
    - "traefik.http.routers.NOME.entrypoints=websecure"
    - "traefik.http.routers.NOME.tls.certresolver=letsencrypt"

    # Service (porta interna)
    - "traefik.http.services.NOME.loadbalancer.server.port=8080"

    # Headers de seguranca (opcional mas recomendado)
    - "traefik.http.middlewares.secure-headers.headers.stsSeconds=31536000"
    - "traefik.http.middlewares.secure-headers.headers.stsIncludeSubdomains=true"
    - "traefik.http.middlewares.secure-headers.headers.frameDeny=true"
    - "traefik.http.middlewares.secure-headers.headers.contentTypeNosniff=true"
    - "traefik.http.middlewares.secure-headers.headers.browserXssFilter=true"
    - "traefik.http.routers.NOME.middlewares=secure-headers"
```

---

## Troubleshooting

### Service nao sobe
```bash
# Verificar tasks
docker service ps NOME --no-trunc

# Ver logs
docker service logs NOME --tail 50

# Verificar se imagem existe
docker pull IMAGEM:TAG
```

### Service "pending"
Causas comuns:
1. Sem recursos suficientes (CPU/RAM)
2. Constraint impossivel de atender
3. Network nao existe
4. Volume nao acessivel

```bash
# Verificar nodes e recursos
docker node ls
docker node inspect NODE_ID --pretty
```

### Rollback manual
```bash
# Via Docker CLI
docker service rollback NOME

# Via Portainer: Atualizar stack com compose anterior
```

### Limpar recursos nao usados
```bash
# Containers parados
docker container prune -f

# Images nao usadas
docker image prune -f

# Volumes nao usados (CUIDADO - dados podem ser perdidos)
docker volume prune -f

# Networks nao usadas
docker network prune -f

# Tudo junto (CUIDADO)
docker system prune -f
```

---

## Stacks Comuns - Templates

### PostgreSQL
```yaml
version: "3.8"
services:
  postgres:
    image: postgres:16.2-alpine
    environment:
      POSTGRES_DB: ${DB_NAME:-app}
      POSTGRES_USER: ${DB_USER:-app}
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - internal
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-app}"]
      interval: 30s
      timeout: 10s
      retries: 5
    secrets:
      - db_password

volumes:
  postgres_data:

networks:
  internal:
    driver: overlay
    internal: true

secrets:
  db_password:
    external: true
```

### Redis
```yaml
version: "3.8"
services:
  redis:
    image: redis:7.2-alpine
    command: redis-server --requirepass ${REDIS_PASSWORD} --maxmemory 256mb --maxmemory-policy allkeys-lru
    volumes:
      - redis_data:/data
    networks:
      - internal
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
    healthcheck:
      test: ["CMD", "redis-cli", "-a", "${REDIS_PASSWORD}", "ping"]
      interval: 15s
      timeout: 5s
      retries: 3

volumes:
  redis_data:

networks:
  internal:
    driver: overlay
    internal: true
```
