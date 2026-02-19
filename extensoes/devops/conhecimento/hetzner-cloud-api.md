# Hetzner Cloud API - Base de Conhecimento

## Visao Geral

- **Base URL:** `https://api.hetzner.cloud/v1`
- **DNS API:** `https://dns.hetzner.com/api/v1` (header diferente)
- **Autenticacao:** `Authorization: Bearer {HETZNER_API_TOKEN}`
- **Rate Limit:** 3600 requests/hora por token
- **Formato:** JSON
- **Documentacao oficial:** https://docs.hetzner.cloud/

---

## Autenticacao

### Cloud API
```bash
curl -s -H "Authorization: Bearer $HETZNER_API_TOKEN" \
  https://api.hetzner.cloud/v1/servers
```

### DNS API (Header DIFERENTE)
```bash
curl -s -H "Auth-API-Token: $HETZNER_API_TOKEN" \
  https://dns.hetzner.com/api/v1/zones
```

### Criar Token
1. Acessar https://console.hetzner.cloud/
2. Ir em Security → API Tokens
3. Criar token com permissoes necessarias
4. **Read/Write** para operacoes completas
5. **Read Only** para apenas consultas
6. Salvar token em .env (NUNCA em codigo)

---

## Endpoints Completos

### Servers

```bash
# Listar todos os servidores
GET /v1/servers
# Filtros: ?name=nome&status=running&label_selector=env=prod

# Obter servidor especifico
GET /v1/servers/{id}

# Criar servidor
POST /v1/servers
{
  "name": "web-01",
  "server_type": "cx32",
  "image": "ubuntu-24.04",
  "location": "fsn1",
  "ssh_keys": ["chave-nome"],
  "firewalls": [{"firewall": 12345}],
  "networks": [67890],
  "labels": {"env": "production", "managed_by": "sleep-agent"},
  "start_after_create": true,
  "user_data": "#!/bin/bash\napt update && apt upgrade -y"
}

# Deletar servidor
DELETE /v1/servers/{id}

# Acoes de servidor
POST /v1/servers/{id}/actions/poweron
POST /v1/servers/{id}/actions/poweroff
POST /v1/servers/{id}/actions/reboot
POST /v1/servers/{id}/actions/shutdown  # graceful
POST /v1/servers/{id}/actions/reset     # forcado
POST /v1/servers/{id}/actions/rebuild   # reinstala OS
POST /v1/servers/{id}/actions/change_type  # redimensionar
POST /v1/servers/{id}/actions/enable_backup
POST /v1/servers/{id}/actions/disable_backup
POST /v1/servers/{id}/actions/create_image  # snapshot
POST /v1/servers/{id}/actions/enable_rescue
POST /v1/servers/{id}/actions/attach_to_network
POST /v1/servers/{id}/actions/detach_from_network
```

### Server Types (Planos)

```bash
# Listar tipos disponiveis
GET /v1/server_types
# Filtros: ?name=cx32

# Resposta inclui: cores, memory, disk, prices
```

**Tipos x86 (Intel/AMD):**
| Tipo | vCPU | RAM | SSD | ~EUR/mes |
|------|------|-----|-----|----------|
| CX22 | 2 | 4GB | 40GB | 3.99 |
| CX32 | 4 | 8GB | 80GB | 6.99 |
| CX42 | 8 | 16GB | 160GB | 13.99 |
| CX52 | 16 | 32GB | 320GB | 28.99 |
| CCX13 | 2 | 8GB | 80GB | 7.99 |
| CCX23 | 4 | 16GB | 160GB | 14.99 |
| CCX33 | 8 | 32GB | 240GB | 29.99 |
| CCX43 | 16 | 64GB | 360GB | 54.99 |
| CCX53 | 32 | 128GB | 600GB | 104.99 |
| CCX63 | 48 | 192GB | 960GB | 154.99 |

