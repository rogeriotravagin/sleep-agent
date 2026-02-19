# Dashboard - Observabilidade Profunda

O Dashboard oferece visao completa do funcionamento do Sleep Agent: metricas de sessao, historico, tendencias, alertas e insights operacionais.

---

## Por que um Dashboard?

No v4, o `/status` mostrava apenas a tarefa atual e historico basico. Nao havia como saber quais agentes sao mais usados, quais tarefas demoram mais, onde estao os gargalos, ou como a qualidade evolui ao longo do tempo.

O Dashboard v5 responde perguntas como:
- Qual agente e o mais eficiente?
- Qual tarefa precisa de mais iteracoes?
- A qualidade esta melhorando ou piorando?
- Quais extensoes nao estou usando?
- O sistema de reuso esta funcionando?

---

## Comando `/dashboard`

```
Dashboard do Sleep Agent
========================

Sessao Atual (19/02/2026)
  Tarefas: 5 concluidas | 1 em andamento | 2 na fila
  Tempo: 12min total | 2.4min media
  Agentes: copywriter (3) | estrategista (2) | designer (1)
  Reuso: 2 ativos reusados | 1 adaptado | 3 criados do zero
  Qualidade: 5/6 aprovadas (83%) | 1 retry

Ultimos 7 Dias
  Total tarefas: 34 | Taxa aprovacao: 89%
  Extensao top: marketing (22 tarefas)
  Agente mais eficiente: copywriter (1.8min media)
  Insight novo: "Usuario prefere headlines com perguntas"
  Tendencia qualidade: ↑ melhorando (+4% vs semana anterior)

Saude
  Memoria: 145 episodicos | 23 semanticos
  Blackboard: atualizado ha 5min
  Ferramentas: 8/8 disponiveis
  Quality Gates: calibrados (ultima calibracao: hoje)
  Circuit Breakers: todos fechados
  Ativos: 47 no inventario | 12 reusados este mes

Alertas
  ⚠ Extensao 'dados' nao usada ha 35 dias
  ✓ Sem degradacao de performance
  ✓ Qualidade dentro do alvo (>80%)
```

---

## Categorias de Metricas

### Metricas de Sessao
Acompanham a sessao atual em tempo real:
- Tarefas executadas, em andamento e na fila
- Tempo total e medio por tarefa
- Extensoes e agentes usados
- Gates executados e falhados
- Insights capturados
- Ativos criados vs reusados

### Metricas por Agente
Performance individual de cada agente:
- Total de tarefas
- Tempo medio
- Taxa de aprovacao no primeiro gate
- Retries e fallbacks

### Metricas por Extensao
Uso de cada extensao:
- Total de tarefas
- Agentes utilizados
- Tempo total

### Metricas por Tipo de Tarefa
Performance por tipo (criar-headline, criar-email, etc):
- Execucoes totais
- Tempo medio
- Taxa de aprovacao
- Media de iteracoes ate aprovacao

### Historico
Ultimas 30 sessoes com dados consolidados para comparacao temporal.

---

## Insights Operacionais

Calculados automaticamente ao encerrar cada sessao:

| Insight | O que mostra |
|---------|--------------|
| Agente mais eficiente | Menor tempo medio |
| Agente mais lento | Maior tempo medio |
| Tarefa mais refeita | Maior media de iteracoes |
| Horario pico | Quando mais tarefas sao criadas |
| Extensao mais usada | Maior volume no mes |
| Extensao subutilizada | 0 usos no mes |
| Taxa de reuso | % de tarefas que reusaram ativos |
| Gate mais falho | Gate que mais reprova |
| Causa retry mais comum | Padrao de falhas |

---

## Alertas Operacionais

O sistema monitora e alerta proativamente:

| Alerta | Condicao | Acao |
|--------|----------|------|
| Degradacao | Tempo medio > 5min por 3 sessoes | Investigar lentidao |
| Qualidade | Taxa aprovacao < 80% por 5 sessoes | Revisar gates |
| Extensao ociosa | Nao usada em 30 dias | Sugerir remocao |
| Circuit breaker | Aberto por 30+ min | Investigar falha |
| Memoria cheia | 200+ itens episodicos | Forcar limpeza |
| Reuso baixo | < 10% com 50+ ativos | Revisar scoring |

---

## Tendencias

Comparacao semanal para identificar direcao:

| Metrica | Direcao | Significado |
|---------|---------|-------------|
| Qualidade ↑ | Melhorando | Gates e calibracao funcionando |
| Qualidade ↓ | Piorando | Revisar gates ou contexto |
| Velocidade ↑ | Mais rapido | Reuso e memoria ajudando |
| Velocidade ↓ | Mais lento | Verificar contexto e carga |
| Reuso ↑ | Mais reuso | Asset Engine funcionando |
| Reuso ↓ | Menos reuso | Inventario precisa de atencao |

---

## Integracao com o Sistema

### Com o Event Bus
Todos os eventos alimentam metricas automaticamente. O assinante `metricas` tem prioridade 10 (mais baixa) para nao impactar performance.

### Com o Health Check
Metricas de saude aparecem no dashboard. Alertas de health check se combinam com alertas do dashboard.

### Com a Auto-Calibracao
Taxa de aprovacao e ajustes alimentam tanto calibracao quanto dashboard.

### Com o Asset Engine
Metricas de reuso mostram efetividade do inventario de ativos.

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `core/status/DASHBOARD.md` | Este documento |
| `core/status/metricas-v5.yaml` | Metricas e configuracao |
| `workspace/.status/metricas-log.yaml` | Log historico |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/dashboard` | Dashboard completo |
| `/dashboard sessao` | Apenas metricas da sessao atual |
| `/dashboard historico` | Ultimas 30 sessoes |
| `/dashboard tendencias` | Tendencias semanais |
| `/dashboard alertas` | Alertas ativos |
| `/status` | Status resumido (compativel v4) |
