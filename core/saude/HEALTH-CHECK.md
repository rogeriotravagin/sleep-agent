# Health Check - Sistema de Saude do Sleep Agent

O Sleep Agent verifica automaticamente sua propria "saude" e corrige problemas comuns sem precisar incomodar voce.

---

## O que e Health Check?

Imagine um assistente que, antes de comecar a trabalhar, verifica se tem tudo que precisa. Se falta algo, ele proprio resolve (quando possivel) ou te avisa de forma clara.

**Beneficios:**
- Menos erros durante o uso
- Problemas corrigidos antes de causar transtorno
- Voce so e acionado quando realmente necessario

---

## 3 Niveis de Problemas

### Nivel 1: Auto-Correcao Silenciosa

Problemas simples que o Sleep Agent resolve sozinho, sem te avisar.

**O que entra aqui:**
- Criar arquivo de configuracao se nao existe
- Criar pastas que faltam no workspace
- Limpar arquivos temporarios antigos
- Corrigir permissoes de arquivos

**Voce nem fica sabendo** - simplesmente funciona.

### Nivel 2: Correcao com Aviso

Problemas que podem ser corrigidos, mas voce deve saber.

**O que entra aqui:**
- Atualizar estrutura do workspace para nova versao
- Migrar configuracoes antigas
- Reparar links quebrados

### Nivel 3: Intervencao Necessaria

Problemas que so voce pode resolver.

**O que entra aqui:**
- Arquivos importantes corrompidos
- Conflitos que precisam de decisao
- Permissoes de sistema

---

## Quando o Health Check Executa

### Automaticamente

1. **Ao iniciar uma sessao** - Verifica se tudo esta ok
2. **Ao carregar uma extensao** - Verifica se extensao esta intacta
3. **Ao salvar arquivo** - Verifica se consegue salvar

### Manualmente

- `/saude` - Ver status geral do sistema
- `/diagnostico` - Analise detalhada de problemas

---

## O que e Verificado

### Configuracao

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| sleep-agent.yaml existe | 1 | Criar com valores padrao |
| Formato YAML valido | 3 | Nao (pode perder dados) |
| Versao compativel | 2 | Migrar se possivel |

### Workspace

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| Pasta .config existe | 1 | Criar pasta |
| Pasta .memoria existe | 1 | Criar pasta |
| Pasta .status existe | 1 | Criar pasta |
| **Pasta .state existe** | 1 | **Criar pasta + blackboard.yaml** |
| Estrutura de pastas valida | 2 | Sugerir correcao |

### Blackboard (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **blackboard.yaml existe** | 1 | **Criar com template padrao** |
| **Formato YAML valido** | 2 | **Backup + recriar** |
| **Campos obrigatorios presentes** | 1 | **Adicionar campos faltantes** |