**Tipos ARM (Ampere):**
| Tipo | vCPU | RAM | SSD | ~EUR/mes |
|------|------|-----|-----|----------|
| CAX11 | 2 | 4GB | 40GB | 3.99 |
| CAX21 | 4 | 8GB | 80GB | 6.99 |
| CAX31 | 8 | 16GB | 160GB | 12.99 |
| CAX41 | 16 | 32GB | 320GB | 24.99 |

**ARM vs x86:** ARM e mais barato e eficiente para a maioria das cargas web/containers.
Verificar compatibilidade das imagens Docker antes de escolher ARM.

### SSH Keys

```bash
# Listar
GET /v1/ssh_keys

# Criar
POST /v1/ssh_keys
{
  "name": "deploy-key",
  "public_key": "ssh-ed25519 AAAA... deploy@machine",
  "labels": {"managed_by": "sleep-agent"}
}

# Deletar
DELETE /v1/ssh_keys/{id}
```

### Firewalls

```bash
# Listar
GET /v1/firewalls

# Criar
POST /v1/firewalls
{
  "name": "fw-producao",
  "rules": [
    {
      "direction": "in",
      "protocol": "tcp",
      "port": "2222",
      "source_ips": ["MEU_IP/32"],
      "description": "SSH"
    },
    {
      "direction": "in",
      "protocol": "tcp",
      "port": "80",
      "source_ips": ["0.0.0.0/0", "::/0"],
      "description": "HTTP"
    },
    {
      "direction": "in",
      "protocol": "tcp",
      "port": "443",
      "source_ips": ["0.0.0.0/0", "::/0"],
      "description": "HTTPS"
    }
  ],
  "apply_to": [
    {"type": "server", "server": {"id": 12345}}
  ],
  "labels": {"managed_by": "sleep-agent"}
}

# Atualizar regras
POST /v1/firewalls/{id}/actions/set_rules
{
  "rules": [...]
}

# Aplicar a servidor
POST /v1/firewalls/{id}/actions/apply_to_resources
{
  "apply_to": [{"type": "server", "server": {"id": 12345}}]
}

# Remover de servidor
POST /v1/firewalls/{id}/actions/remove_from_resources
{
  "remove_from": [{"type": "server", "server": {"id": 12345}}]
}
```

### Volumes

```bash
# Listar
GET /v1/volumes

# Criar
POST /v1/volumes
{
  "name": "data-vol",
  "size": 50,
  "location": "fsn1",
  "format": "ext4",
  "labels": {"managed_by": "sleep-agent"},
  "automount": true,
  "server": 12345
}

# Attach/Detach
POST /v1/volumes/{id}/actions/attach
{"server": 12345, "automount": true}

POST /v1/volumes/{id}/actions/detach

# Resize
POST /v1/volumes/{id}/actions/resize
{"size": 100}

# Deletar
DELETE /v1/volumes/{id}
```

### Networks (Private)

```bash
# Listar
GET /v1/networks

# Criar
POST /v1/networks
{
  "name": "rede-interna",
  "ip_range": "10.0.0.0/16",
  "subnets": [
    {
      "type": "cloud",
      "network_zone": "eu-central",
      "ip_range": "10.0.1.0/24"
    }
  ],
  "labels": {"managed_by": "sleep-agent"}
}
```

### Images/Snapshots

```bash
# Listar snapshots
GET /v1/images?type=snapshot

# Criar snapshot de servidor
POST /v1/servers/{id}/actions/create_image
{
  "description": "Backup pre-atualizacao",
  "type": "snapshot",
  "labels": {"managed_by": "sleep-agent"}
}

# Deletar snapshot
DELETE /v1/images/{id}
```

### Load Balancers

```bash
# Listar
GET /v1/load_balancers

# Criar
POST /v1/load_balancers
{
  "name": "lb-web",
  "load_balancer_type": "lb11",
  "location": "fsn1",
  "algorithm": {"type": "round_robin"},
  "services": [
    {
      "protocol": "https",
      "listen_port": 443,
      "destination_port": 80,
      "health_check": {
        "protocol": "http",
        "port": 80,
        "interval": 15,
        "timeout": 10,
        "retries": 3,
        "http": {"path": "/health", "status_codes": ["2??"]}
      }
    }
  ],
  "targets": [
    {"type": "server", "server": {"id": 12345}}
  ],
  "labels": {"managed_by": "sleep-agent"}
}
```

