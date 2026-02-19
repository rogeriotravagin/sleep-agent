# Sleep Agent v5 - Plano Estrategico de Evolucao

## Visao Geral

Este documento apresenta o roadmap de evolucao do Sleep Agent v4 para v5, com foco em transformar o sistema de um **orquestrador reativo** em um **sistema operacional de agentes** completo. As melhorias foram identificadas a partir de analise profunda da arquitetura atual, gaps operacionais observados em producao e padroes emergentes em sistemas multi-agente.

**Premissa central:** O Sleep Agent precisa deixar de ser um "roteador de comandos" e se tornar um verdadeiro sistema operacional onde agentes colaboram, compartilham estado, reagem a eventos e se auto-otimizam.

---

## Diagnostico: Gaps Criticos do v4

### 1. Agentes sao Ilhas Isoladas
- Agentes nao se comunicam entre si diretamente
- Transicoes entre agentes sao narrativas (texto), nao estruturadas
- Nao existe memoria compartilhada durante workflows
- Resultado: perda de contexto, retrabalho, inconsistencias

### 2. Orquestrador e Reativo, nao Proativo
- Tudo depende de um comando do usuario
- Nao ha reacao a eventos (webhook recebido, arquivo criado, timer)
- Nao ha capacidade de auto-iniciar tarefas baseadas em condicoes
- Resultado: usuario precisa lembrar de tudo, sistema passivo

### 3. Sem Gerenciamento de Recursos
- Nao ha prioridade entre tarefas concorrentes
- Contexto carregado e "tudo ou nada"
- Sem conceito de "peso" ou custo de cada agente/tarefa
- Resultado: lentidao, contexto desnecessario, ineficiencia

### 4. Ferramentas Fragmentadas
- Cada extensao gerencia suas proprias ferramentas (APIs, scripts)
- Nao ha registro centralizado de capacidades
- Nao ha descoberta dinamica de ferramentas disponiveis
- Resultado: duplicacao, ferramentas nao descobertas, retrabalho

### 5. Memoria Rasa
- 4 arquivos YAML flat (insights, decisoes, padroes, alertas)
- Sem hierarquia (curto prazo vs longo prazo)
- Sem relevancia contextual (busca manual)
- Sem decaimento (tudo tem mesmo peso independente de quando foi criado)
- Resultado: memoria cresce sem criterio, ruido, informacoes obsoletas

### 6. Workflows Rigidos
- Dependencias entre fases sao manuais
- Nao ha resolucao automatica de grafo de dependencias
- Sem capacidade de reacao a falhas (retry, fallback, circuit breaker)
- Resultado: workflows frageis, sem resiliencia

---

## Arquitetura v5: Sistema Operacional de Agentes

```
sleep_agent_v5/
├── kernel/                     # NOVO: Nucleo do sistema
│   ├── scheduler/              # Escalonador de tarefas e agentes
│   ├── memory-bus/             # Barramento de memoria compartilhada
│   ├── event-bus/              # Sistema de eventos
│   ├── tool-registry/          # Registro centralizado de ferramentas
│   ├── context-manager/        # Gerenciador inteligente de contexto
│   └── lifecycle/              # Ciclo de vida de agentes
├── core/                       # Existente (evoluido)
│   ├── orquestrador/           # Evoluido com scheduler
│   ├── memoria/                # Evoluido com hierarquia
│   ├── qualidade/              # Evoluido com auto-calibracao
│   ├── saude/                  # Evoluido com observabilidade profunda
│   └── workflows/              # Evoluido com grafo de dependencias
├── extensoes/                  # Existente (interface padronizada)
├── frameworks/                 # Existente
│   └── ralph/                  # Evoluido com capacidades v5
└── workspace/                  # Existente (novo .state/)
    ├── .state/                 # NOVO: Estado runtime compartilhado
    ├── .memoria/               # Existente (reestruturado)
    └── .config/                # Existente
```

---

## Modulo 1: Kernel - Escalonador de Tarefas

### Problema que Resolve
Hoje nao ha priorizacao. Se o usuario pede 3 coisas, executamos na ordem que chegou. Nao ha conceito de urgencia, peso computacional ou preempcao.

### Solucao: Task Scheduler