### Memoria Hierarquica (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **trabalho.yaml existe** | 1 | **Criar com template padrao** |
| **Pasta episodica/ existe** | 1 | **Criar pasta** |
| **Pasta semantica/ existe** | 1 | **Criar pasta** |
| **Arquivos semantica/*.yaml existem** | 1 | **Criar com template** |
| **Episodica com 30+ dias** | 1 | **Remover/arquivar automaticamente** |
| **Itens episodicos com 3+ acessos** | 2 | **Sugerir promocao para semantica** |
| **Duplicatas entre camadas** | 1 | **Remover duplicatas** |
| Arquivos YAML validos | 2 | Backup + recriar |

### Kernel (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **constitution.yaml existe** | 1 | **Criar com template** |
| **handoff-template.yaml existe** | 1 | **Criar com template** |
| **brackets.yaml existe** | 1 | **Criar com template** |
| **strategy.yaml existe** | 1 | **Criar com template** |
| **loading-rules.yaml existe** | 1 | **Criar com template** |

### Tool Registry (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta tool-registry/ existe** | 1 | **Criar pasta** |
| **registry.yaml existe** | 1 | **Criar com ferramentas padrao** |
| **discovery.yaml existe** | 1 | **Criar com template** |
| **Ferramentas com credenciais validadas** | 2 | **Alertar quais estao indisponiveis** |
| **Ferramentas referenciadas existem** | 2 | **Alertar inconsistencias** |

### Auto-Calibracao (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **auto-calibracao.yaml existe** | 1 | **Criar com template** |
| **tracking.yaml existe** | 1 | **Criar com contadores zerados** |
| **Taxa de aprovacao calculavel** | 2 | **Resetar metricas se corrompidas** |
| **Padroes pendentes com 30+ dias** | 2 | **Alertar para revisao** |

### Permissoes (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta permissions/ existe** | 1 | **Criar pasta** |
| **modes.yaml existe** | 1 | **Criar com template padrao** |
| **Modo padrao definido** | 1 | **Setar 'confirmar' como padrao** |

### Configuracao em Camadas (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta config/ existe** | 1 | **Criar pasta** |
| **hierarchy.yaml existe** | 1 | **Criar com template** |
| **user-preferences.yaml existe** | 1 | **Criar com padroes** |
| **session-overrides.yaml formato valido** | 1 | **Recriar vazio** |
| **Conflitos L0 vs L4 detectados** | 2 | **Alertar e bloquear override** |

### Scheduler (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta scheduler/ existe** | 1 | **Criar pasta** |
| **scheduler.yaml existe** | 1 | **Criar com template** |
| **Tarefas abandonadas na fila** | 2 | **Alertar e sugerir limpeza** |

### Lifecycle (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta lifecycle/ existe** | 1 | **Criar pasta** |
| **lifecycle.yaml existe** | 1 | **Criar com template** |
| **Checkpoints orfaos (tarefa concluida)** | 1 | **Remover checkpoints** |

### DAG Workflows (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **dag-engine.yaml existe** | 1 | **Criar com template** |
| **self-critique.yaml existe** | 1 | **Criar com template** |
| **circuit-breaker.yaml existe** | 1 | **Criar com template** |
| **Circuit breaker aberto por 30+ min** | 2 | **Alertar para investigacao** |

### Event Bus (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta event-bus/ existe** | 1 | **Criar pasta** |
| **events.yaml existe** | 1 | **Criar com template** |
| **triggers.yaml existe** | 1 | **Criar com template** |
| **Buffer de eventos nao estourou** | 1 | **Limpar eventos antigos** |
| **Triggers com erro recorrente** | 2 | **Alertar e desabilitar trigger** |

### Asset Engine (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **Pasta asset-engine/ existe** | 1 | **Criar pasta** |
| **decision.yaml existe** | 1 | **Criar com template** |
| **asset-index.yaml existe** | 1 | **Criar com inventario vazio** |
| **Ativos depreciados pendentes** | 1 | **Executar depreciacao automatica** |
| **Ativos com score inconsistente** | 2 | **Recalcular scores** |

### Observabilidade (v5)

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| **metricas-v5.yaml existe** | 1 | **Criar com contadores zerados** |
| **Historico com 30+ sessoes** | 1 | **Remover sessoes mais antigas** |
| **Alertas ativos nao verificados** | 2 | **Alertar usuario** |
| **Tendencias calculaveis** | 1 | **Recalcular se corrompidas** |

### Extensoes

| Verificacao | Nivel | Auto-Correcao |
|-------------|-------|---------------|
| extensao.yaml existe | 3 | Nao (extensao invalida) |
| Formato do manifesto valido | 3 | Nao |
| Agentes referenciados existem | 2 | Alertar quais faltam |
| Conhecimento referenciado existe | 2 | Alertar quais faltam |

---

## Mensagens Amigaveis

O Sleep Agent sempre explica problemas de forma simples:

**Ruim:**
```
Error: ENOENT: no such file or directory, open 'workspace/.state/blackboard.yaml'
```

**Bom:**
```
Percebi que o blackboard da sessao nao existe ainda.
Vou criar um novo pra voce. Pronto!
```

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/saude` | Ver status geral do sistema |
| `/diagnostico` | Analise completa e detalhada |
| `/reparar` | Tentar corrigir problemas automaticamente |

---

## Logs de Health Check

Todas as verificacoes e correcoes ficam registradas em:
```
workspace/.status/health-log.yaml
```

---

## Dicas

1. **Nao se preocupe** - A maioria dos problemas e resolvida automaticamente
2. **Faca backups** - O sistema ajuda, mas backup e sempre bom
3. **Relate problemas** - Se algo parece errado, pergunte
4. **Confie nos avisos** - Se o sistema pede atencao, vale verificar
