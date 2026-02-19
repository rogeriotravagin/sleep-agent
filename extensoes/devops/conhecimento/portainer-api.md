# Portainer API - Base de Conhecimento

## Visao Geral

- **Base URL:** `{PORTAINER_URL}/api`
- **Autenticacao:** JWT via `/api/auth`
- **Formato:** JSON
- **JWT Expira:** 8 horas (padrao)
- **Documentacao oficial:** https://docs.portainer.io/api/access

---

## Autenticacao

### Obter JWT Token
```bash
JWT=$(curl -s -X POST "$PORTAINER_URL/api/auth" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$PORTAINER_USER\",\"password\":\"$PORTAINER_PASSWORD\"}" \
  | jq -r '.jwt')

# Verificar
if [ "$JWT" = "null" ] || [ -z "$JWT" ]; then
  echo "ERRO: Autenticacao falhou"
  exit 1
fi
echo "OK: Autenticado"
```

### Usar em Chamadas
```bash
curl -s -H "Authorization: Bearer $JWT" \
  "$PORTAINER_URL/api/endpoints"
```

### API Key (Alternativa ao JWT)
Portainer 2.19+ suporta API Keys que nao expiram:
1. Acessar Portainer → My Account → Access Tokens
2. Criar API Key
3. Usar header: `X-API-Key: {API_KEY}`

```bash
curl -s -H "X-API-Key: $PORTAINER_API_TOKEN" \
  "$PORTAINER_URL/api/endpoints"
```

---

## Endpoints Completos

### System

```bash
# Status do Portainer
GET /api/status
# Resposta: {Version, InstanceID}

# Versao
GET /api/status/version
```

### Endpoints (Environments)

Cada endpoint representa um Docker environment (standalone ou Swarm).

```bash
# Listar endpoints
GET /api/endpoints
# Resposta: [{Id, Name, Type, URL, Status}]

# Obter endpoint especifico
GET /api/endpoints/{id}

# Tipos:
# 1 = Docker local
# 2 = Docker Agent
# 3 = Azure ACI
# 4 = Edge Agent
# 5 = Edge Agent (Async)
```

**IMPORTANTE:** O `endpointId` e necessario para todas as operacoes Docker.

### Stacks

```bash
# Listar todas as stacks
GET /api/stacks
# Resposta: [{Id, Name, Type, Status, CreationDate, Env, EndpointId}]

# Obter stack especifica
GET /api/stacks/{id}

# Obter compose file de uma stack
GET /api/stacks/{id}/file
# Resposta: {StackFileContent: "version: '3.8'\nservices:..."}

# Criar stack (Swarm - string)
POST /api/stacks/create/swarm/string?endpointId={eid}
{
  "name": "minha-stack",
  "stackFileContent": "version: '3.8'\nservices:\n  app:\n    image: app:1.0",
  "swarmID": "swarm-cluster-id",
  "env": [
    {"name": "VAR1", "value": "valor1"},
    {"name": "VAR2", "value": "valor2"}
  ]
}

# Criar stack (Swarm - repositorio)
POST /api/stacks/create/swarm/repository?endpointId={eid}
{
  "name": "minha-stack",
  "repositoryURL": "https://github.com/user/repo",
  "repositoryReferenceName": "refs/heads/main",
  "composeFile": "docker-compose.yaml",
  "swarmID": "swarm-cluster-id",
  "env": [...]
}

# Criar stack (Standalone - string)
POST /api/stacks/create/standalone/string?endpointId={eid}
{
  "name": "minha-stack",
  "stackFileContent": "...",
  "env": [...]
}

# Atualizar stack
PUT /api/stacks/{id}?endpointId={eid}
{
  "stackFileContent": "novo compose...",
  "env": [...],
  "prune": true,
  "pullImage": true
}

# Deletar stack
DELETE /api/stacks/{id}?endpointId={eid}
# Query params opcionais: external=true (stack nao gerenciada pelo Portainer)

# Parar stack
POST /api/stacks/{id}/stop?endpointId={eid}

# Iniciar stack
POST /api/stacks/{id}/start?endpointId={eid}
```

### Docker Proxy (via Portainer)

Portainer age como proxy para a API Docker. Prefixe com `/api/endpoints/{endpointId}/docker/`.

#### Containers

```bash
# Listar containers
GET /api/endpoints/{eid}/docker/containers/json
# Query params: all=true (inclui parados), filters={"status":["running"]}

# Inspecionar container
GET /api/endpoints/{eid}/docker/containers/{id}/json

# Logs do container
GET /api/endpoints/{eid}/docker/containers/{id}/logs?stdout=true&stderr=true&tail=100

# Stats do container (uso CPU/RAM)
GET /api/endpoints/{eid}/docker/containers/{id}/stats?stream=false

# Parar container
POST /api/endpoints/{eid}/docker/containers/{id}/stop

# Iniciar container
POST /api/endpoints/{eid}/docker/containers/{id}/start

# Reiniciar container
POST /api/endpoints/{eid}/docker/containers/{id}/restart

# Remover container
DELETE /api/endpoints/{eid}/docker/containers/{id}?force=true
```