```yaml
# kernel/scheduler/scheduler.yaml
scheduler:
  estrategia: priority_queue  # fifo | priority_queue | round_robin

  prioridades:
    critica: 100    # Emergencias (caso critico CS, deadline hoje)
    alta: 75        # Tarefas com deadline proximo
    normal: 50      # Padrao
    baixa: 25       # Background, melhorias
    ociosa: 10      # Tarefas de manutencao

  regras:
    - condicao: "tarefa.tipo == 'cancelamento'"
      prioridade: critica
      motivo: "Cancelamentos tem SLA de 24h"

    - condicao: "tarefa.deadline < hoje + 2 dias"
      prioridade: alta
      motivo: "Deadline proximo"

    - condicao: "tarefa.tipo == 'health-check'"
      prioridade: ociosa
      motivo: "Manutencao de rotina"

  preempcao:
    habilitada: true
    salvar_estado: true  # Salva progresso da tarefa interrompida
    restaurar: true      # Retoma de onde parou

  limites:
    max_tarefas_ativas: 3
    max_paralelas: 5
    timeout_padrao: "30min"
```

### Ciclo de Vida da Tarefa

```
[Criada] → [Na Fila] → [Escalonada] → [Em Execucao] → [Validando] → [Concluida]
                ↑                            ↓
                ← ← ← [Pausada/Preemptada] ← ←
                                             ↓
                                        [Falha] → [Retry] → [Na Fila]
                                             ↓
                                        [Abandonada]
```

### Implementacao

```yaml
# kernel/scheduler/task-state.yaml
# Estado persistido de cada tarefa

task:
  id: "task_20260219_001"
  tipo: "criar-email"
  extensao: "marketing"
  agente: "copywriter"
  prioridade: normal
  estado: em_execucao
  criada_em: "2026-02-19T10:00:00"
  iniciada_em: "2026-02-19T10:01:00"
  progresso: 60  # percentual
  checkpoint:
    fase_atual: 3
    dados_parciais: "workspace/.state/task_001_checkpoint.yaml"
  dependencias: []
  timeout: "30min"
  retries: 0
  max_retries: 2
```

---

## Modulo 2: Barramento de Comunicacao entre Agentes

### Problema que Resolve
Agentes nao conversam entre si. Quando o Copywriter precisa de informacoes do Estrategista, a transicao e manual e narrativa. Nao ha protocolo estruturado.

### Solucao: Message Bus + Blackboard

#### 2.1 Message Bus (Comunicacao Direta)

```yaml
# kernel/memory-bus/protocol.yaml
protocolo:
  formato_mensagem:
    de: "agente_origem"
    para: "agente_destino"     # ou "broadcast"
    tipo: "request|response|notify|handoff"
    prioridade: "normal"
    payload:
      acao: "o_que_precisa"
      dados: {}
      contexto: "por_que_precisa"
    timestamp: "ISO8601"
    ttl: "5min"               # Expira se nao for consumida

  tipos_mensagem:
    request:
      descricao: "Pede algo a outro agente"
      requer_resposta: true
      exemplo:
        de: "copywriter"
        para: "estrategista"
        tipo: "request"
        payload:
          acao: "obter_tom_de_voz"
          contexto: "Criando email de vendas, preciso do tom definido"

    handoff:
      descricao: "Transfere tarefa com contexto completo"
      requer_resposta: false
      exemplo:
        de: "estrategista"
        para: "copywriter"
        tipo: "handoff"
        payload:
          acao: "criar_copy"
          dados:
            icp: "resumo_do_icp"
            tom: "direto_e_conversacional"
            objetivo: "vender_curso_x"
          contexto: "Pesquisa finalizada, ICP definido. Seguir com copy."

    notify:
      descricao: "Avisa sem esperar resposta"
      requer_resposta: false
      exemplo:
        de: "designer"
        para: "broadcast"
        tipo: "notify"
        payload:
          acao: "paleta_atualizada"
          dados:
            primaria: "#1a1a2e"
            accent: "#e94560"
```

#### 2.2 Blackboard (Estado Compartilhado)