### Floating IPs

```bash
# Listar
GET /v1/floating_ips

# Criar
POST /v1/floating_ips
{
  "type": "ipv4",
  "home_location": "fsn1",
  "labels": {"managed_by": "sleep-agent"}
}

# Atribuir a servidor
POST /v1/floating_ips/{id}/actions/assign
{"server": 12345}

# Desatribuir
POST /v1/floating_ips/{id}/actions/unassign
```

---

## DNS API

**Base URL diferente:** `https://dns.hetzner.com/api/v1`
**Header diferente:** `Auth-API-Token` (nao `Authorization: Bearer`)

```bash
# Listar zonas
GET /zones

# Criar zona
POST /zones
{"name": "dominio.com", "ttl": 86400}

# Listar registros de uma zona
GET /records?zone_id=ZONE_ID

# Criar registro
POST /records
{
  "zone_id": "ZONE_ID",
  "type": "A",
  "name": "@",
  "value": "IP_SERVIDOR",
  "ttl": 300
}

# Tipos comuns
# A     - IPv4
# AAAA  - IPv6
# CNAME - Alias
# MX    - Email
# TXT   - Verificacao/SPF/DKIM
# NS    - Nameserver
```

---

## Tratamento de Erros

| Status | Significado | Acao |
|--------|-------------|------|
| 200 | Sucesso | Prosseguir |
| 201 | Criado | Recurso criado com sucesso |
| 204 | Sem conteudo | Operacao OK (delete, por exemplo) |
| 400 | Bad Request | Verificar payload |
| 401 | Unauthorized | Token invalido/expirado |
| 403 | Forbidden | Token sem permissao |
| 404 | Not Found | Recurso nao existe |
| 409 | Conflict | Nome ja em uso |
| 422 | Unprocessable | Parametros invalidos |
| 429 | Rate Limited | Aguardar (3600 req/h) |
| 500 | Server Error | Problema da Hetzner |
| 503 | Service Unavailable | API temporariamente fora |

### Backoff Exponencial
```bash
# Padrao de retry
RETRY=0
MAX_RETRY=5
while [ $RETRY -lt $MAX_RETRY ]; do
  RESPONSE=$(curl -s -w "\n%{http_code}" ...)
  HTTP_CODE=$(echo "$RESPONSE" | tail -1)

  if [ "$HTTP_CODE" = "429" ] || [ "$HTTP_CODE" = "503" ]; then
    WAIT=$((2 ** RETRY))
    echo "Rate limited. Aguardando ${WAIT}s..."
    sleep $WAIT
    RETRY=$((RETRY + 1))
  else
    break
  fi
done
```

---

## Custos Adicionais

| Recurso | Custo |
|---------|-------|
| Trafego de saida | 1 EUR/TB (apos 20TB gratis) |
| Snapshot | 0.0119 EUR/GB/mes |
| Backup automatico | 20% do preco do servidor |
| Volume | 0.0524 EUR/GB/mes |
| Floating IP | 3.57 EUR/mes (se nao atribuido) |
| Load Balancer LB11 | 6.41 EUR/mes |
| Private Network | Gratuito |

---

## Localizacoes

| ID | Cidade | Pais | Network Zone |
|----|--------|------|--------------|
| fsn1 | Falkenstein | Alemanha | eu-central |
| nbg1 | Nuremberg | Alemanha | eu-central |
| hel1 | Helsinki | Finlandia | eu-central |
| ash | Ashburn | EUA | us-east |
| hil | Hillsboro | EUA | us-west |
| sin | Singapura | Singapura | ap-southeast |

**Recomendacao:** Para publico brasileiro, `ash` (EUA Leste) oferece melhor latencia.
Para publico europeu, `fsn1` ou `nbg1`.
