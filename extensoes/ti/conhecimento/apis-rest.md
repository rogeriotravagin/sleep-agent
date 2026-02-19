# APIs REST - Fundamentos

## O Que é uma API REST?

**Para não-técnicos:** Uma API é como um garçom em um restaurante. Você (o cliente) pede algo ao garçom (API), ele leva o pedido para a cozinha (servidor), e traz de volta o que você pediu.

**Tecnicamente:** API REST (Representational State Transfer) é um padrão arquitetural para criar serviços web que permite que diferentes sistemas se comuniquem via HTTP.

## Conceitos Fundamentais

### 1. Endpoints

Um **endpoint** é um endereço específico onde você pode acessar um recurso.

**Analogia:** Como endereços de diferentes departamentos numa empresa:
- `/users` - Departamento de usuários
- `/products` - Departamento de produtos
- `/orders` - Departamento de pedidos

**Exemplo:**
```
https://api.example.com/users
https://api.example.com/products/123
https://api.example.com/orders?status=pending
```

### 2. Métodos HTTP (Verbos)

Os métodos HTTP dizem o que queremos fazer com um recurso.

| Método | O Que Faz | Analogia |
|--------|-----------|----------|
| **GET** | Buscar/Ler dados | Pedir para ver um documento |
| **POST** | Criar novo recurso | Adicionar novo arquivo na pasta |
| **PUT** | Atualizar recurso completo | Substituir documento inteiro |
| **PATCH** | Atualizar parte do recurso | Editar só uma página do documento |
| **DELETE** | Deletar recurso | Jogar documento no lixo |

**Exemplos:**
```http
GET /users/123          # Buscar usuário com ID 123
POST /users             # Criar novo usuário
PUT /users/123          # Atualizar usuário 123 completamente
PATCH /users/123        # Atualizar apenas alguns campos do usuário 123
DELETE /users/123       # Deletar usuário 123
```

### 3. Request (Requisição)

É o pedido que você faz para a API.

**Componentes:**
- **URL:** Onde você está fazendo o pedido
- **Método:** O que você quer fazer (GET, POST, etc)
- **Headers:** Informações extras (autenticação, tipo de conteúdo)
- **Body:** Dados que você está enviando (em POST, PUT, PATCH)

**Exemplo de requisição POST:**
```http
POST https://api.example.com/users
Content-Type: application/json
Authorization: Bearer SEU_TOKEN

{
  "name": "João Silva",
  "email": "joao@example.com",
  "age": 30
}
```

### 4. Response (Resposta)

É o que a API retorna para você.

**Componentes:**
- **Status Code:** Código que indica o resultado
- **Headers:** Informações sobre a resposta
- **Body:** Os dados retornados

**Exemplo de resposta bem-sucedida:**
```http
200 OK
Content-Type: application/json

{
  "id": 123,
  "name": "João Silva",
  "email": "joao@example.com",
  "age": 30,
  "created_at": "2026-02-02T10:30:00Z"
}
```

### 5. Status Codes (Códigos de Status)

Códigos que indicam o resultado da requisição.

| Código | Significado | Analogia |
|--------|-------------|----------|
| **2xx** | Sucesso | ✅ "Deu tudo certo!" |
| 200 | OK | Pedido processado com sucesso |
| 201 | Created | Novo recurso criado |
| 204 | No Content | Sucesso, mas sem dados para retornar |
| **3xx** | Redirecionamento | 🔀 "Vá para outro lugar" |
| 301 | Moved Permanently | Recurso mudou de endereço |
| **4xx** | Erro do cliente | ❌ "Você fez algo errado" |
| 400 | Bad Request | Pedido malformado |
| 401 | Unauthorized | Precisa fazer login |
| 403 | Forbidden | Não tem permissão |
| 404 | Not Found | Recurso não existe |
| 429 | Too Many Requests | Muitas requisições (rate limit) |
| **5xx** | Erro do servidor | 💥 "Nosso sistema deu problema" |
| 500 | Internal Server Error | Erro genérico no servidor |
| 503 | Service Unavailable | Servidor temporariamente fora |

