# Memory Bus - Comunicacao entre Agentes

## O que e

O Memory Bus e o sistema de comunicacao estruturada entre agentes do Sleep Agent. Ele garante que quando um agente transfere trabalho para outro, todo o contexto e passado de forma organizada, sem perda de informacao.

---

## Problema que Resolve

Antes (v4):
```
Estrategista termina pesquisa
→ Orquestrador diz "agora vou chamar o Copywriter"
→ Copywriter nao sabe o que o Estrategista descobriu
→ Copywriter pergunta tudo de novo ao usuario
```

Depois (v5):
```
Estrategista termina pesquisa
→ Preenche handoff estruturado com tudo que descobriu
→ Atualiza o blackboard
→ Copywriter recebe handoff + le blackboard
→ Copywriter trabalha sem fazer perguntas redundantes
```

---

## Tipos de Mensagem

### 1. Handoff (Transferencia de Tarefa)

Quando um agente passa trabalho para outro. Tipo mais comum.

```yaml
tipo: handoff
de: "agente_origem"
para: "agente_destino"
# Ver template completo em handoff-template.yaml
```

### 2. Request (Pedido entre Agentes)

Quando um agente precisa de informacao de outro sem transferir a tarefa.

```yaml
tipo: request
de: "copywriter"
para: "estrategista"
payload:
  acao: "obter_tom_de_voz"
  contexto: "Criando email de vendas, preciso do tom definido"
# Requer resposta do agente destino
```

### 3. Notify (Aviso sem Resposta)

Quando um agente quer avisar outros sobre algo, sem esperar resposta.

```yaml
tipo: notify
de: "designer"
para: "broadcast"  # todos os agentes
payload:
  acao: "paleta_atualizada"
  dados:
    primaria: "#1a1a2e"
    accent: "#e94560"
# Nao requer resposta
```

---

## Como Usar

### Ao Finalizar uma Tarefa que Continua com Outro Agente

1. Preencher handoff usando o template (`handoff-template.yaml`)
2. Atualizar o blackboard (`workspace/.state/blackboard.yaml`)
3. Orquestrador carrega handoff + blackboard para o proximo agente

### Ao Precisar de Informacao de Outro Agente

1. Primeiro: verificar o blackboard (pode ja ter a info)
2. Se nao tiver: criar request para o agente que tem
3. Aguardar resposta e continuar

### Ao Atualizar Algo que Outros Agentes Usam

1. Atualizar o blackboard
2. Enviar notify para broadcast

---

## Regras

1. **Blackboard primeiro** - Sempre verificar o blackboard antes de pedir info
2. **Handoff obrigatorio** - Toda transicao entre agentes DEVE ter handoff
3. **Nunca narrativo** - Contexto e estruturado (YAML), nao texto livre
4. **Idempotente** - Ler o handoff 2x deve dar o mesmo resultado
5. **Timestamp obrigatorio** - Toda mensagem tem data/hora
