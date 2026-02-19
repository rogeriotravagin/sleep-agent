# DAG Workflows - Grafos de Dependencia

O DAG (Directed Acyclic Graph) Engine substitui workflows lineares por grafos de dependencia. Tarefas sem dependencias executam em paralelo automaticamente, com retry, fallback e resiliencia integrados.

---

## Por que DAG ao inves de Fases Lineares?

No v4, workflows eram sequenciais: Fase 1 → Fase 2 → Fase 3. Mesmo que duas tarefas na Fase 2 fossem independentes, esperavam uma pela outra. Resultado: execucao lenta, sem paralelismo real, sem tratamento de falhas.

O DAG resolve isso:

- **Paralelismo automatico:** Tarefas sem dependencia rodam juntas
- **Resolucao topologica:** Ordem calculada automaticamente pelo grafo
- **Retry com fallback:** Falhas sao tratadas sem parar o workflow
- **Resiliencia:** Circuit breaker protege contra falhas cascata

---

## Como Funciona

### 1. Definir Tarefas e Dependencias

```yaml
tarefas:
  pesquisa:
    agente: estrategista
    dependencias: []           # Sem dependencias, comeca primeiro

  icp:
    agente: estrategista
    dependencias: [pesquisa]   # Precisa da pesquisa

  oferta:
    agente: estrategista
    dependencias: [icp]        # Precisa do ICP

  headline:
    agente: copywriter
    dependencias: [icp, oferta] # Precisa de ICP E oferta

  paleta:
    agente: designer
    dependencias: [pesquisa]    # So precisa da pesquisa (paralelo com ICP!)

  landing:
    agente: copywriter
    dependencias: [headline, paleta, oferta]  # Precisa de tudo
```

### 2. Resolucao Automatica

O engine calcula a ordem usando ordenacao topologica:

```
Onda 1: pesquisa                    (sem dependencias)
Onda 2: icp + paleta                (paralelo! ambas dependem so da pesquisa)
Onda 3: oferta                      (depende do ICP)
Onda 4: headline                    (depende de ICP + oferta)
Onda 5: landing                     (depende de headline + paleta + oferta)
```

### 3. Execucao por Ondas

Cada onda e um grupo de tarefas que podem executar simultaneamente:

- **Dentro da onda:** Tarefas em paralelo (fork)
- **Entre ondas:** Sequencial (join → fork)
- **Sincronizacao:** Onda N+1 so comeca quando onda N terminar

---

## Resolucao Topologica

O algoritmo usado e baseado em ordenacao topologica (Kahn):

1. Identificar tarefas sem dependencias (onda 1)
2. Remover essas tarefas do grafo
3. Identificar novas tarefas sem dependencias (onda 2)
4. Repetir ate esvaziar o grafo
5. Se sobrar tarefas, ha ciclo (erro!)

**Deteccao de ciclos:** Se o grafo tem ciclo (A depende de B, B depende de A), o engine rejeita o workflow e alerta o usuario.

---

## Resiliencia

### Retry por Tarefa

```yaml
resiliencia:
  retry:
    max_tentativas: 3
    backoff: exponencial    # 1s, 2s, 4s
    condicao: erro_transiente
    entre_retries: self_critique  # Auto-critica entre tentativas
```

### Fallback por Tarefa

```yaml
fallback:
  habilitado: true
  estrategia: agente_alternativo
  exemplo:
    tarefa: criar-headline
    agente_primario: copywriter
    agente_fallback: estrategista  # Pode criar headline basica
```

### Circuit Breaker

Se uma tarefa falha repetidamente, o circuit breaker abre:
- Tarefa marcada como [NAO COMPLETADA]
- Workflow continua com tarefas independentes
- Tarefas dependentes sao marcadas como [BLOQUEADA]
- Usuario e notificado

Ver: `core/qualidade/circuit-breaker.yaml`

---

## Estrategias de Join

Quando tarefas paralelas convergem:

| Estrategia | Comportamento |
|------------|---------------|
| `aguardar_todos` | Espera todas as tarefas da onda terminarem |
| `aguardar_criticos` | Espera apenas tarefas marcadas como criticas |
| `primeiro_valido` | Usa resultado da primeira que terminar |
| `melhor_resultado` | Compara resultados e usa o melhor (gate nivel 2) |

Padrao: `aguardar_todos`

---

## Integracao com o Sistema

### Com o Scheduler
- DAG Engine define a ORDEM das tarefas
- Scheduler define QUANDO executar dentro dessa ordem
- Ondas sao submetidas ao scheduler como grupo

### Com o Agent Lifecycle
- Cada tarefa no DAG ativa um agente via lifecycle
- Pausa/retomada respeitam o estado do agente

### Com o Workflow Paralelo (v4)
- DAG Engine e uma evolucao do sistema de `fork/join` do v4
- Workflows v4 continuam funcionando (compativel)
- DAG adiciona resolucao automatica de dependencias

### Com o Self-Critique
- Entre retries, self-critique analisa o que falhou
- Feedback do self-critique alimenta a proxima tentativa

---

## Exemplo Completo: Lancamento de Produto

```yaml
workflow: lancamento-produto
tipo: dag

tarefas:
  pesquisa:
    agente: estrategista
    dependencias: []
    prioridade: alta

  icp:
    agente: estrategista
    dependencias: [pesquisa]

  oferta:
    agente: estrategista
    dependencias: [icp]

  headline:
    agente: copywriter
    dependencias: [icp, oferta]

  subheadline:
    agente: copywriter
    dependencias: [headline]

  paleta:
    agente: designer
    dependencias: [pesquisa]

  landing:
    agente: copywriter
    dependencias: [headline, subheadline, paleta, oferta]
    critica: true

  email_sequencia:
    agente: copywriter
    dependencias: [icp, oferta]  # Paralelo com headline!

  anuncios:
    agente: trafego
    dependencias: [icp, headline]

# Resolucao automatica:
# Onda 1: pesquisa
# Onda 2: icp + paleta
# Onda 3: oferta
# Onda 4: headline + email_sequencia
# Onda 5: subheadline + anuncios
# Onda 6: landing
```

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `core/workflows/DAG.md` | Este documento |
| `core/workflows/dag-engine.yaml` | Configuracao da engine |
| `core/workflows/PARALELO.md` | Documentacao do sistema v4 (compativel) |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/workflow {nome}` | Iniciar workflow DAG |
| `/workflow status` | Ver progresso do workflow ativo |
| `/workflow grafo` | Visualizar grafo de dependencias |
| `/workflow pausar` | Pausar workflow ativo |