## Autenticação

Como a API sabe quem você é e se pode acessar os dados.

### 1. API Key

**O que é:** Uma chave única que identifica você.

**Analogia:** Como uma carteirinha de clube - mostra que você é membro.

**Exemplo:**
```http
GET /users
X-API-Key: abc123def456ghi789
```

### 2. Bearer Token (JWT)

**O que é:** Um token temporário que você recebe após fazer login.

**Analogia:** Como um ingresso de cinema - vale por tempo limitado.

**Exemplo:**
```http
GET /users
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 3. OAuth 2.0

**O que é:** Sistema onde você autoriza um app a acessar seus dados em outro serviço.

**Analogia:** Como quando você faz "Login com Google" em um site.

**Fluxo:**
1. Você clica "Autorizar"
2. É redirecionado para login do serviço (ex: Google)
3. Você aprova o acesso
4. Recebe um token de volta
5. Usa o token para fazer requisições

### 4. Basic Auth

**O que é:** Enviar usuário e senha em cada requisição.

**Analogia:** Como mostrar RG toda vez que entra no prédio.

**Exemplo:**
```http
GET /users
Authorization: Basic dXNlcjpwYXNzd29yZA==
```

*Nota: Não recomendado para produção, apenas desenvolvimento*

## Formato de Dados: JSON

A maioria das APIs REST usam JSON (JavaScript Object Notation) para trocar dados.

**Estrutura básica:**
```json
{
  "chave": "valor",
  "nome": "João",
  "idade": 30,
  "ativo": true,
  "tags": ["cliente", "premium"],
  "endereco": {
    "rua": "Av. Principal",
    "numero": 123
  }
}
```

**Tipos de dados:**
- **String:** Texto entre aspas `"texto"`
- **Number:** Número `123` ou `12.45`
- **Boolean:** `true` ou `false`
- **Array:** Lista `[1, 2, 3]`
- **Object:** Objeto aninhado `{"chave": "valor"}`
- **null:** Valor nulo

## Conceitos Importantes

### Rate Limiting

**O que é:** Limite de quantas requisições você pode fazer em um período.

**Por quê:** Prevenir abuso e garantir que servidor não sobrecarregue.

**Exemplo:** "100 requisições por hora"

**Como tratar:**
```python
# Se receber 429 (Too Many Requests)
if response.status_code == 429:
    retry_after = response.headers.get('Retry-After', 60)
    print(f"Rate limit atingido. Aguardando {retry_after} segundos...")
    time.sleep(retry_after)
    # Tentar novamente
```

### Paginação

**O que é:** Quando há muitos dados, a API retorna em "páginas".

**Por quê:** Evitar transferir dados demais de uma vez.

**Exemplo:**
```http
GET /users?page=1&limit=20
GET /users?page=2&limit=20
```

**Resposta típica:**
```json
{
  "data": [...],  // 20 usuários
  "pagination": {
    "current_page": 1,
    "total_pages": 5,
    "total_items": 100,
    "per_page": 20
  }
}
```

### Query Parameters

**O que é:** Filtros e opções adicionados na URL.

**Sintaxe:** Depois do `?` na URL, separados por `&`

**Exemplos:**
```http
GET /users?status=active                    # Filtrar por status
GET /products?category=electronics&min_price=100  # Múltiplos filtros
GET /orders?sort=date&order=desc            # Ordenação
GET /users?search=joão                      # Busca
```

### Idempotência

**O que é:** Fazer a mesma requisição múltiplas vezes tem o mesmo efeito.

| Método | Idempotente? | Explicação |
|--------|--------------|------------|
| GET | ✅ Sim | Ler não muda nada |
| POST | ❌ Não | Cria novo recurso a cada vez |
| PUT | ✅ Sim | Substitui sempre com mesmos dados |
| DELETE | ✅ Sim | Deletar algo já deletado não muda nada |

## Exemplo Completo em Python

```python
import requests
import json