```yaml
# workspace/.state/blackboard.yaml
# Estado compartilhado que qualquer agente pode ler/escrever

sessao:
  id: "session_20260219"
  projeto: "lancamento-curso-x"

estado_compartilhado:
  marca:
    nome: "Empresa Y"
    tom_voz: "direto, conversacional, sem jargoes"
    cores:
      primaria: "#1a1a2e"
      accent: "#e94560"
    fonte_titulos: "Plus Jakarta Sans"
    ultima_atualizacao: "2026-02-19T09:30:00"
    atualizado_por: "designer"

  publico:
    icp: "Empresarios 30-50 anos, faturamento 50k-500k/mes"
    dor_principal: "Nao conseguem escalar sem perder qualidade"
    desejo_principal: "Liberdade de tempo sem abrir mao do faturamento"
    ultima_atualizacao: "2026-02-19T09:15:00"
    atualizado_por: "estrategista"

  oferta:
    produto: "Curso Master X"
    preco: "R$ 1.997"
    garantia: "30 dias"
    bonus: ["mentoria grupo", "templates", "comunidade"]
    ultima_atualizacao: "2026-02-19T09:45:00"
    atualizado_por: "estrategista"

  entregas:
    - tipo: "headline"
      status: "concluida"
      arquivo: "workspace/.../headline-v1.md"
      agente: "copywriter"
    - tipo: "landing_page"
      status: "em_andamento"
      arquivo: null
      agente: "copywriter"
```

### Beneficio Pratico

Antes (v4):
```
Usuario: "Cria a landing page"
Orquestrador: "Preciso saber as cores da marca..."
Usuario: "Azul e vermelho"
Orquestrador: "E o publico?"
Usuario: "Ja definimos, empresarios..."
[Perde-se 5 minutos repetindo contexto]
```

Depois (v5):
```
Usuario: "Cria a landing page"
Orquestrador: [Le blackboard] → Marca, publico e oferta ja definidos
Copywriter: [Le blackboard] → Usa ICP, tom de voz, cores
[Entrega em 30 segundos, sem perguntas]
```

---

## Modulo 3: Sistema de Eventos

### Problema que Resolve
O Sleep Agent so age quando o usuario pede. Nao reage a eventos do ambiente (arquivo criado, webhook recebido, timer disparado).

### Solucao: Event Bus

```yaml
# kernel/event-bus/events.yaml
event_bus:
  # Tipos de evento
  eventos:
    arquivo:
      - nome: "arquivo.criado"
        descricao: "Novo arquivo no workspace"
        payload: {caminho, tipo, tamanho}
      - nome: "arquivo.modificado"
        payload: {caminho, tipo, diff}

    tarefa:
      - nome: "tarefa.concluida"
        payload: {id, agente, resultado, duracao}
      - nome: "tarefa.falhou"
        payload: {id, agente, erro, tentativa}
      - nome: "tarefa.timeout"
        payload: {id, agente, timeout}

    memoria:
      - nome: "insight.novo"
        payload: {categoria, conteudo, fonte}
      - nome: "padrao.detectado"
        payload: {tipo, descricao, confianca}

    externo:
      - nome: "webhook.recebido"
        payload: {fonte, tipo, dados}
      - nome: "timer.disparado"
        payload: {id, agendamento}

    qualidade:
      - nome: "gate.falhou"
        payload: {nivel, verificacao, motivo}
      - nome: "gate.passou"
        payload: {nivel, verificacao}

  # Assinaturas (quem escuta o que)
  assinaturas:
    - evento: "tarefa.concluida"
      assinante: "scheduler"
      acao: "escalonar_proxima"

    - evento: "tarefa.falhou"
      assinante: "scheduler"
      acao: "avaliar_retry"

    - evento: "insight.novo"
      assinante: "memoria"
      acao: "persistir_e_indexar"

    - evento: "gate.falhou"
      assinante: "qualidade"
      acao: "registrar_e_sugerir_correcao"

    - evento: "tarefa.concluida"
      assinante: "blackboard"
      acao: "atualizar_estado"
```

### Reacoes Automaticas (Triggers)

