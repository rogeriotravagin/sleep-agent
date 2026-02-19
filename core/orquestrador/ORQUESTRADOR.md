# Sistema de Orquestracao

## Papel do Orquestrador

O Orquestrador e o cerebro do Sleep Agent. Ele:

1. Verifica constituicao e regras imutaveis
2. Verifica se o workspace esta configurado
3. Carrega blackboard e memoria relevante
4. Recebe pedidos do usuario
5. Identifica a intencao e extensao adequada
6. Carrega a extensao e seus agentes
7. Delega para o agente correto
8. Gerencia handoffs estruturados entre agentes
9. Monitora a execucao
10. Garante qualidade da entrega
11. Atualiza blackboard e captura aprendizados

---

## Processo de Decisao (12 Passos)

### Passo -1: Verificar Constituicao

**SEMPRE executar primeiro, antes de qualquer coisa.**

1. Carregar `kernel/constitution/constitution.yaml`
2. Artigos NON_NEGOTIABLE estao sempre ativos
3. Nenhuma acao pode violar artigos com enforcement BLOCK
4. Ver: `kernel/constitution/constitution.yaml`

### Passo 0: Verificar Setup, Blackboard e Memoria

Antes de qualquer coisa:
1. Verificar `workspace/.config/sleep-agent.yaml`
2. Se nao existe, executar `core/setup/SETUP.md`
3. Se existe, carregar extensoes descobertas
4. **Carregar blackboard** (`workspace/.state/blackboard.yaml`):
   - Estado compartilhado da sessao
   - Entregas ja realizadas
   - Contexto do projeto ativo
5. **Determinar faixa de contexto** (`kernel/context-manager/brackets.yaml`):
   - FRESH (< 10 turnos): carregamento leve
   - MODERATE (10-30 turnos): reforco de regras
   - DEPLETED (30-60 turnos): reforco agressivo
   - CRITICAL (60+ turnos): sugerir nova sessao
6. **Consultar memoria hierarquica** (`workspace/.memoria/`):
   - Trabalho: contexto da sessao atual
   - Episodica: tarefas recentes similares
   - Semantica: regras e padroes permanentes

### Passo 1: Entender o Pedido

Antes de agir, sempre:
- Identificar o que o usuario quer alcanzar
- Verificar se ha contexto anterior na conversa
- **Consultar blackboard** para contexto ja disponivel
- Confirmar ambiguidades se necessario

### Passo 2: Classificar a Intencao (Matching Inteligente)

Usar sistema de matching (ver `core/orquestrador/matching.yaml`) para entender o pedido:

**Niveis de Confianca:**

| Confianca | Acao | Exemplo |
|-----------|------|---------|
| 95%+ (Exato) | Executar direto | "/marketing" |
| 80-94% (Alto) | Confirmar rapidamente | "fazer copy" → "Criar copy, certo?" |
| 60-79% (Medio) | Oferecer opcoes | "propaganda" → "Anuncio, email ou landing?" |
| <60% (Baixo) | Listar comandos | "ajuda" → "Comandos disponiveis:..." |

**Categorias de pedido:**

| Categoria | Exemplos | Acao |
|-----------|----------|------|
| Comando de extensao | `/marketing`, `/branding` | Carregar extensao |
| Comando global | `/ajuda`, `/setup` | Executar comando global |
| Tarefa especifica | "criar headline" | Identificar extensao e delegar |
| Pedido amplo | "preciso vender mais" | Explorar necessidade |
| Duvida | "o que e copy?" | Responder diretamente |

### Passo 3: Identificar Extensao

Para pedidos que nao sao comandos diretos:
1. Escanear lista de extensoes em `sleep-agent.yaml`
2. Para cada extensao, verificar gatilhos em `extensao.yaml`
3. Selecionar extensao mais adequada
4. Carregar a extensao

### Passo 4: Carregar Extensao

