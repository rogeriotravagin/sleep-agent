# Task Scheduler - Escalonador de Tarefas

O Task Scheduler gerencia a fila de tarefas do Sleep Agent com priorizacao inteligente, preempcao e retry automatico. Tarefas urgentes passam na frente, tarefas longas podem ser pausadas, e falhas sao tratadas com retry progressivo.

---

## Por que um Escalonador?

No v4, tarefas eram executadas na ordem que chegavam. Se o usuario pedia 3 coisas, a terceira esperava as duas primeiras terminarem, mesmo que fosse mais urgente. Nao havia conceito de prioridade, pausa ou retomada.

O Scheduler resolve isso:

- **Priorizacao:** Tarefas urgentes passam na frente
- **Preempcao:** Tarefas podem ser pausadas para dar lugar a urgencias
- **Retry:** Falhas sao tratadas automaticamente com backoff
- **Limites:** Controle de tarefas simultaneas e timeout

---

## Niveis de Prioridade

| Prioridade | Peso | Quando usar | Exemplos |
|-----------|------|-------------|----------|
| Critica | 100 | Emergencias, deadlines hoje | Cancelamento com SLA, caso critico |
| Alta | 75 | Deadlines proximos | Tarefa com deadline em 2 dias |
| Normal | 50 | Padrao | Maioria das tarefas |
| Baixa | 25 | Sem urgencia | Melhorias, otimizacoes |
| Ociosa | 10 | Background | Health check, limpeza, manutencao |

---

## Ciclo de Vida da Tarefa

```
[Criada] → [Na Fila] → [Escalonada] → [Em Execucao] → [Validando] → [Concluida]
                ↑                            ↓
                ← ← ← [Pausada/Preemptada] ← ←
                                             ↓
                                        [Falha] → [Retry] → [Na Fila]
                                             ↓
                                        [Abandonada]
```

### Estados

| Estado | Descricao |
|--------|-----------|
| Criada | Tarefa registrada, ainda nao na fila |
| Na Fila | Aguardando escalonamento por prioridade |
| Escalonada | Selecionada para execucao |
| Em Execucao | Agente ativo trabalhando |
| Validando | Passando pelos Quality Gates |
| Concluida | Finalizada com sucesso |
| Pausada | Salva checkpoint, aguarda retomada |
| Falha | Erro encontrado, avaliando retry |
| Abandonada | Falhou apos max retries |

---

## Regras de Priorizacao Automatica

O scheduler atribui prioridade automaticamente baseado em regras:

| Condicao | Prioridade | Motivo |
|----------|-----------|--------|
| Tipo cancelamento | Critica | SLA de 24h |
| Deadline < 2 dias | Alta | Deadline proximo |
| Tipo health-check | Ociosa | Manutencao de rotina |
| Tipo deploy | Alta | Precisa publicar |
| Usuario marcou urgente | Critica | Decisao do usuario |

Regras customizaveis em `scheduler.yaml`.

---

## Preempcao

Quando uma tarefa de prioridade critica entra na fila:

1. Tarefa atual salva checkpoint (progresso parcial)
2. Tarefa atual vai para estado Pausada
3. Tarefa critica assume a execucao
4. Ao concluir a critica, tarefa pausada retoma de onde parou

**Requisitos para preempcao:**
- Tarefa atual deve suportar checkpoint
- Tarefa preemptora deve ter prioridade significativamente maior
- Estado completo salvo em `workspace/.state/`

---

## Retry com Backoff

Quando uma tarefa falha:

1. **Avaliar se e retentavel** (erro transiente vs permanente)
2. **Incrementar contador** de retry
3. **Self-Critique** entre tentativas (ver `core/workflows/self-critique.yaml`)
4. **Backoff exponencial:** 1s → 2s → 4s entre retries
5. **Max retries:** 3 tentativas (configuravel)
6. **Apos max retries:** Marcar como Abandonada + notificar usuario

---

## Limites

| Limite | Valor Padrao | Configuravel |
|--------|-------------|--------------|
| Max tarefas ativas | 3 | Sim |
| Max paralelas | 5 | Sim |
| Timeout padrao | 30min | Sim |
| Max retries | 3 | Sim |
| Backoff base | 1s | Sim |

---

## Integracao com o Sistema

### Com o Orquestrador
- Orquestrador cria tarefas e envia ao scheduler
- Scheduler decide quando e em que ordem executar

### Com o Agent Lifecycle
- Scheduler ativa/pausa/retoma agentes conforme necessidade
- Respeita estados do ciclo de vida

### Com o DAG Workflow
- Para workflows com dependencias, scheduler respeita o grafo
- Tarefas sem dependencias sao paralelizadas automaticamente

### Com o Blackboard
- Estado de cada tarefa registrado no blackboard
- Checkpoints salvos em `workspace/.state/`

### Com os Quality Gates
- Apos execucao, tarefa passa para estado Validando
- Se gate falha, pode voltar para fila (com self-critique)

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `kernel/scheduler/SCHEDULER.md` | Este documento |
| `kernel/scheduler/scheduler.yaml` | Configuracao do escalonador |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/fila` | Ver fila de tarefas atual |
| `/fila prioridade {tarefa} {nivel}` | Mudar prioridade de tarefa |
| `/pausar {tarefa}` | Pausar tarefa em andamento |
| `/retomar {tarefa}` | Retomar tarefa pausada |
