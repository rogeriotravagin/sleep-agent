# Seguranca de Servidores - Base de Conhecimento

## Principios Fundamentais

### 1. Defense in Depth (Defesa em Profundidade)
Multiplas camadas de seguranca. Se uma camada falha, as outras protegem.

```
Internet → Cloud Firewall → UFW/iptables → Docker Network → Container → Aplicacao
```

### 2. Principle of Least Privilege (Menor Privilegio)
Cada usuario, processo e servico tem APENAS as permissoes minimas necessarias.

### 3. Zero Trust
Nunca confie, sempre verifique. Mesmo dentro da rede interna.

### 4. Assume Breach
Projete como se ja tivesse sido comprometido. Monitore, audite, detecte.

---

## Hardening de Servidor Linux (Ubuntu/Debian)

### Primeira Configuracao (Ordem Obrigatoria)

```
1. Atualizar sistema
2. Criar usuario nao-root
3. Configurar SSH (key-only, porta customizada)
4. Configurar firewall (UFW + Cloud Firewall)
5. Instalar fail2ban
6. Configurar updates automaticos
7. Instalar auditd
8. Configurar timezone e NTP
```

### Atualizacao do Sistema
```bash
apt update && apt upgrade -y
apt autoremove -y
```

### Criacao de Usuario
```bash
# Criar usuario
adduser deploy --disabled-password
mkdir -p /home/deploy/.ssh
cp /root/.ssh/authorized_keys /home/deploy/.ssh/
chown -R deploy:deploy /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chmod 600 /home/deploy/.ssh/authorized_keys

# Dar sudo
usermod -aG sudo deploy
echo "deploy ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/deploy
chmod 440 /etc/sudoers.d/deploy
```

### SSH Hardening Completo
```bash
# Backup config original
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Configuracao segura
cat > /etc/ssh/sshd_config.d/hardening.conf << 'SSHEOF'
# Porta customizada
Port 2222

# Autenticacao
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
MaxAuthTries 3
LoginGraceTime 30
MaxSessions 3
MaxStartups 3:50:10

# Restricoes
AllowUsers deploy
ClientAliveInterval 300
ClientAliveCountMax 2
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no
PermitTunnel no
PermitUserEnvironment no

# Algoritmos
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com

# Logging
LogLevel VERBOSE
SSHEOF

# Testar configuracao
sshd -t

# Reiniciar (MANTER SESSAO ATUAL ABERTA)
systemctl restart sshd
```

**CRITICO:** Sempre teste o novo acesso SSH ANTES de fechar a sessao atual.

### Firewall (UFW)
```bash
# Instalar e configurar
apt install ufw -y

# Default policies
ufw default deny incoming
ufw default allow outgoing

# SSH (porta customizada)
ufw allow from SEU_IP/32 to any port 2222 proto tcp comment "SSH autorizado"

# HTTP/HTTPS
ufw allow 80/tcp comment "HTTP"
ufw allow 443/tcp comment "HTTPS"

# Docker Swarm (rede privada apenas)
ufw allow from 10.0.0.0/8 to any port 2377 proto tcp comment "Swarm manager"
ufw allow from 10.0.0.0/8 to any port 7946 proto tcp comment "Swarm nodes TCP"
ufw allow from 10.0.0.0/8 to any port 7946 proto udp comment "Swarm nodes UDP"
ufw allow from 10.0.0.0/8 to any port 4789 proto udp comment "Swarm overlay"

# Ativar
ufw enable
ufw status numbered
```

### Fail2Ban
```bash
apt install fail2ban -y

cat > /etc/fail2ban/jail.local << 'F2BEOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3
action = %(action_mwl)s

[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 7200

[sshd-ddos]
enabled = true
port = 2222
filter = sshd-ddos
logpath = /var/log/auth.log
maxretry = 6
bantime = 86400
F2BEOF

systemctl enable fail2ban
systemctl restart fail2ban
```

### Kernel Hardening (sysctl)
```bash
cat > /etc/sysctl.d/99-hardening.conf << 'SYSEOF'
# Protecao contra IP spoofing
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Desabilitar source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

# Protecao contra SYN flood
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048
net.ipv4.tcp_synack_retries = 2

# Ignorar ICMP redirect
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# Ignorar broadcast ICMP
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Log pacotes suspeitos
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Desabilitar IPv6 se nao usa
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
SYSEOF

sysctl -p /etc/sysctl.d/99-hardening.conf
```

---

## Seguranca de API

### Princípios para Chamadas de API

1. **HTTPS obrigatorio** - Nunca HTTP, mesmo internamente
2. **Validacao de certificado** - Nunca usar `--insecure` ou `verify=false`
3. **Tokens com menor privilegio** - Criar tokens especificos por funcao
4. **Timeout em toda chamada** - Evitar bloqueio por API lenta
5. **Rate limiting** - Respeitar limites do provider
6. **Retry com backoff** - Nao bombardear API com retentativas
7. **Nao logar credenciais** - Sanitizar logs antes de salvar