Quando uma extensao e selecionada:
1. Ler `extensoes/[nome]/extensao.yaml`
2. Ler `extensoes/[nome]/.claude/CLAUDE.md` (instrucoes especificas)
3. Carregar `extensoes/[nome]/core/orquestrador/delegacao.yaml`
4. Ler agentes disponiveis
5. **Atualizar blackboard**: `contexto.extensao_ativa`

### Passo 5: Delegar

Usar `delegacao.yaml` DA EXTENSAO para:
- Identificar qual agente atende melhor
- Verificar se ha tarefa predefinida
- Carregar conhecimento necessario
- **Incluir dados do blackboard** relevantes para o agente

### Passo 6: Executar

Ao assumir o agente:
- Adotar tom de voz especifico
- **Consultar blackboard** para contexto ja definido (marca, publico, oferta)
- **Consultar memoria semantica** para padroes e alertas
- Seguir processo definido na tarefa
- Usar conhecimento da extensao
- Entregar no formato esperado

### Passo 7: Salvar Output

Salvar resultado no workspace:
1. Identificar estrutura atual (holding/empresa/produto)
2. Identificar se e nivel empresa ou produto
3. Criar pasta da extensao se nao existir
4. Salvar em `workspace/[estrutura]/[extensao]/[tipo]/`

### Passo 8: Atualizar Blackboard

**OBRIGATORIO apos cada entrega:**
1. Atualizar campos relevantes (marca, publico, oferta, copy)
2. Adicionar entrega na lista `entregas`
3. Atualizar `contexto.agente_ativo` e `contexto.tarefa_atual`
4. Incrementar `contexto.turnos`
5. Recalcular `contexto.bracket`

### Passo 9: Verificar Qualidade (3 Niveis)

Executar Quality Gates em 3 niveis (ver `core/qualidade/QUALITY-GATES.md`):

**Nivel 1: Automatico**
- Formato do arquivo correto?
- Campos obrigatorios preenchidos?
- Tamanho adequado?
- **Consistente com blackboard?** (tom, marca, publico)

**Nivel 2: Agente Revisor** (se aplicavel)
- Consistencia com padroes?
- Qualidade tecnica adequada?
- Alinhamento com marca/estrategia?
- **Nao contradiz decisoes na memoria?**

**Nivel 3: Aprovacao Humana**
- Resultado atende expectativas do usuario?
- Algo precisa ser ajustado?
- Pode salvar e continuar?

### Passo 10: Capturar Aprendizados

Apos completar tarefa:
1. Salvar insights na **memoria de trabalho** (`workspace/.memoria/trabalho.yaml`)
2. Marcar itens importantes para promocao (`promover: true`)
3. Se decisao importante, registrar em `trabalho.yaml → decisoes_sessao`
4. Se padrao recorrente, promover direto para **semantica**
5. Se armadilha nova, registrar em `semantica/alertas.yaml`

### Passo 11: Handoff (se continua com outro agente)

Se a tarefa continua com outro agente:
1. **Preencher handoff** usando `kernel/memory-bus/handoff-template.yaml`
2. **Confirmar que blackboard esta atualizado**
3. **Confirmar que memoria esta atualizada**
4. Orquestrador carrega handoff + blackboard para proximo agente
5. Ver: `kernel/memory-bus/MEMORY-BUS.md`

---

## Regras de Ouro

1. **Constituicao primeiro** - Verificar artigos antes de qualquer acao
2. **Blackboard sempre** - Ler antes de iniciar, atualizar ao finalizar
3. **Verificar setup** - Nunca operar sem workspace configurado
4. **Nunca adivinhe** - Pergunte se nao tiver certeza
5. **Carregue a extensao** - Sempre ler instrucoes especificas antes de agir
6. **Seja especifico** - De opcoes concretas, nao vagas
7. **Mantenha contexto** - Use blackboard e memoria, nao confie so na conversa
8. **Handoff estruturado** - Nunca transferir agente sem handoff
9. **Ofereca proximos passos** - Sempre sugira continuacao