#### Services (Swarm)

```bash
# Listar services
GET /api/endpoints/{eid}/docker/services

# Inspecionar service
GET /api/endpoints/{eid}/docker/services/{id}

# Criar service
POST /api/endpoints/{eid}/docker/services/create
{
  "Name": "meu-service",
  "TaskTemplate": {
    "ContainerSpec": {
      "Image": "app:1.0",
      "Env": ["VAR=valor"]
    },
    "Resources": {
      "Limits": {"MemoryBytes": 536870912, "NanoCPUs": 1000000000},
      "Reservations": {"MemoryBytes": 268435456}
    }
  },
  "Mode": {
    "Replicated": {"Replicas": 2}
  },
  "Networks": [{"Target": "network-id"}]
}

# Atualizar service (escalar, mudar imagem, etc)
POST /api/endpoints/{eid}/docker/services/{id}/update?version={version}
# Body: service spec completa com alteracoes

# Logs do service
GET /api/endpoints/{eid}/docker/services/{id}/logs?stdout=true&stderr=true&tail=100

# Deletar service
DELETE /api/endpoints/{eid}/docker/services/{id}
```

#### Tasks (Instancias de Services)

```bash
# Listar tasks
GET /api/endpoints/{eid}/docker/tasks
# Filtros: filters={"service":["service-id"],"desired-state":["running"]}

# Inspecionar task
GET /api/endpoints/{eid}/docker/tasks/{id}

# Estados de task:
# new, pending, assigned, accepted, ready, preparing, starting,
# running, complete, shutdown, failed, rejected, orphaned, remove
```

#### Networks

```bash
# Listar networks
GET /api/endpoints/{eid}/docker/networks

# Criar overlay network
POST /api/endpoints/{eid}/docker/networks/create
{
  "Name": "minha-rede",
  "Driver": "overlay",
  "Attachable": true,
  "Internal": false,
  "Labels": {"managed_by": "sleep-agent"}
}

# Remover network
DELETE /api/endpoints/{eid}/docker/networks/{id}
```

#### Volumes

```bash
# Listar volumes
GET /api/endpoints/{eid}/docker/volumes

# Criar volume
POST /api/endpoints/{eid}/docker/volumes/create
{
  "Name": "meu-volume",
  "Driver": "local",
  "Labels": {"managed_by": "sleep-agent"}
}

# Inspecionar volume
GET /api/endpoints/{eid}/docker/volumes/{name}

# Remover volume
DELETE /api/endpoints/{eid}/docker/volumes/{name}
# ATENCAO: Remover volume APAGA todos os dados nele
```

#### Images

```bash
# Listar images
GET /api/endpoints/{eid}/docker/images/json

# Pull image
POST /api/endpoints/{eid}/docker/images/create?fromImage=nginx&tag=1.25

# Remover image
DELETE /api/endpoints/{eid}/docker/images/{name}
```

#### Swarm

```bash
# Info do swarm
GET /api/endpoints/{eid}/docker/swarm
# Resposta: {ID, JoinTokens, Spec, ...}

# Listar nodes
GET /api/endpoints/{eid}/docker/nodes

# Info de um node
GET /api/endpoints/{eid}/docker/nodes/{id}
```

---

## Padroes de Uso

### Deploy Completo de Stack

```bash
#!/bin/bash
# deploy-stack.sh

STACK_NAME=$1
COMPOSE_FILE=$2
ENDPOINT_ID=${3:-1}

# 1. Autenticar
JWT=$(curl -s -X POST "$PORTAINER_URL/api/auth" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$PORTAINER_USER\",\"password\":\"$PORTAINER_PASSWORD\"}" \
  | jq -r '.jwt')

# 2. Verificar se stack ja existe
EXISTING=$(curl -s -H "Authorization: Bearer $JWT" \
  "$PORTAINER_URL/api/stacks" | \
  jq -r ".[] | select(.Name==\"$STACK_NAME\") | .Id")

if [ -n "$EXISTING" ]; then
  echo "Stack '$STACK_NAME' ja existe (ID: $EXISTING)"
  echo "Use atualizar ao inves de criar."
  exit 1
fi

# 3. Obter Swarm ID
SWARM_ID=$(curl -s -H "Authorization: Bearer $JWT" \
  "$PORTAINER_URL/api/endpoints/$ENDPOINT_ID/docker/swarm" | jq -r '.ID')

# 4. Ler compose file
COMPOSE_CONTENT=$(cat "$COMPOSE_FILE")

# 5. Criar stack
RESULT=$(curl -s -X POST \
  "$PORTAINER_URL/api/stacks/create/swarm/string?endpointId=$ENDPOINT_ID" \
  -H "Authorization: Bearer $JWT" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg name "$STACK_NAME" \
    --arg content "$COMPOSE_CONTENT" \
    --arg swarm "$SWARM_ID" \
    '{name: $name, stackFileContent: $content, swarmID: $swarm, env: []}'
  )")

# 6. Verificar resultado
STACK_ID=$(echo $RESULT | jq -r '.Id // empty')
if [ -n "$STACK_ID" ]; then
  echo "Stack criada com sucesso! ID: $STACK_ID"
else
  echo "ERRO ao criar stack:"
  echo $RESULT | jq '.'
  exit 1
fi
```