### Padrao de Chamada Segura
```bash
# BOM - Seguro
curl -s --max-time 30 \
  -H "Authorization: Bearer $TOKEN" \
  https://api.example.com/endpoint

# RUIM - Inseguro
curl -k http://api.example.com/endpoint?token=meu-token
```

### Rotacao de Tokens
```
1. Criar novo token
2. Atualizar .env com novo token
3. Testar conectividade
4. Revogar token antigo
5. Documentar rotacao
```

---

## Seguranca Docker

### Boas Praticas para Compose Files

```yaml
# SEGURO
services:
  app:
    image: app:1.2.3                    # Tag especifica
    read_only: true                      # Filesystem read-only
    security_opt:
      - no-new-privileges:true           # Sem escalacao de privilegio
    cap_drop:
      - ALL                              # Remove todas capabilities
    cap_add:
      - NET_BIND_SERVICE                 # Adiciona apenas o necessario
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    networks:
      - internal                          # Network isolada

# INSEGURO - NAO FAZER
services:
  app:
    image: app:latest                    # Tag generica
    privileged: true                     # Acesso total ao host
    network_mode: host                   # Sem isolamento de rede
    volumes:
      - /:/host                          # Monta root do host
```

### Docker Secrets (para dados sensiveis)
```yaml
# docker-compose.yaml
services:
  db:
    image: postgres:16.2
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    secrets:
      - db_password

secrets:
  db_password:
    external: true

# Criar secret
echo "senha_segura" | docker secret create db_password -
```

### Scan de Imagens
```bash
# Usar Trivy para scan de vulnerabilidades
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image nome-da-imagem:tag
```

---

## Monitoramento e Alertas

### Metricas Essenciais
| Metrica | Limiar | Acao |
|---------|--------|------|
| CPU | > 80% por 5min | Alerta |
| RAM | > 85% | Alerta |
| Disco | > 90% | CRITICO |
| Uptime servico | < 99.9% | Investigar |
| Certificado SSL | < 30 dias | Renovar |
| Login failures | > 10/hora | Bloquear IP |

### Script de Health Check
```bash
#!/bin/bash
# health-check.sh - Verificacao rapida de saude

echo "=== Health Check - $(date) ==="

# CPU
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo "CPU: ${CPU}%"

# RAM
RAM=$(free -m | awk 'NR==2{printf "%.1f", $3*100/$2}')
echo "RAM: ${RAM}%"

# Disco
DISK=$(df -h / | awk 'NR==2{print $5}')
echo "Disco: ${DISK}"

# Docker services
UNHEALTHY=$(docker service ls --format "{{.Name}} {{.Replicas}}" | grep -v "1/1\|2/2\|3/3")
if [ -n "$UNHEALTHY" ]; then
  echo "ALERTA - Services com problemas:"
  echo "$UNHEALTHY"
else
  echo "Docker: Todos services saudaveis"
fi

# SSL (verificar dominios)
for DOMAIN in "$@"; do
  EXPIRY=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | \
    openssl x509 -noout -enddate | cut -d= -f2)
  echo "SSL $DOMAIN: expira em $EXPIRY"
done

echo "==========================="
```

---

## Resposta a Incidentes

### Protocolo PICERL

1. **P**reparacao - Planos e ferramentas prontos
2. **I**dentificacao - Detectar o incidente
3. **C**ontencao - Isolar o problema
4. **E**rradicacao - Remover a causa
5. **R**ecuperacao - Restaurar operacoes
6. **L**icoes - Documentar e melhorar

### Em Caso de Comprometimento
```
1. NAO desligar o servidor (preservar evidencias)
2. Isolar: remover da rede (firewall block all)
3. Documentar: timestamp, o que foi observado
4. Avaliar: extensao do comprometimento
5. Conter: bloquear acessos comprometidos
6. Provisionar: novo servidor limpo
7. Restaurar: de backup pre-comprometimento
8. Investigar: causa raiz
9. Corrigir: fechar vulnerabilidade
10. Documentar: relatorio completo do incidente
```

---

## Compliance e Auditoria

### Log de Auditoria (Formato)
```
[TIMESTAMP] [NIVEL] [USUARIO] [ACAO] [RECURSO] [RESULTADO] [DETALHES]
```

Exemplo:
```
[2024-01-15T10:30:00Z] [INFO] [deploy] [CREATE] [server/cx32] [SUCCESS] [ID: 12345, Name: web-01]
[2024-01-15T10:35:00Z] [WARN] [deploy] [DELETE] [stack/old-app] [PENDING] [Aguardando confirmacao]
[2024-01-15T10:36:00Z] [INFO] [deploy] [DELETE] [stack/old-app] [SUCCESS] [Confirmado pelo usuario]
```

### Retencao de Logs
| Tipo | Retencao | Armazenamento |
|------|----------|---------------|
| Auditoria | 1 ano | Local + backup |
| Acesso | 90 dias | Local |
| Aplicacao | 30 dias | Local |
| Seguranca | 1 ano | Local + backup |