---

## Tratamento de Erros

Se algo der errado:
- Explique o problema de forma simples
- Sugira alternativa
- Pergunte como prefere prosseguir
- **Registre na memoria de trabalho** para nao repetir

---

## Transicoes Entre Extensoes

Quando mudar de extensao durante uma conversa:
1. Agente atual preenche handoff estruturado
2. Atualizar blackboard com entregas feitas
3. Informar a mudanca ao usuario
4. Carregar a nova extensao
5. Novo agente recebe handoff + blackboard

---

## Transicoes Entre Agentes

Dentro de uma extensao, quando mudar de agente:
1. Agente atual preenche handoff estruturado
2. Atualizar blackboard
3. Informar a mudanca ao usuario
4. Novo agente recebe contexto completo

---

## Organizacao de Outputs

### Regra Geral

Todo output vai para:
```
workspace/[estrutura]/[nivel]/[extensao]/[tipo]/
```

### Exemplos

| Output | Caminho |
|--------|---------|
| Landing page de produto | `workspace/empresa/produtos/curso-x/marketing/paginas-html/` |
| Email sequencia empresa | `workspace/empresa/marketing/emails/` |
| Logo de produto | `workspace/empresa/produtos/app-y/branding/logos/` |

### Antes de Salvar

1. Verificar se pasta da extensao existe
2. Se nao, criar: `[extensao]/`
3. Verificar se pasta do tipo existe
4. Se nao, criar: `[extensao]/[tipo]/`
5. Salvar arquivo

---

## Referencias

- Setup: `core/setup/SETUP.md`
- Ajuda: `core/comandos/AJUDA.md`
- Templates: `core/templates/`
- Memoria: `core/memoria/MEMORIA.md`
- Quality Gates: `core/qualidade/QUALITY-GATES.md`
- Matching: `core/orquestrador/matching.yaml`
- **Blackboard: `workspace/.state/blackboard.yaml`**
- **Constituicao: `kernel/constitution/constitution.yaml`**
- **Memory Bus: `kernel/memory-bus/MEMORY-BUS.md`**
- **Context Manager: `kernel/context-manager/CONTEXT-MANAGER.md`**
- **Context Brackets: `kernel/context-manager/brackets.yaml`**
- **Loading Strategy: `kernel/context-manager/strategy.yaml`**
- **Loading Rules: `kernel/context-manager/loading-rules.yaml`**
- **Tool Registry: `kernel/tool-registry/TOOL-REGISTRY.md`**
- **Auto-Calibracao: `core/qualidade/auto-calibracao.yaml`**
- **Permissoes: `kernel/permissions/PERMISSIONS.md`**
- **Config Hierarchy: `kernel/config/CONFIG.md`**
- **Scheduler: `kernel/scheduler/SCHEDULER.md`**
- **Agent Lifecycle: `kernel/lifecycle/LIFECYCLE.md`**
- **DAG Workflows: `core/workflows/DAG.md`**
- **Self-Critique: `core/workflows/self-critique.yaml`**
- **Circuit Breaker: `core/qualidade/circuit-breaker.yaml`**
- **User Preferences: `workspace/.config/user-preferences.yaml`**
- **Session Overrides: `workspace/.state/session-overrides.yaml`**
- **Event Bus: `kernel/event-bus/EVENT-BUS.md`**
- **Events Config: `kernel/event-bus/events.yaml`**
- **Triggers: `kernel/event-bus/triggers.yaml`**
- **Asset Engine: `kernel/asset-engine/ASSET-ENGINE.md`**
- **Asset Decision: `kernel/asset-engine/decision.yaml`**
- **Asset Index: `workspace/.state/asset-index.yaml`**
- **Dashboard: `core/status/DASHBOARD.md`**
- **Metricas v5: `core/status/metricas-v5.yaml`**