```yaml
# kernel/event-bus/triggers.yaml
triggers:
  - nome: "auto-quality-check"
    evento: "tarefa.concluida"
    condicao: "tarefa.tipo in ['criar-email', 'criar-landing', 'criar-copy']"
    acao:
      agente: "revisor"
      tarefa: "validar-qualidade"
      prioridade: alta
    descricao: "Toda entrega de copy passa por revisao automatica"

  - nome: "alert-on-failure"
    evento: "tarefa.falhou"
    condicao: "tarefa.retries >= tarefa.max_retries"
    acao:
      tipo: "notificar_usuario"
      mensagem: "A tarefa {tarefa.nome} falhou apos {tarefa.retries} tentativas."
    descricao: "Avisa o usuario quando uma tarefa esgota retentativas"

  - nome: "auto-save-insight"
    evento: "tarefa.concluida"
    condicao: "tarefa.aprendizados.length > 0"
    acao:
      agente: "memoria"
      tarefa: "persistir-insights"
      dados: "tarefa.aprendizados"
    descricao: "Salva insights automaticamente ao concluir tarefa"
```

---

## Modulo 4: Registro Centralizado de Ferramentas

### Problema que Resolve
Ferramentas (APIs, scripts, integracoes) estao espalhadas por extensoes. Nao ha inventario central. Um agente nao sabe que ferramentas outro agente tem.

### Solucao: Tool Registry

```yaml
# kernel/tool-registry/registry.yaml
ferramentas:
  # APIs Externas
  - id: "activecampaign"
    tipo: "api"
    categoria: "crm"
    capacidades:
      - "buscar_contato"
      - "criar_deal"
      - "enviar_email"
      - "atualizar_campo"
    autenticacao: "api_key"
    env_var: "ACTIVECAMPAIGN_API_KEY"
    extensoes_que_usam: ["customer-success", "marketing"]
    disponivel: true

  - id: "curseduca"
    tipo: "api"
    categoria: "plataforma_ensino"
    capacidades:
      - "buscar_membro"
      - "listar_matriculas"
      - "ver_progresso"
      - "gerenciar_grupos"
    autenticacao: "api_key + bearer"
    env_vars: ["CURSEDUCA_API_KEY", "CURSEDUCA_BEARER"]
    extensoes_que_usam: ["customer-success"]
    disponivel: true

  - id: "mautic"
    tipo: "api"
    categoria: "email_marketing"
    capacidades:
      - "criar_email"
      - "criar_campanha"
      - "segmentar_contatos"
    extensoes_que_usam: ["marketing"]
    disponivel: true

  # Scripts Locais
  - id: "cancelamento_consultar"
    tipo: "script"
    categoria: "automacao"
    caminho: "workspace/academia-lendaria/scripts/cancelamento_consultar_plataformas.py"
    capacidades:
      - "consultar_plataformas_cancelamento"
    dependencias: ["python3", "requests", "dotenv"]
    extensoes_que_usam: ["customer-success"]
    disponivel: true

  # Ferramentas Internas
  - id: "gerador_html"
    tipo: "interno"
    categoria: "output"
    capacidades:
      - "gerar_landing_page"
      - "gerar_email_html"
    templates: "extensoes/marketing/templates/"
    extensoes_que_usam: ["marketing"]
    disponivel: true
```

### Descoberta Dinamica

```yaml
# kernel/tool-registry/discovery.yaml
discovery:
  ao_carregar_extensao:
    - escanear: "extensao/ferramentas/"
    - registrar_no_registry: true
    - validar_credenciais: true
    - marcar_disponibilidade: true

  ao_executar_tarefa:
    - agente_pode_pedir: "preciso de uma ferramenta que faca X"
    - registry_responde: "ferramenta Y tem essa capacidade"
    - agente_usa: "ferramenta Y com parametros Z"
```

---

## Modulo 5: Memoria Hierarquica

### Problema que Resolve
A memoria atual e flat (4 arquivos YAML sem hierarquia). Tudo tem o mesmo peso. Nao ha busca por relevancia. Itens antigos nunca expiram.

### Solucao: Memoria em 3 Camadas

