# Agent Lifecycle - Ciclo de Vida de Agentes

O Agent Lifecycle define os estados e transicoes que um agente atravessa, desde o registro ate a conclusao. Cada transicao dispara hooks que garantem carregamento, salvamento e notificacao adequados.

---

## Por que Ciclo de Vida?

No v4, agentes eram definidos estaticamente. Nao havia conceito de "inicializar", "aquecer", "pausar" ou "encerrar". Um agente simplesmente "existia" ou "nao existia". Sem estado proprio, sem cleanup, sem hooks.

O Lifecycle resolve isso:

- **Estados claros:** Cada agente sabe em que estado esta
- **Hooks em transicoes:** Acoes automaticas em cada mudanca de estado
- **Checkpoint e retomada:** Agentes podem pausar e retomar
- **Cleanup:** Recursos liberados ao encerrar

---

## Estados do Agente

```
[Registrado] → [Inicializado] → [Ativo] → [Concluido]
                    ↑               ↓          ↓
                    |          [Pausado]    [Registrado]
                    |               ↓
                    ← [Suspenso] ← ←
                                    ↑
                               [Falha] → [Registrado]
```

### Descricao dos Estados

| Estado | Descricao | Recursos |
|--------|-----------|----------|
| Registrado | Agente existe mas nao foi carregado | Nenhum |
| Inicializado | Instrucoes e conhecimento carregados | Leitura |
| Ativo | Executando uma tarefa | Completo |
| Pausado | Checkpoint salvo, aguardando | Minimo |
| Suspenso | Recursos liberados, pode reativar | Nenhum |
| Concluido | Tarefa finalizada com sucesso | Em limpeza |
| Falha | Erro irrecuperavel encontrado | Em diagnostico |

---

## Hooks (Acoes Automaticas)

Cada transicao de estado dispara hooks automaticos:

### on_init (Registrado → Inicializado)
1. Carregar instrucoes do agente (`agentes/{nome}.md`)
2. Carregar conhecimento relevante (via loading-rules.yaml)
3. Buscar memoria relacionada (semantica + episodica)
4. Verificar ferramentas necessarias (via tool-registry)
5. Verificar modo de permissao (via modes.yaml)

### on_activate (Inicializado → Ativo)
1. Registrar inicio no blackboard
2. Carregar checkpoint se existir (retomada)
3. Aplicar configuracao resolvida (L0-L4)
4. Notificar scheduler: agente ativo

### on_pause (Ativo → Pausado)
1. Salvar checkpoint com progresso atual
2. Registrar estado parcial no blackboard
3. Liberar recursos nao essenciais
4. Notificar scheduler: agente pausado

### on_resume (Pausado → Ativo)
1. Recarregar checkpoint
2. Restaurar contexto completo
3. Verificar se blackboard mudou durante pausa
4. Continuar de onde parou

### on_complete (Ativo → Concluido)
1. Salvar resultado final no workspace
2. Atualizar blackboard com entrega
3. Capturar aprendizados (memoria de trabalho)
4. Executar Quality Gates
5. Preparar handoff se proximo agente definido
6. Notificar scheduler: tarefa concluida

### on_error (Ativo → Falha)
1. Registrar erro com contexto completo
2. Salvar estado para diagnostico
3. Avaliar se retry e viavel
4. Se retry: Self-Critique → volta para fila
5. Se nao retry: notificar usuario
6. Notificar scheduler: tarefa falhou

### on_suspend (Pausado → Suspenso / Inicializado → Suspenso)
1. Liberar todos os recursos
2. Descarregar conhecimento do contexto
3. Manter apenas referencia minima
4. Pode ser reinicializado quando necessario

---

## Carregamento Escalonado

O Lifecycle trabalha com o Context Manager para carregar recursos progressivamente:

| Estado | O que carrega |
|--------|---------------|
| Registrado | Nada (apenas sabe que existe) |
| Inicializado | Nivel 2: instrucoes + conhecimento |
| Ativo | Nivel 2 + Nivel 3 sob demanda |
| Pausado | Descarrega Nivel 3, mantem Nivel 2 |
| Suspenso | Descarrega tudo |

---

## Integracao com o Sistema

### Com o Scheduler
- Scheduler decide QUANDO ativar/pausar agentes
- Lifecycle define COMO ativar/pausar agentes

### Com o Context Manager
- Lifecycle dispara carregamento/descarregamento de contexto
- Context Manager decide O QUE carregar/descarregar

### Com o Blackboard
- Estado do agente registrado em `blackboard.contexto.agente_ativo`
- Entregas registradas em `blackboard.entregas`

### Com os Quality Gates
- Hook on_complete dispara validacao automatica
- Se gate falha, lifecycle pode transicionar para retry

### Com as Permissoes
- Hook on_init verifica modo de permissao do agente
- Modo determina o que o agente pode fazer durante estado Ativo

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `kernel/lifecycle/LIFECYCLE.md` | Este documento |
| `kernel/lifecycle/lifecycle.yaml` | Estados, transicoes e hooks |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/agentes ativos` | Ver agentes em estado ativo |
| `/agente {nome} estado` | Ver estado atual de um agente |
| `/agente {nome} pausar` | Pausar agente ativo |
| `/agente {nome} retomar` | Retomar agente pausado |
