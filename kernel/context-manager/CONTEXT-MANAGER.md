# Context Manager - Gerenciamento Inteligente de Contexto

O Context Manager controla O QUE carregar e QUANDO carregar, evitando sobrecarga de contexto e garantindo que cada agente receba apenas o que precisa.

---

## Por que Carregamento Progressivo?

No v4, cada tarefa carregava TUDO: identidade, extensao, agente, conhecimento, memoria. Isso desperdicava contexto em tarefas simples e sobrecarregava tarefas complexas com informacao irrelevante.

O Context Manager resolve isso com **4 niveis de carregamento sob demanda**:

| Nivel | O que carrega | Quando | Peso estimado |
|-------|---------------|--------|---------------|
| 0 - Kernel | CLAUDE.md + blackboard + constituicao | Sempre | ~3KB |
| 1 - Extensao | CLAUDE.md da extensao + delegacao | Ao identificar extensao | ~2KB |
| 2 - Agente | Instrucoes do agente + conhecimento relevante | Ao delegar tarefa | ~5KB |
| 3 - Profundo | Conhecimento adicional, frameworks, exemplos | Sob demanda do agente | Variavel |

---

## Nivel 0: Kernel (Permanente)

Sempre carregado, independente da tarefa.

**Arquivos:**
- `.claude/CLAUDE.md` - Identidade e regras do sistema
- `workspace/.state/blackboard.yaml` - Estado compartilhado
- `kernel/constitution/constitution.yaml` - Regras imutaveis

**Peso:** ~3KB

**Motivo:** O sistema precisa saber QUEM ele e, QUAL o estado atual e QUAIS regras nunca podem ser violadas.

---

## Nivel 1: Extensao (Sob Demanda)

Carregado quando o usuario pede algo que exige uma extensao especifica.

**Arquivos:**
- `extensoes/{nome}/.claude/CLAUDE.md` - Instrucoes da extensao
- `extensoes/{nome}/core/orquestrador/delegacao.yaml` - Regras de delegacao

**Peso:** ~2KB por extensao

**Trigger:** Usuario pede tarefa que ativa matching de extensao.

**Descarregamento:** Quando muda para outra extensao, a anterior e descarregada (a menos que haja handoff ativo).

---

## Nivel 2: Agente (Sob Demanda)

Carregado quando uma tarefa e delegada a um agente especifico.

**Arquivos:**
- `extensoes/{ext}/agentes/{nome}.md` - Instrucoes do agente
- `extensoes/{ext}/conhecimento/{relevante}.md` - Apenas conhecimento relevante para a tarefa

**Peso:** ~5KB por agente

**Trigger:** Orquestrador delega tarefa ao agente.

**Selecao inteligente de conhecimento:** Nao carrega TODO o conhecimento da extensao, apenas os arquivos relevantes para a tarefa. Ver `loading-rules.yaml` para regras.

---

## Nivel 3: Profundo (Lazy Load)

Carregado apenas quando o agente precisa de informacao especifica que nao esta nos niveis anteriores.

**Arquivos:**
- `extensoes/{ext}/conhecimento/{topico}.md` - Conhecimento especializado
- `extensoes/{ext}/frameworks/{framework}.md` - Frameworks de referencia
- `extensoes/{ext}/templates/{template}` - Templates de entrega

**Peso:** Variavel

**Trigger:** Agente identifica necessidade durante execucao.

**Estrategia:** Lazy load. So carrega quando realmente precisa.

---

## Integracao com Context Brackets

O Context Manager trabalha em conjunto com as **Faixas de Contexto** (`brackets.yaml`):

| Bracket | Comportamento do Context Manager |
|---------|----------------------------------|
| FRESH (< 10 turnos) | Carrega normalmente, sem restricoes |
| MODERATE (10-30 turnos) | Reforco de niveis 0 e 1, cuidado no nivel 3 |
| DEPLETED (30-60 turnos) | Sumariza conversas longas, prioriza reforco |
| CRITICAL (60+ turnos) | Salva checkpoint, sugere nova sessao |

**Regras de interacao:**
- Brackets definem QUANTO contexto injetar (orcamento de tokens)
- Context Manager define O QUE injetar dentro desse orcamento
- Ambos consultam `blackboard.contexto.turnos` e `blackboard.contexto.bracket`

---

## Descarregamento (Eviction)

Quando o contexto atinge 80% da capacidade, o Context Manager descarrega proativamente:

**Prioridade de descarte (LRU):**

1. Conhecimento nivel 3 nao usado nos ultimos 3 turnos
2. Extensoes inativas (sem tarefa ativa)
3. Historico de mensagens antigas (sumarizar em vez de descartar)
4. Conhecimento nivel 2 de agentes inativos

**O que NUNCA descarregar:**
- Blackboard (estado compartilhado)
- Constituicao (regras imutaveis)
- Decisoes da sessao atual (trabalho.yaml)

---

## Sumarizacao Inteligente

Quando contexto ultrapassa 70% da capacidade:

| Tipo | Acao |
|------|------|
| Conversa longa | Sumarizar turnos antigos, manter ultimos 5 intactos |
| Conhecimento carregado | Extrair apenas pontos relevantes para tarefa atual |
| Resultados anteriores | Manter conclusoes, descartar processo |

---

## Como o Orquestrador Usa o Context Manager

### Ao Iniciar Sessao
1. Carregar Nivel 0 (kernel) automaticamente
2. Determinar bracket atual baseado em turnos

### Ao Receber Pedido
3. Carregar Nivel 1 (extensao identificada)
4. Carregar Nivel 2 (agente delegado)

### Durante Execucao
5. Agente solicita Nivel 3 se precisar

### Ao Mudar de Contexto
6. Descarregar extensao/agente anterior
7. Carregar nova extensao/agente

### Ao Atingir Limites
8. Aplicar descarregamento LRU
9. Sumarizar se necessario
10. Alertar se bracket DEPLETED ou CRITICAL

---

## Metricas

| Metrica | O que mede | Alvo |
|---------|-----------|------|
| Contexto utilizado | % do contexto total em uso | < 80% |
| Niveis carregados | Quantos niveis ativos | 2-3 |
| Cache hits | Quantas vezes reusou contexto ja carregado | > 70% |
| Evictions | Quantas vezes descarregou contexto | < 5/sessao |

---

## Arquivos de Configuracao

| Arquivo | Funcao |
|---------|--------|
| `kernel/context-manager/CONTEXT-MANAGER.md` | Este documento |
| `kernel/context-manager/brackets.yaml` | Faixas de contexto adaptativas |
| `kernel/context-manager/strategy.yaml` | Estrategia de carregamento por nivel |
| `kernel/context-manager/loading-rules.yaml` | Regras de carregamento por tipo de tarefa |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/contexto` | Ver estado atual do contexto (niveis carregados, %) |
| `/contexto bracket` | Ver bracket atual e comportamento |
| `/contexto descarregar` | Forcar descarregamento de niveis inativos |