```yaml
# core/memoria/hierarquia.yaml
camadas:
  # Camada 1: Memoria de Trabalho (sessao atual)
  trabalho:
    localizacao: "workspace/.state/memoria-trabalho.yaml"
    duracao: "sessao"
    capacidade: 50  # itens
    tipo: "contexto imediato"
    exemplos:
      - "O usuario esta trabalhando no lancamento do Curso X"
      - "Ja definimos ICP, oferta e 3 headlines"
      - "Proximo passo: criar landing page"
    descarte: "ao_encerrar_sessao"

  # Camada 2: Memoria Episodica (ultimas semanas)
  episodica:
    localizacao: "workspace/.memoria/episodica/"
    duracao: "30 dias"
    capacidade: 200  # itens
    tipo: "eventos recentes com contexto"
    exemplos:
      - "Em 15/02 criamos campanha de email para Produto Y. Taxa de abertura esperada: 25%."
      - "Em 10/02 o usuario rejeitou headline com tom agressivo. Prefere abordagem consultiva."
    decaimento:
      estrategia: "exponencial"
      meia_vida: "15 dias"
      relevancia_minima: 0.3  # Abaixo disso, arquiva
    promocao: "Se acessado 3+ vezes, promove para semantica"

  # Camada 3: Memoria Semantica (permanente)
  semantica:
    localizacao: "workspace/.memoria/semantica/"
    duracao: "permanente"
    tipo: "conhecimento consolidado, regras, padroes"
    exemplos:
      - "Tom de voz da marca: direto, conversacional, sem jargoes"
      - "Publico rejeita promessas exageradas"
      - "Cor primaria da marca: #1a1a2e"
    categorias:
      - marca      # Identidade, valores, visual
      - publico    # ICP, personas, comportamentos
      - produto    # Ofertas, precos, garantias
      - processo   # Como o usuario gosta de trabalhar
      - tecnico    # Padroes tecnicos (formato email, tamanho landing)
    indexacao:
      por_categoria: true
      por_extensao: true
      por_relevancia: true
```

### Busca por Relevancia

```yaml
# core/memoria/busca.yaml
busca:
  ao_iniciar_tarefa:
    - identificar: "tipo da tarefa, extensao, agente"
    - buscar_trabalho: "contexto da sessao atual"
    - buscar_episodica: "tarefas similares recentes"
    - buscar_semantica: "regras e padroes aplicaveis"
    - montar_contexto: "combinar as 3 camadas por relevancia"

  scoring:
    fatores:
      - recencia: 0.3       # Quanto mais recente, mais relevante
      - frequencia: 0.2     # Quanto mais acessado, mais relevante
      - categoria: 0.3      # Match de categoria com tarefa atual
      - explicita: 0.2      # O usuario marcou como importante?

    formula: "score = (recencia * 0.3) + (frequencia * 0.2) + (categoria * 0.3) + (explicita * 0.2)"
    threshold: 0.4           # Abaixo disso, nao incluir no contexto
```

---

## Modulo 6: Ciclo de Vida de Agentes

### Problema que Resolve
Agentes sao definidos estaticamente. Nao ha conceito de "inicializar", "aquecer", "pausar" ou "encerrar". Nao ha como um agente manter estado proprio entre chamadas.

### Solucao: Agent Lifecycle

```yaml
# kernel/lifecycle/lifecycle.yaml
ciclo_de_vida:
  estados:
    registrado:
      descricao: "Agente existe mas nao foi carregado"
      transicoes: [inicializar]

    inicializado:
      descricao: "Agente carregou suas instrucoes e conhecimento"
      hooks: [on_init]
      transicoes: [ativar, suspender]

    ativo:
      descricao: "Agente esta executando uma tarefa"
      hooks: [on_activate]
      transicoes: [pausar, concluir, falhar]

    pausado:
      descricao: "Agente salvou checkpoint e aguarda retomada"
      hooks: [on_pause]
      transicoes: [ativar, suspender]

    suspenso:
      descricao: "Agente liberou recursos, pode ser reativado"
      hooks: [on_suspend]
      transicoes: [inicializar]

    concluido:
      descricao: "Agente finalizou tarefa com sucesso"
      hooks: [on_complete]
      transicoes: [registrado]

    falha:
      descricao: "Agente encontrou erro irrecuperavel"
      hooks: [on_error]
      transicoes: [inicializar, registrado]

  hooks:
    on_init:
      - "Carregar instrucoes do agente"
      - "Carregar conhecimento relevante"
      - "Buscar memoria relacionada"
      - "Verificar ferramentas necessarias"

    on_activate:
      - "Registrar inicio no status"
      - "Carregar checkpoint se existir"
      - "Notificar event-bus: agente.ativado"

    on_pause:
      - "Salvar checkpoint com progresso"
      - "Liberar recursos nao essenciais"
      - "Notificar event-bus: agente.pausado"

    on_complete:
      - "Salvar resultado final"
      - "Atualizar blackboard"
      - "Capturar aprendizados"
      - "Notificar event-bus: tarefa.concluida"
      - "Executar quality gates"

    on_error:
      - "Registrar erro com contexto"
      - "Salvar estado para diagnostico"
      - "Notificar event-bus: tarefa.falhou"
      - "Avaliar se retry e viavel"
```

