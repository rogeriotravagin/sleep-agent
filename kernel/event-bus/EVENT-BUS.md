# Event Bus - Sistema Reativo

O Event Bus transforma o Sleep Agent de um sistema puramente reativo (so age quando o usuario pede) para um sistema proativo que reage a eventos do ambiente automaticamente.

---

## Por que um Event Bus?

No v4, todas as acoes dependiam de comandos explicitos. Se uma tarefa falhava, nada acontecia ate o usuario perceber. Se um insight era gerado, ninguem o processava. O Event Bus conecta todas as partes do sistema de forma desacoplada.

**Beneficios:**
- Reatividade automatica a eventos
- Desacoplamento entre componentes
- Resiliencia (falha de um nao afeta outros)
- Observabilidade (todo evento e registrado)

---

## Como Funciona

### 1. Eventos

Algo acontece no sistema (tarefa concluida, gate falhou, insight novo) e um evento e emitido.

```yaml
# Exemplo: tarefa concluida emite evento
evento: "tarefa.concluida"
payload:
  id: "task_042"
  agente: "copywriter"
  resultado: "headline criada"
  duracao: "1.8min"
```

### 2. Assinaturas

Componentes do sistema escutam eventos que lhes interessam:

```yaml
# Scheduler escuta conclusoes para escalonar proxima tarefa
- evento: "tarefa.concluida"
  assinante: "scheduler"
  acao: "escalonar_proxima"

# Blackboard escuta conclusoes para atualizar estado
- evento: "tarefa.concluida"
  assinante: "blackboard"
  acao: "atualizar_estado"
```

### 3. Triggers

Regras condicionais que disparam acoes automaticas:

```yaml
# Se email foi criado, rodar quality check automatico
- nome: "auto-quality-check"
  evento: "tarefa.concluida"
  condicao: "tarefa.tipo in ['criar-email', 'criar-landing']"
  acao:
    tipo: "executar_gate"
    gate_nivel: 1
```

---

## Categorias de Eventos

| Categoria | Exemplos | Prioridade tipica |
|-----------|----------|-------------------|
| **Tarefa** | criada, iniciada, concluida, falhou, timeout | Alta |
| **Qualidade** | gate.passou, gate.falhou, circuit_breaker.abriu | Alta |
| **Agente** | inicializado, ativado, concluiu, falhou | Normal |
| **Memoria** | insight.novo, padrao.detectado, promovida | Normal |
| **Blackboard** | atualizado, conflito | Normal |
| **Arquivo** | criado, modificado, deletado | Baixa |
| **Sistema** | sessao.iniciada, sessao.encerrada, health_check | Baixa |
| **Externo** | webhook.recebido, timer.disparado | Normal |

---

## Categorias de Triggers

### Qualidade
Verificacoes automaticas apos entregas. Toda copy passa por quality gate nivel 1. Emails e landing pages passam por nivel 2 (revisao por agente).

### Resiliencia
Reacoes a falhas. Retry com self-critique, fallback para agente alternativo, alerta ao usuario quando esgota tentativas.

### Memoria
Persistencia automatica de insights, promocao de episodica para semantica, deteccao de padroes, limpeza de itens expirados.

### Reuso (Asset Engine)
Indexacao de ativos aprovados, promocao de ativos muito reusados para templates, depreciacao de ativos inativos.

### Observabilidade
Registro de metricas, alertas de degradacao, alertas de qualidade, lembretes sobre extensoes ociosas.

### Sessao
Health check automatico ao iniciar, salvamento de estado ao encerrar, alerta de contexto critico.

---

## Fluxo de Processamento

```
1. Evento emitido
   ↓
2. Event Bus identifica assinantes
   ↓
3. Ordena por prioridade do assinante
   ↓
4. Executa cada assinante em ordem
   ↓
5. Verifica triggers condicionais
   ↓
6. Executa triggers que atendem condicao
   ↓
7. Registra tudo no log de eventos
```

### Prioridade de Processamento

| Assinante | Prioridade | Motivo |
|-----------|-----------|--------|
| Scheduler | 100 | Gerencia fila de tarefas |
| Circuit Breaker | 90 | Protecao contra cascata |
| Lifecycle | 80 | Gerencia estado de agentes |
| Blackboard | 70 | Atualiza estado compartilhado |
| Qualidade | 60 | Registra e sugere |
| Memoria | 50 | Persiste aprendizados |
| Auto-Calibracao | 40 | Aprende com padroes |
| Asset Engine | 30 | Indexa ativos |
| Metricas | 10 | Observabilidade |

---

## Integracao com o Sistema

### Com o Scheduler
- Eventos `tarefa.concluida` e `tarefa.falhou` alimentam o scheduler
- Scheduler decide proxima tarefa baseado no evento

### Com o Lifecycle
- Eventos de agente alimentam transicoes de estado
- Lifecycle emite eventos em cada transicao

### Com a DAG Engine
- Cada onda concluida emite `tarefa.concluida` por tarefa
- DAG Engine escuta para resolver proxima onda

### Com o Circuit Breaker
- Eventos `gate.falhou` alimentam contadores
- Circuit breaker emite eventos ao abrir/fechar

### Com a Auto-Calibracao
- Eventos de gate alimentam metricas de calibracao
- Padroes detectados geram novos gates

### Com a Asset Engine
- Evento `gate.passou` (nivel 3) indexa ativo aprovado
- Ativos reusados geram eventos de reuso

---

## Exemplo Pratico

```
Usuario pede: "Cria um email de venda"

1. [tarefa.criada] → Scheduler adiciona a fila
2. [agente.inicializado] → Lifecycle carrega copywriter
3. [agente.ativado] → Lifecycle marca como ativo
4. ... copywriter cria o email ...
5. [tarefa.concluida] → Varios assinantes reagem:
   - Scheduler: escalona proxima tarefa
   - Blackboard: salva resultado
   - Metricas: registra duracao
   - Trigger "auto-quality-check": executa gate nivel 1
   - Trigger "auto-review-copy": executa gate nivel 2
6. [gate.passou nivel 3] → Asset Engine indexa email como ativo
7. [insight.novo] → Memoria persiste aprendizados
```

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `kernel/event-bus/EVENT-BUS.md` | Este documento |
| `kernel/event-bus/events.yaml` | Tipos de evento e assinaturas |
| `kernel/event-bus/triggers.yaml` | Regras de reacao automatica |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/eventos` | Ver eventos recentes |
| `/triggers` | Ver triggers ativos |
| `/eventos log` | Ver log completo de eventos |
