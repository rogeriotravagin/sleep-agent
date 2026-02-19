# Tool Registry - Inventario Centralizado de Ferramentas

O Tool Registry e o catalogo central de TODAS as ferramentas disponiveis no Sleep Agent: APIs externas, scripts locais e ferramentas internas. Permite que agentes descubram e usem ferramentas sem precisar saber onde estao.

---

## Por que um Registro Central?

No v4, cada extensao gerenciava suas proprias ferramentas. O agente de Customer Success sabia usar a API do ActiveCampaign, mas o agente de Marketing nao sabia que ela existia. Resultado: duplicacao, ferramentas nao descobertas e integracao manual.

O Tool Registry resolve isso:

- **Inventario unico** de todas as ferramentas
- **Descoberta por capacidade** ("preciso enviar email" -> Mautic)
- **Validacao de credenciais** (ferramenta disponivel ou nao?)
- **Compartilhamento entre extensoes** (uma ferramenta, varios usuarios)

---

## Tipos de Ferramenta

| Tipo | Descricao | Exemplos |
|------|-----------|----------|
| `api` | APIs externas com autenticacao | ActiveCampaign, Curseduca, Mautic |
| `script` | Scripts locais executaveis | Python, Bash |
| `interno` | Capacidades internas do sistema | Gerador HTML, templates |

---

## Como Funciona

### 1. Registro

Cada ferramenta e registrada em `registry.yaml` com:
- **ID unico** para referencia
- **Tipo** (api, script, interno)
- **Categoria** (crm, email_marketing, automacao, etc.)
- **Capacidades** (lista do que consegue fazer)
- **Autenticacao** (como se autentica)
- **Disponibilidade** (credenciais configuradas?)

### 2. Descoberta

Quando um agente precisa de uma capacidade, o registry busca:

```
Agente: "Preciso enviar email marketing"
Registry: "Mautic tem a capacidade 'criar_email' e 'enviar_campanha'"
Agente: "Mautic esta disponivel?"
Registry: "Sim, credenciais configuradas no .env"
```

### 3. Validacao

O registry verifica se as credenciais existem no `.env`:
- Se existem: `disponivel: true`
- Se nao existem: `disponivel: false` + alerta

---

## Descoberta Dinamica

Alem do registro manual, o Tool Registry descobre ferramentas automaticamente:

### Ao Carregar Extensao
1. Escaneia `extensao/ferramentas/` (se existir)
2. Registra novas ferramentas encontradas
3. Valida credenciais
4. Atualiza disponibilidade

### Ao Executar Tarefa
1. Agente solicita capacidade
2. Registry busca ferramentas com essa capacidade
3. Retorna lista ordenada por relevancia
4. Agente seleciona e usa

### Ao Configurar .env
1. Detecta novas variaveis de ambiente
2. Reavalia disponibilidade de ferramentas
3. Atualiza status no registry

---

## Busca por Capacidade

O registry suporta busca por capacidade natural:

| Pedido do agente | Ferramenta encontrada | Capacidade |
|------------------|-----------------------|------------|
| "enviar email" | Mautic | `criar_email`, `enviar_campanha` |
| "buscar contato" | ActiveCampaign | `buscar_contato` |
| "ver progresso do aluno" | Curseduca | `ver_progresso` |
| "enviar WhatsApp" | UazAPI | `enviar_mensagem` |
| "gerar landing page" | Gerador HTML | `gerar_landing_page` |

---

## Validacao de Credenciais

O registry verifica disponibilidade automaticamente:

```yaml
# Exemplo de validacao
ferramenta: activecampaign
env_vars_necessarias:
  - ACTIVECAMPAIGN_API_KEY
  - ACTIVECAMPAIGN_URL
status:
  ACTIVECAMPAIGN_API_KEY: encontrada
  ACTIVECAMPAIGN_URL: encontrada
disponivel: true
```

Se alguma variavel estiver faltando:

```yaml
ferramenta: hotmart
env_vars_necessarias:
  - HOTMART_CLIENT_ID
  - HOTMART_CLIENT_SECRET
status:
  HOTMART_CLIENT_ID: NAO encontrada
  HOTMART_CLIENT_SECRET: NAO encontrada
disponivel: false
motivo: "Credenciais nao configuradas no .env"
```

---

## Integracao com o Sistema

### Com o Orquestrador
- O orquestrador consulta o registry ao identificar necessidade de ferramenta
- Inclui ferramentas disponiveis no contexto do agente

### Com o Context Manager
- Ferramentas sao carregadas no Nivel 2 (agente) ou Nivel 3 (profundo)
- Nao carrega todas, apenas as relevantes para a tarefa

### Com o Blackboard
- Status de ferramentas usadas na sessao e registrado no blackboard
- Permite rastreabilidade de quais APIs foram chamadas

### Com a Constituicao
- Artigo III (Privacidade): NUNCA expor credenciais em outputs
- Registry garante que credenciais sao referenciadas por env_var, nunca por valor

---

## Arquivos de Configuracao

| Arquivo | Funcao |
|---------|--------|
| `kernel/tool-registry/TOOL-REGISTRY.md` | Este documento |
| `kernel/tool-registry/registry.yaml` | Inventario de ferramentas |
| `kernel/tool-registry/discovery.yaml` | Regras de descoberta dinamica |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/ferramentas` | Lista todas as ferramentas registradas |
| `/ferramentas disponiveis` | Lista apenas ferramentas com credenciais validas |
| `/ferramentas buscar {capacidade}` | Busca ferramenta por capacidade |