---

## Modulo 7: Gerenciador Inteligente de Contexto

### Problema que Resolve
Hoje o sistema carrega "tudo" ao iniciar uma extensao: CLAUDE.md, agentes, conhecimento, delegacao. Isso e ineficiente quando so precisa de uma tarefa simples.

### Solucao: Context Manager com Carregamento Progressivo

```yaml
# kernel/context-manager/strategy.yaml
estrategia:
  # Nivel 0: Sempre carregado (kernel)
  permanente:
    - ".claude/CLAUDE.md"              # Identidade
    - "kernel/scheduler/scheduler.yaml" # Escalonador
    - "workspace/.state/blackboard.yaml" # Estado compartilhado
    peso_estimado: "~3KB"

  # Nivel 1: Carregado sob demanda (extensao)
  extensao:
    trigger: "usuario pede algo que exige extensao"
    carregar:
      - "extensoes/{nome}/.claude/CLAUDE.md"
      - "extensoes/{nome}/core/orquestrador/delegacao.yaml"
    peso_estimado: "~2KB por extensao"

  # Nivel 2: Carregado quando necessario (agente)
  agente:
    trigger: "tarefa delegada a agente especifico"
    carregar:
      - "extensoes/{ext}/agentes/{nome}.md"
      - "extensoes/{ext}/conhecimento/{relevante}.md"  # So os relevantes!
    peso_estimado: "~5KB por agente"

  # Nivel 3: Carregado por referencia (conhecimento profundo)
  conhecimento:
    trigger: "agente precisa de informacao especifica"
    carregar:
      - "extensoes/{ext}/conhecimento/{topico}.md"
      - "extensoes/{ext}/frameworks/{framework}.md"
    estrategia: "lazy_load"  # So carrega quando realmente precisa
    peso_estimado: "variavel"

  # Descarregamento
  descarregar:
    condicao: "contexto > 80% capacidade"
    prioridade_descarte:
      1: "conhecimento nao usado nos ultimos 3 turnos"
      2: "extensoes inativas"
      3: "historico de mensagens antigas (sumarizar)"
    estrategia: "LRU"  # Least Recently Used
```

### Sumarizacao Inteligente

```yaml
# kernel/context-manager/summarization.yaml
sumarizacao:
  quando: "contexto acima de 70% capacidade"

  regras:
    - tipo: "conversa_longa"
      acao: "Sumarizar turnos antigos, manter ultimos 5 intactos"
      formato: "## Resumo da conversa ate aqui\n{resumo}\n\n## Continuacao"

    - tipo: "conhecimento_carregado"
      acao: "Extrair apenas pontos relevantes para a tarefa atual"
      formato: "Pontos relevantes de {fonte}: {pontos}"

    - tipo: "resultados_anteriores"
      acao: "Manter apenas conclusoes, descartar processo"
      formato: "Resultado de {tarefa}: {conclusao}"
```

---

## Modulo 8: Workflows com Grafo de Dependencias

### Problema que Resolve
Dependencias entre fases sao definidas manualmente pela ordem numerica. Nao ha resolucao automatica. Sem retry, fallback ou circuit breaker.

### Solucao: DAG (Directed Acyclic Graph) de Tarefas

```yaml
# core/workflows/dag-engine.yaml
dag_engine:
  resolucao:
    estrategia: "topological_sort"
    descricao: "Resolve automaticamente a ordem baseado em dependencias"

  exemplo:
    # Lancamento de Produto
    tarefas:
      pesquisa:
        agente: estrategista
        dependencias: []  # Nenhuma - pode comecar imediatamente

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
        dependencias: [pesquisa]  # So precisa da pesquisa!

      landing:
        agente: copywriter
        dependencias: [headline, subheadline, paleta, oferta]

      email_sequencia:
        agente: copywriter
        dependencias: [icp, oferta]  # Paralelo com landing!

      anuncios:
        agente: trafego
        dependencias: [icp, headline]

    # Resolucao automatica do grafo:
    # Fase 1: pesquisa
    # Fase 2: icp + paleta (paralelo)
    # Fase 3: oferta
    # Fase 4: headline + email_sequencia (paralelo)
    # Fase 5: subheadline + anuncios (paralelo)
    # Fase 6: landing

  resiliencia:
    retry:
      max_tentativas: 3
      backoff: "exponencial"  # 1s, 2s, 4s
      condicao: "erro_transiente"

    fallback:
      habilitado: true
      estrategia: "agente_alternativo"
      exemplo:
        tarefa: "criar-headline"
        agente_primario: "copywriter"
        agente_fallback: "estrategista"  # Pode criar headline basica

    circuit_breaker:
      threshold: 3  # Falhas consecutivas
      acao: "pausar_workflow_e_notificar"
      cooldown: "5min"
```