### Monitoramento de Saude

```bash
#!/bin/bash
# health-check-portainer.sh

ENDPOINT_ID=${1:-1}

# Autenticar
JWT=$(curl -s -X POST "$PORTAINER_URL/api/auth" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$PORTAINER_USER\",\"password\":\"$PORTAINER_PASSWORD\"}" \
  | jq -r '.jwt')

echo "=== Health Check Portainer - $(date) ==="

# Services e suas replicas
curl -s -H "Authorization: Bearer $JWT" \
  "$PORTAINER_URL/api/endpoints/$ENDPOINT_ID/docker/services" | \
  jq -r '.[] | "\(.Spec.Name)\t\(.Spec.Mode.Replicated.Replicas // "global") replicas"' | \
  column -t

echo ""
echo "=== Tasks com Problemas ==="

# Tasks que nao estao running
curl -s -H "Authorization: Bearer $JWT" \
  "$PORTAINER_URL/api/endpoints/$ENDPOINT_ID/docker/tasks" | \
  jq -r '.[] | select(.Status.State != "running" and .Status.State != "complete" and .Status.State != "shutdown") |
  "\(.Spec.ContainerSpec.Image)\t\(.Status.State)\t\(.Status.Err // "sem erro")"' | \
  column -t

echo ""
echo "==========================="
```

---

## Tratamento de Erros

| Status | Significado | Acao |
|--------|-------------|------|
| 200 | Sucesso | OK |
| 204 | Sem conteudo | OK (delete) |
| 400 | Bad Request | Verificar payload |
| 401 | Unauthorized | JWT expirado, re-autenticar |
| 403 | Forbidden | Usuario sem permissao |
| 404 | Not Found | Recurso/endpoint nao existe |
| 409 | Conflict | Nome ja em uso |
| 500 | Server Error | Problema no Portainer |

### Re-autenticacao Automatica
```bash
# Funcao helper
portainer_request() {
  local METHOD=$1
  local ENDPOINT=$2
  local DATA=$3

  RESPONSE=$(curl -s -w "\n%{http_code}" -X $METHOD \
    -H "Authorization: Bearer $JWT" \
    -H "Content-Type: application/json" \
    ${DATA:+-d "$DATA"} \
    "$PORTAINER_URL$ENDPOINT")

  HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  BODY=$(echo "$RESPONSE" | head -n -1)

  if [ "$HTTP_CODE" = "401" ]; then
    echo "JWT expirado, re-autenticando..." >&2
    JWT=$(curl -s -X POST "$PORTAINER_URL/api/auth" \
      -H "Content-Type: application/json" \
      -d "{\"username\":\"$PORTAINER_USER\",\"password\":\"$PORTAINER_PASSWORD\"}" \
      | jq -r '.jwt')

    RESPONSE=$(curl -s -X $METHOD \
      -H "Authorization: Bearer $JWT" \
      -H "Content-Type: application/json" \
      ${DATA:+-d "$DATA"} \
      "$PORTAINER_URL$ENDPOINT")
    echo "$RESPONSE"
  else
    echo "$BODY"
  fi
}
```

---

## Seguranca

### Protecao de Credenciais
- NUNCA expor PORTAINER_URL publicamente sem autenticacao
- Usar HTTPS obrigatoriamente
- Rotacionar senhas periodicamente
- Usar API Keys quando possivel (nao expiram, mas podem ser revogadas)
- Limitar acessos por role (admin vs user)

### Roles do Portainer
| Role | Pode Fazer |
|------|-----------|
| Admin | Tudo |
| User | Gerenciar recursos atribuidos |
| Read-only | Apenas visualizar |
| Endpoint Admin | Gerenciar endpoint especifico |

### Audit Log (Portainer Business)
Portainer Business Edition tem audit log nativo. Na Community Edition,
implementar logging manual nas chamadas de API.