# Configuração
BASE_URL = "https://api.example.com"
API_KEY = "sua_chave_aqui"

headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

# GET - Buscar usuários
response = requests.get(
    f"{BASE_URL}/users",
    headers=headers,
    params={"status": "active"}
)

if response.status_code == 200:
    users = response.json()
    print(f"✅ {len(users)} usuários encontrados")
else:
    print(f"❌ Erro: {response.status_code}")

# POST - Criar novo usuário
new_user = {
    "name": "Maria Silva",
    "email": "maria@example.com",
    "role": "user"
}

response = requests.post(
    f"{BASE_URL}/users",
    headers=headers,
    json=new_user
)

if response.status_code == 201:
    created_user = response.json()
    print(f"✅ Usuário criado com ID: {created_user['id']}")
else:
    print(f"❌ Erro ao criar: {response.status_code}")
    print(response.text)

# PUT - Atualizar usuário
user_id = 123
updated_data = {
    "name": "Maria Silva Santos",
    "email": "maria.santos@example.com",
    "role": "admin"
}

response = requests.put(
    f"{BASE_URL}/users/{user_id}",
    headers=headers,
    json=updated_data
)

if response.status_code == 200:
    print("✅ Usuário atualizado")
else:
    print(f"❌ Erro ao atualizar: {response.status_code}")

# DELETE - Deletar usuário
response = requests.delete(
    f"{BASE_URL}/users/{user_id}",
    headers=headers
)

if response.status_code == 204:
    print("✅ Usuário deletado")
else:
    print(f"❌ Erro ao deletar: {response.status_code}")
```

## Boas Práticas

### 1. Sempre Trate Erros
```python
try:
    response = requests.get(url, timeout=30)
    response.raise_for_status()  # Lança exceção se status 4xx ou 5xx
    data = response.json()
except requests.Timeout:
    print("❌ Requisição demorou demais")
except requests.ConnectionError:
    print("❌ Erro de conexão")
except requests.HTTPError as e:
    print(f"❌ Erro HTTP: {e}")
```

### 2. Use Timeout
```python
# Sempre defina timeout para evitar requisições travadas
response = requests.get(url, timeout=30)  # 30 segundos
```

### 3. Respeite Rate Limits
```python
import time

for item in items:
    make_api_request(item)
    time.sleep(1)  # Aguardar 1 segundo entre requisições
```

### 4. Use Sessões para Múltiplas Requisições
```python
session = requests.Session()
session.headers.update({"Authorization": f"Bearer {token}"})

# Reutiliza conexão TCP
response1 = session.get(f"{BASE_URL}/users")
response2 = session.get(f"{BASE_URL}/products")
```

### 5. Log Requisições (sem dados sensíveis)
```python
import logging

logging.info(f"GET {url}")
logging.info(f"Status: {response.status_code}")
# NÃO logar tokens, senhas, ou dados sensíveis
```

## Glossary (Glossário)

- **API:** Application Programming Interface - Interface de Programação de Aplicações
- **Endpoint:** URL específica onde se acessa um recurso
- **Payload:** Dados enviados no body da requisição
- **Header:** Cabeçalho com metadados da requisição/resposta
- **Token:** Chave temporária de autenticação
- **Rate Limit:** Limite de requisições por período
- **Timeout:** Tempo máximo de espera por resposta
- **JSON:** Formato de dados estruturado em texto
- **CRUD:** Create, Read, Update, Delete - operações básicas

## Recursos Adicionais

- **Testar APIs:** Postman, Insomnia, Thunder Client
- **Documentação:** Swagger/OpenAPI
- **HTTP Status Codes:** https://httpstatuses.com
- **JSON Validator:** https://jsonlint.com