---

## Modulo 9: Auto-Calibracao de Qualidade

### Problema que Resolve
Quality Gates sao estaticos. Nao aprendem. Se um tipo de copy sempre passa pelo gate mas o usuario sempre pede ajustes, o gate nao se adapta.

### Solucao: Feedback Loop nos Quality Gates

```yaml
# core/qualidade/auto-calibracao.yaml
calibracao:
  tracking:
    por_tarefa:
      - tarefa: "criar-headline"
        total_execucoes: 47
        aprovadas_primeiro_gate: 38  # 80.8%
        ajustes_apos_gate: 9
        tipos_ajuste:
          - "tom mais informal": 5
          - "mais curta": 3
          - "sem jargao": 1

  aprendizado:
    regra: "Se mesmo ajuste pedido 3+ vezes, criar novo gate"
    exemplo:
      deteccao: "'tom mais informal' pedido 5x em headlines"
      novo_gate:
        nivel: 1
        verificacao: "Tom informal? (sem palavras formais como 'portanto', 'entretanto', 'ademais')"
        auto_correcao: true

  metricas:
    taxa_aprovacao_alvo: 90  # percentual
    se_abaixo:
      - "Revisar gates existentes"
      - "Analisar padroes de ajuste"
      - "Sugerir novos gates ao usuario"
    se_acima:
      - "Gates podem estar frouxos"
      - "Considerar adicionar verificacoes"
```

---

## Modulo 10: Observabilidade Profunda

### Problema que Resolve
O `/status` atual e basico. Nao ha metricas historicas, nao ha como saber quais agentes sao mais usados, quais tarefas demoram mais, onde estao os gargalos.

### Solucao: Dashboard de Metricas

```yaml
# core/status/metricas.yaml
metricas:
  por_sessao:
    - tarefas_executadas: 0
    - tempo_total: "0min"
    - extensoes_usadas: []
    - agentes_ativos: []
    - erros: 0
    - gates_falhados: 0

  historico:
    - data: "2026-02-19"
      tarefas: 12
      tempo_medio: "2.5min"
      extensao_mais_usada: "marketing"
      agente_mais_ativo: "copywriter"
      taxa_aprovacao: "87%"
      memoria_itens_novos: 3

  insights_operacionais:
    agente_mais_eficiente: "copywriter (1.8min media)"
    agente_mais_lento: "estrategista (4.2min media)"
    tarefa_mais_refeita: "criar-headline (2.3 iteracoes media)"
    horario_pico: "09:00-11:00"
    extensao_subutilizada: "dados (0 usos no mes)"

  alertas_operacionais:
    - tipo: "degradacao"
      condicao: "tempo_medio > 5min por 3 sessoes consecutivas"
      acao: "Investigar causa da lentidao"

    - tipo: "qualidade"
      condicao: "taxa_aprovacao < 80% por 5 sessoes"
      acao: "Revisar quality gates e calibrar"

    - tipo: "uso"
      condicao: "extensao nao usada em 30 dias"
      acao: "Sugerir remocao ou lembrar capacidades"
```

### Comando `/dashboard`

```
Dashboard do Sleep Agent
========================

Sessao Atual (19/02/2026)
  Tarefas: 5 concluidas | 1 em andamento | 2 na fila
  Tempo: 12min total | 2.4min media
  Agentes: copywriter (3) | estrategista (2) | designer (1)

Ultimos 7 Dias
  Total tarefas: 34 | Taxa aprovacao: 89%
  Extensao top: marketing (22 tarefas)
  Insight novo: "Usuario prefere headlines com perguntas"

Saude
  Memoria: 145/200 itens episodicos | 23 semanticos
  Blackboard: atualizado ha 5min
  Ferramentas: 8/8 disponiveis
  Quality Gates: calibrados (ultima calibracao: hoje)
```

---

## Roadmap de Implementacao

### Fase 1: Fundacao (Semana 1-2)
**Prioridade: CRITICA**

| # | Modulo | Esforco | Impacto |
|---|--------|---------|---------|
| 1 | Blackboard (Estado Compartilhado) | Medio | Altissimo |
| 2 | Memoria Hierarquica (3 camadas) | Medio | Alto |
| 3 | Message Bus basico (handoff) | Baixo | Alto |

**Justificativa:** Blackboard sozinho resolve 60% dos problemas de contexto entre agentes. Memoria hierarquica evita poluicao. Message Bus permite handoffs estruturados.

### Fase 2: Inteligencia (Semana 3-4)
**Prioridade: ALTA**

| # | Modulo | Esforco | Impacto |
|---|--------|---------|---------|
| 4 | Context Manager (carregamento progressivo) | Alto | Alto |
| 5 | Tool Registry (inventario de ferramentas) | Medio | Medio |
| 6 | Auto-Calibracao de Quality Gates | Medio | Medio |

**Justificativa:** Context Manager torna o sistema eficiente. Tool Registry organiza ferramentas existentes. Auto-Calibracao melhora qualidade ao longo do tempo.

### Fase 3: Autonomia (Semana 5-6)
**Prioridade: MEDIA**

| # | Modulo | Esforco | Impacto |
|---|--------|---------|---------|
| 7 | Task Scheduler | Alto | Alto |
| 8 | Agent Lifecycle | Medio | Medio |
| 9 | DAG Workflows | Alto | Alto |

**Justificativa:** Scheduler permite priorizacao inteligente. Lifecycle traz robustez. DAG substitui workflows rigidos por grafos flexiveis.

### Fase 4: Reatividade (Semana 7-8)
**Prioridade: MEDIA**

| # | Modulo | Esforco | Impacto |
|---|--------|---------|---------|
| 10 | Event Bus | Alto | Medio |
| 11 | Triggers automaticos | Medio | Medio |
| 12 | Observabilidade (Dashboard) | Baixo | Medio |

**Justificativa:** Event Bus e o modulo mais ambicioso mas menos urgente. Triggers adicionam proatividade. Dashboard da visibilidade.

---

## Principios de Design v5

1. **Convention over Configuration** - Tudo funciona com defaults inteligentes. Usuario so configura se quiser personalizar.

2. **Progressive Disclosure** - Sistema mostra complexidade gradualmente. Iniciante ve comandos simples, avancado acessa scheduler e DAG.

3. **Fail Gracefully** - Nenhum erro deve travar o sistema. Sempre ha fallback, retry ou degradacao elegante.

4. **Memory-First** - Toda interacao enriquece a memoria. O sistema fica mais inteligente a cada uso.

5. **Agents as First-Class Citizens** - Agentes nao sao funcoes. Tem identidade, estado, ciclo de vida e capacidade de comunicacao.

6. **Observable by Default** - Tudo que acontece e registrado, medido e reportavel.

7. **Zero-Config Start** - Mesmo com todos os modulos v5, o primeiro uso continua simples: digita um comando, recebe resultado.

---

## Metricas de Sucesso

| Metrica | v4 Atual | v5 Meta |
|---------|----------|---------|
| Perguntas de contexto por tarefa | ~3 | 0-1 |
| Tempo medio por tarefa | 4min | 2min |
| Taxa de aprovacao 1a tentativa | ~75% | 90% |
| Retrabalho por falta de contexto | ~40% | <10% |
| Tarefas que requerem intervencao manual | ~60% | <30% |
| Tempo para onboarding de nova extensao | 30min | 5min |

---

## Compatibilidade com v4

- Todos os comandos v4 continuam funcionando identicamente
- Extensoes v4 funcionam sem modificacao (interface compativel)
- Memoria v4 e migrada automaticamente para hierarquia v5
- Workflows v4 funcionam (DAG e opt-in para novos workflows)
- Zero breaking changes para o usuario

---

*Documento gerado em 19/02/2026*
*Versao: 1.0*
*Status: Proposta para aprovacao*
