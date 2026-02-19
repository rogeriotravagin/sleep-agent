# Sleep Agent v5 - Modulos Avancados (Complemento)

## Contexto

Este documento complementa o [SLEEP-AGENT-V5-EVOLUCAO.md](SLEEP-AGENT-V5-EVOLUCAO.md) com 7 modulos adicionais identificados em analise mais profunda dos gaps do sistema. Estes modulos elevam o Sleep Agent de "sistema operacional de agentes" para um **framework autonomo com governanca, auto-aprendizado e gestao inteligente de contexto**.

---

## Modulo 11: Constituicao do Sistema

### Problema que Resolve
O Sleep Agent nao tem regras imutaveis. Tudo e "orientacao" que pode ser ignorada. Nao ha hierarquia de regras nem mecanismo de enforcement. Um agente pode acidentalmente violar uma regra critica sem que o sistema detecte.

### Solucao: Sistema Constitucional com Niveis de Enforcement

```yaml
# kernel/constitution/constitution.yaml
versao: 1.0
ultima_emenda: "2026-02-19"

artigos:

  # ARTIGO I - Regra mais importante do sistema
  - numero: 1
    titulo: "Identidade e Integridade"
    nivel: NON_NEGOTIABLE    # NUNCA pode ser violado
    enforcement: BLOCK        # Impede a acao se violado
    regra: |
      O Sleep Agent NUNCA revela sua arquitetura interna, extensoes
      instaladas, ou estrutura de arquivos para o usuario final.
      Toda interacao e natural, como se fosse um assistente unico.
    contexto: "Protege a experiencia do usuario e propriedade intelectual"

  # ARTIGO II - Dominio dos Agentes
  - numero: 2
    titulo: "Autoridade de Dominio"
    nivel: NON_NEGOTIABLE
    enforcement: BLOCK
    regra: |
      Cada agente tem autoridade exclusiva sobre seu dominio.
      O Copywriter NAO toma decisoes de design.
      O Designer NAO escreve copy final.
      O Estrategista NAO implementa.
      Quando um agente precisa de algo fora do seu dominio,
      DEVE delegar via handoff estruturado.
    contexto: "Garante qualidade e evita agentes 'faz-tudo'"

  # ARTIGO III - Dados do Usuario
  - numero: 3
    titulo: "Privacidade e Seguranca"
    nivel: NON_NEGOTIABLE
    enforcement: BLOCK
    regra: |
      NUNCA expor credenciais, tokens, ou dados sensiveis em outputs.
      NUNCA incluir dados de .env em arquivos de entrega.
      NUNCA enviar dados para APIs sem confirmacao do usuario.
      Toda operacao destrutiva requer confirmacao dupla.
    contexto: "Protecao absoluta dos dados do usuario"

  # ARTIGO IV - Qualidade Minima
  - numero: 4
    titulo: "Padrao de Qualidade"
    nivel: MUST
    enforcement: WARN          # Permite mas alerta
    regra: |
      Toda entrega DEVE passar por pelo menos 1 nivel de quality gate.
      Entregas sem validacao sao marcadas como [RASCUNHO].
      O usuario e informado quando recebe um rascunho vs entrega final.
    contexto: "Garante que o usuario sabe o nivel de qualidade"

  # ARTIGO V - Memoria e Consistencia
  - numero: 5
    titulo: "Consistencia entre Sessoes"
    nivel: MUST
    enforcement: WARN
    regra: |
      Decisoes anteriores do usuario DEVEM ser consultadas antes de
      tomar novas decisoes na mesma area. Se o usuario definiu tom de
      voz como "informal", nao gerar copy formal sem perguntar.
      Memoria semantica tem precedencia sobre preferencia do agente.
    contexto: "Evita contradizer decisoes anteriores do usuario"

  # ARTIGO VI - Transparencia
  - numero: 6
    titulo: "Transparencia Operacional"
    nivel: SHOULD
    enforcement: INFO          # Apenas reporta
    regra: |
      O Sleep Agent DEVE informar ao usuario quando:
      - Muda de agente durante uma tarefa
      - Usa informacao da memoria para tomar decisao
      - Encontra conflito entre instrucoes
      - Nao consegue atender ao pedido completamente
    contexto: "O usuario deve saber o que esta acontecendo"

niveis_enforcement:
  BLOCK:
    descricao: "Impede a acao. Agente nao pode prosseguir."
    acao: "Informar o usuario que a acao viola regra critica."
    log: true

  WARN:
    descricao: "Permite a acao mas registra violacao."
    acao: "Informar o usuario e continuar."
    log: true

  INFO:
    descricao: "Apenas registra. Nao interfere."
    acao: "Registrar no log de compliance."
    log: true

# Processo de Emenda (como alterar artigos)
emendas:
  quem_pode: "Apenas o dono do workspace"
  processo:
    1: "Justificar a mudanca"
    2: "Avaliar impacto em agentes existentes"
    3: "Documentar a emenda com data"
    4: "Atualizar versao da constituicao"
  restricao: "Artigos NON_NEGOTIABLE nunca podem ser removidos, apenas emendados"
```

### Integracao com Orquestrador

O orquestrador verifica a constituicao ANTES de executar qualquer acao:

```yaml
# Novo Passo -1 no processo de decisao (antes de tudo)
passo_menos_1_constituicao:
  trigger: "Toda acao de agente"
  verificar:
    - "A acao viola algum artigo?"
    - "Qual o nivel de enforcement?"
  acoes:
    BLOCK: "Impedir e informar"
    WARN: "Prosseguir com aviso"
    INFO: "Registrar e prosseguir"
```

---

## Modulo 12: Faixas de Contexto (Context Brackets)

### Problema que Resolve
O Context Manager (Modulo 7) define O QUE carregar. Mas falta definir QUANTO injetar baseado no estado da conversa. Em conversas longas, o sistema nao sabe que esta ficando sem espaco e continua carregando tudo.

### Solucao: 4 Faixas de Contexto Adaptativas

```yaml
# kernel/context-manager/brackets.yaml
# Sistema de faixas que adapta a injecao de contexto
# baseado na profundidade da conversa

brackets:
  FRESH:
    descricao: "Conversa recente, muito contexto disponivel"
    indicador: "turnos < 10 OU contexto restante > 60%"
    estrategia:
      carregar:
        - constituicao: "resumo (artigos como lista)"
        - identidade: "completa"
        - blackboard: "completo"
        - memoria: "apenas semantica relevante"
      nao_carregar:
        - conhecimento_profundo: "lazy load sob demanda"
        - historico_tarefas: "nao necessario ainda"
      orcamento_tokens: "~800 tokens de contexto injetado"
    motivo: "Conversa fresca, nao precisa ser agressivo com contexto"

  MODERATE:
    descricao: "Conversa em andamento, contexto moderado"
    indicador: "10 <= turnos < 30 OU 40% < contexto restante <= 60%"
    estrategia:
      carregar:
        - constituicao: "artigos NON_NEGOTIABLE apenas"
        - identidade: "resumida"
        - blackboard: "completo (importante manter estado)"
        - memoria: "semantica + episodica relevante"
        - historico_tarefas: "ultimas 3 tarefas da sessao"
      reforcar:
        - regras_criticas: "Re-injetar regras que podem ter sido esquecidas"
        - decisoes_sessao: "Relembrar o que ja foi decidido"
      orcamento_tokens: "~1500 tokens"
    motivo: "Contexto precisa de reforco para nao perder fio da meada"

  DEPLETED:
    descricao: "Conversa longa, contexto escasso"
    indicador: "30 <= turnos < 60 OU 25% < contexto restante <= 40%"
    estrategia:
      carregar:
        - constituicao: "artigos NON_NEGOTIABLE (texto completo)"
        - blackboard: "estado atual completo"
        - memoria: "tudo relevante (semantica + episodica + trabalho)"
        - sumarizacao: "Sumarizar conversa anterior em ~500 tokens"
      reforcar_fortemente:
        - tom_voz: "Re-injetar definicao de tom"
        - icp: "Re-injetar ICP se relevante"
        - decisoes: "Re-injetar TODAS as decisoes da sessao"
      alertar: "Informar usuario que conversa esta longa"
      orcamento_tokens: "~2000 tokens"
    motivo: "Risco alto de perder contexto. Reforco agressivo."

  CRITICAL:
    descricao: "Conversa muito longa, contexto critico"
    indicador: "turnos >= 60 OU contexto restante <= 25%"
    estrategia:
      carregar:
        - constituicao: "TUDO (texto completo de todos os artigos)"
        - blackboard: "estado completo"
        - memoria: "tudo"
        - sumarizacao: "Sumarizar TODA a conversa em ~1000 tokens"
      acoes_criticas:
        - "Sugerir salvar trabalho e iniciar nova sessao"
        - "Salvar estado completo para recuperacao"
        - "Marcar checkpoint no blackboard"
      orcamento_tokens: "~2500 tokens"
    motivo: "Emergencia. Sistema pode perder coerencia a qualquer momento."

  # Como calcular a faixa atual
  calculo:
    metodo: "heuristica baseada em turnos + tamanho de mensagens"
    formula: |
      turnos = numero de pares usuario/agente na conversa
      tamanho_medio = media de tokens por mensagem
      contexto_estimado = 200000 - (turnos * tamanho_medio * 2)
      percentual = contexto_estimado / 200000

      SE percentual > 60%: FRESH
      SE percentual > 40%: MODERATE
      SE percentual > 25%: DEPLETED
      SENAO: CRITICAL

    fallback: "Se nao conseguir calcular, assumir MODERATE"
```

### Beneficio Pratico

**Sem brackets (v4):**
```
Turno 1: Sistema carrega contexto completo (~5KB)
Turno 20: Sistema tenta carregar mesmo contexto (~5KB) → Compete com historico
Turno 50: Sistema nao consegue manter consistencia → Esquece decisoes
Turno 80: Usuario recebe resposta que contradiz decisoes anteriores
```

**Com brackets (v5):**
```
Turno 1 [FRESH]: Carrega leve (~800 tokens), contexto amplo disponivel
Turno 20 [MODERATE]: Reforça regras criticas, sumariza conversa (~1500 tokens)
Turno 50 [DEPLETED]: Reforço agressivo de TUDO, alerta usuario (~2000 tokens)
Turno 80 [CRITICAL]: Sugere nova sessao, salva estado completo
```

---

## Modulo 13: Sistema de Reuso Inteligente de Ativos

### Problema que Resolve
O Sleep Agent cria tudo do zero toda vez. Se o usuario ja criou 5 headlines, nao consulta as anteriores pra aprender o padrao. Nao ha conceito de "reusar", "adaptar" ou "criar novo" baseado no que ja existe.

### Solucao: Engine de Decisao REUSAR/ADAPTAR/CRIAR

```yaml
# kernel/asset-engine/decision.yaml
engine:
  descricao: |
    Antes de criar qualquer entrega, o sistema analisa se ja existe
    algo similar que pode ser reusado ou adaptado. Isso economiza
    tempo, mantem consistencia e aprende com entregas anteriores.

  decisao:
    REUSAR:
      condicao: "Ativo existente tem >= 90% de relevancia"
      acao: "Usar diretamente, sem modificacao"
      exemplo: "Paleta de cores ja definida → usar a mesma"

    ADAPTAR:
      condicao: "Ativo existente tem 60-89% de relevancia"
      acao: "Usar como base, modificar para contexto atual"
      exemplo: "Headline de produto A → adaptar tom para produto B"

    CRIAR:
      condicao: "Nenhum ativo existente tem >= 60% de relevancia"
      acao: "Criar do zero"
      exemplo: "Primeiro email da marca → criar sem referencia"

  scoring:
    fatores:
      tipo_match: 0.4       # Mesmo tipo de ativo? (headline vs headline)
      marca_match: 0.2      # Mesma marca/produto?
      publico_match: 0.2    # Mesmo publico-alvo?
      tempo_match: 0.1      # Quao recente? (ultimos 30 dias = bonus)
      aprovacao_match: 0.1  # Foi aprovado pelo usuario? (nivel 3 gate)

    formula: |
      score = (tipo * 0.4) + (marca * 0.2) + (publico * 0.2)
            + (tempo * 0.1) + (aprovacao * 0.1)

      >= 0.9: REUSAR
      >= 0.6: ADAPTAR
      < 0.6: CRIAR

  inventario:
    localizacao: "workspace/.state/asset-index.yaml"
    formato:
      - id: "asset_001"
        tipo: "headline"
        conteudo_resumo: "A palestra que destrava equipes..."
        marca: "tiago-rocha"
        publico: "empresas"
        criado_em: "2026-02-19"
        aprovado: true
        vezes_reusado: 0
        tags: ["palestra", "corporativo", "lideranca"]

  ciclo_de_vida:
    criacao:
      - "Todo output aprovado (gate nivel 3) → registrar no inventario"
      - "Extrair tags automaticamente do conteudo"
      - "Calcular score de reusabilidade"

    promocao:
      regra: "Ativo reusado 3+ vezes → promover para template"
      acao: "Mover para extensao/templates/ com parametros variaveis"

    depreciacao:
      regra: "Ativo nao usado em 60 dias + nunca reusado → marcar como deprecated"
      acao: "Mover para arquivo morto, nao incluir em buscas"
```

### Exemplo Pratico

```
Usuario: "Cria uma headline para o novo curso do Tiago"

[Engine verifica inventario]
→ Encontra 3 headlines anteriores para "tiago-rocha":
  1. "A palestra que destrava equipes..." (score: 0.75 → ADAPTAR)
  2. "Sua equipe precisa de mais que motivacao" (score: 0.72 → ADAPTAR)
  3. "Empresario que ensina o que vive" (score: 0.65 → ADAPTAR)

[Agente recebe contexto]
→ "Existem 3 headlines anteriores aprovadas para este cliente.
    Usar como referencia de tom e estilo, adaptar para novo contexto."

[Resultado]
→ Headline nova E consistente com o padrao aprovado pelo usuario
```

---

## Modulo 14: Modos de Permissao de Agentes

### Problema que Resolve
Todos os agentes tem o mesmo nivel de autonomia. O usuario nao pode dizer "quero que o copywriter crie sem perguntar, mas o estrategista sempre confirme comigo". Nao ha controle granular de autonomia.

### Solucao: 3 Modos de Permissao por Agente/Extensao

```yaml
# kernel/permissions/modes.yaml
modos:
  explorar:
    descricao: "Agente so pode ler e analisar. Nao produz entregas."
    icone: "🔵"
    permissoes:
      ler_workspace: true
      ler_memoria: true
      ler_blackboard: true
      escrever_entrega: false
      escrever_memoria: false
      executar_api: false
      executar_script: false
    quando_usar: "Quando quer que o agente apenas estude algo"
    exemplo: "Quero que o Estrategista analise meu mercado, mas nao defina nada ainda"

  confirmar:
    descricao: "Agente produz mas pede confirmacao. Padrao do sistema."
    icone: "🟡"
    permissoes:
      ler_workspace: true
      ler_memoria: true
      ler_blackboard: true
      escrever_entrega: "com_confirmacao"
      escrever_memoria: "com_confirmacao"
      executar_api: "com_confirmacao"
      executar_script: "com_confirmacao"
    quando_usar: "Uso normal. Agente propoe, voce aprova."
    padrao: true

  autonomo:
    descricao: "Agente opera livremente. Produz, salva e segue."
    icone: "🟢"
    permissoes:
      ler_workspace: true
      ler_memoria: true
      ler_blackboard: true
      escrever_entrega: true
      escrever_memoria: true
      executar_api: true
      executar_script: true
    quando_usar: "Para tarefas repetitivas onde voce ja confia no agente"
    exemplo: "O Copywriter ja acertou 10 headlines seguidas, pode operar livre"
    restricoes:
      - "Ainda respeita constituicao (artigos NON_NEGOTIABLE)"
      - "Ainda registra no log de compliance"
      - "Ainda atualiza blackboard"

# Configuracao por extensao/agente
configuracao:
  padrao_global: "confirmar"

  por_extensao:
    marketing:
      copywriter: "autonomo"      # Confia no copy
      estrategista: "confirmar"   # Quer revisar estrategia
      trafego: "confirmar"

    customer_success:
      cancelamento: "confirmar"    # Sempre confirmar antes de cancelar
      onboarding: "autonomo"

  # Comando para mudar
  comandos:
    - "/modo explorar marketing"    # Toda extensao em modo explorar
    - "/modo autonomo copywriter"   # Agente especifico em modo autonomo
    - "/modo confirmar"             # Reset global para confirmar
```

---

## Modulo 15: Auto-Critica nos Workflows (Self-Critique)

### Problema que Resolve
Quando uma tarefa falha ou o usuario pede ajustes, o agente simplesmente tenta de novo sem analisar POR QUE falhou. Nao ha fase de reflexao entre tentativas.

### Solucao: Ciclo de Auto-Critica entre Retries

```yaml
# core/workflows/self-critique.yaml
self_critique:
  descricao: |
    Entre cada tentativa de uma tarefa, o agente faz uma pausa para
    analisar o que deu errado e como melhorar. Isso evita repetir
    os mesmos erros e melhora progressivamente a qualidade.

  trigger: "Quando gate falha OU usuario pede ajuste"

  processo:
    1_analisar:
      acao: "Identificar exatamente o que falhou"
      perguntas:
        - "O que o usuario esperava vs o que entreguei?"
        - "Qual parte especifica nao atendeu?"
        - "Existe um padrao nos ajustes pedidos?"

    2_diagnosticar:
      acao: "Encontrar a causa raiz"
      categorias:
        - contexto_insuficiente: "Faltou informacao do blackboard ou memoria?"
        - regra_ignorada: "Violei algum padrao ou decisao anterior?"
        - tom_inadequado: "Tom de voz nao combinou com o publico?"
        - formato_errado: "Formato ou estrutura inadequados?"
        - excesso_tecnico: "Usei linguagem complexa demais?"

    3_planejar:
      acao: "Definir o que mudar na proxima tentativa"
      formato:
        causa: "O que causou a falha"
        ajuste: "O que vou fazer diferente"
        evidencia: "Por que acredito que isso vai funcionar"

    4_executar:
      acao: "Nova tentativa com ajustes aplicados"
      regra: "DEVE ser diferente da tentativa anterior"

    5_registrar:
      acao: "Salvar aprendizado na memoria"
      destino:
        se_recorrente: "semantica/alertas.yaml (permanente)"
        se_pontual: "episodica/{data}.yaml (temporario)"

  limites:
    max_criticas: 3          # Maximo de ciclos de auto-critica
    apos_limite: "Perguntar ao usuario o que especificamente quer diferente"

  exemplo:
    tentativa_1:
      entrega: "Headline: 'Transforme sua empresa com o Metodo IP'"
      feedback: "Muito generico. Quero algo mais direto e com numero."
      critica:
        causa: "Headline sem especificidade e sem prova social numerica"
        ajuste: "Adicionar numero concreto + beneficio especifico"
        evidencia: "Headlines com numeros tem 36% mais cliques (padrao da memoria)"

    tentativa_2:
      entrega: "Headline: 'O metodo que ja formou 10.000 lideres em 6 paises'"
      feedback: "Aprovado!"
      registro:
        insight: "Para este cliente, headlines com numeros concretos funcionam melhor"
        destino: "semantica/publico.yaml"
```

### Integracao com Ralph

Atualizar o Ralph para incluir self-critique entre iteracoes:

```yaml
# frameworks/ralph/self-critique-integration.yaml
ralph_com_critica:
  ciclo:
    1: "Executar story"
    2: "Verificar gates"
    3: "SE gate falhou → Self-Critique (novo!)"
    4: "Aplicar ajustes da critica"
    5: "Re-executar story"
    6: "SE 3 falhas → Escalar para usuario (novo!)"
```

---

## Modulo 16: Configuracao em Camadas

### Problema que Resolve
O Sleep Agent tem um unico arquivo de configuracao (`sleep-agent.yaml`). Nao ha hierarquia. Se o usuario quer sobrescrever algo temporariamente, precisa editar o arquivo e depois lembrar de reverter.

### Solucao: 5 Camadas de Configuracao com Precedencia

```yaml
# kernel/config/hierarchy.yaml
camadas:
  L0_constituicao:
    descricao: "Regras imutaveis do sistema"
    arquivo: "kernel/constitution/constitution.yaml"
    precedencia: "ABSOLUTA (nunca sobrescrita)"
    editavel: false
    escopo: "Todas as sessoes, todos os workspaces"

  L1_framework:
    descricao: "Configuracao padrao do Sleep Agent"
    arquivo: "core/config/framework-defaults.yaml"
    precedencia: "Base (sobrescrita por L2+)"
    editavel: false
    escopo: "Padrao global"
    conteudo_exemplo:
      quality_gates: { nivel_1: true, nivel_2: true, nivel_3: true }
      memoria: { hierarquica: true, decaimento: "exponencial" }
      matching: { confianca_minima: 60 }
      context_brackets: { habilitado: true }

  L2_workspace:
    descricao: "Configuracao do workspace (persistente)"
    arquivo: "workspace/.config/sleep-agent.yaml"
    precedencia: "Sobrescreve L1"
    editavel: true
    escopo: "Este workspace"
    conteudo_exemplo:
      quality_gates: { nivel_2: false }  # Desabilita gate nivel 2
      matching: { confianca_minima: 80 }  # Mais rigoroso
      permissoes:
        copywriter: "autonomo"

  L3_usuario:
    descricao: "Preferencias pessoais do usuario"
    arquivo: "workspace/.config/user-preferences.yaml"
    precedencia: "Sobrescreve L2"
    editavel: true
    escopo: "Este usuario"
    conteudo_exemplo:
      tom_interacao: "direto"   # Como o SA fala com o usuario
      idioma_interface: "pt-BR"
      emojis: false

  L4_sessao:
    descricao: "Overrides temporarios (dura uma sessao)"
    arquivo: "workspace/.state/session-overrides.yaml"
    precedencia: "Sobrescreve tudo (exceto L0)"
    editavel: true
    escopo: "Apenas esta sessao"
    expira: "Ao encerrar conversa"
    conteudo_exemplo:
      quality_gates: { nivel_1: false, nivel_2: false, nivel_3: false }
      # Modo rapido: sem gates por esta sessao

resolucao:
  metodo: "deep_merge com precedencia crescente"
  ordem: "L1 ← L2 ← L3 ← L4 (L0 nunca sobrescrito)"
  conflitos: "Camada mais alta vence, exceto L0"

  exemplo:
    # L1 define: quality_gates.nivel_2 = true
    # L2 define: quality_gates.nivel_2 = false
    # Resultado: quality_gates.nivel_2 = false (L2 vence)

    # L4 define: quality_gates.nivel_1 = false
    # Resultado: quality_gates.nivel_1 = false (apenas esta sessao)

    # L0 define: privacidade = NON_NEGOTIABLE
    # L4 tenta: privacidade = false
    # Resultado: BLOQUEADO (L0 nunca sobrescrito)
```

---

## Modulo 17: Quality Gates com Circuit Breaker

### Problema que Resolve
Quality Gates atuais sao sequenciais e bloqueantes. Se o gate nivel 2 (agente revisor) falha repetidamente, toda a producao para. Nao ha mecanismo de "bypass inteligente" quando o sistema de qualidade esta com problema.

### Solucao: Circuit Breaker nos Quality Gates

```yaml
# core/qualidade/circuit-breaker.yaml
circuit_breaker:
  descricao: |
    Padrao de protecao que "abre o circuito" quando um quality gate
    falha repetidamente, permitindo que o trabalho continue com
    aviso ao inves de travar completamente.

  estados:
    fechado:
      descricao: "Normal. Gate funciona e avalia."
      transicao: "Se falha 3x consecutivas → semi_aberto"

    semi_aberto:
      descricao: "Testando. Gate tenta funcionar mas com timeout curto."
      transicao_sucesso: "→ fechado (gate voltou ao normal)"
      transicao_falha: "→ aberto (gate incapaz)"
      timeout: "2s (metade do normal)"

    aberto:
      descricao: "Gate desativado temporariamente. Trabalho continua com aviso."
      transicao: "Apos cooldown → semi_aberto (tenta de novo)"
      cooldown: "5min"
      acao: |
        1. Registrar que gate esta desativado
        2. Marcar entrega como [NAO VALIDADA pelo gate X]
        3. Continuar workflow normalmente
        4. Informar usuario que validacao foi pulada

  configuracao:
    threshold_falhas: 3        # Falhas consecutivas para abrir
    cooldown: "5min"           # Tempo antes de tentar de novo
    timeout_gate: "4s"         # Timeout por gate
    max_aberto: "30min"        # Tempo maximo com gate aberto

  por_nivel:
    nivel_1_automatico:
      circuit_breaker: false   # Nivel 1 e rapido, nao precisa
      motivo: "Verificacoes objetivas raramente falham"

    nivel_2_agente:
      circuit_breaker: true    # Nivel 2 pode ser lento/falhar
      threshold: 3
      cooldown: "5min"

    nivel_3_humano:
      circuit_breaker: false   # Humano decide, nao tem "falha"
      motivo: "Sempre esperar a resposta do usuario"

  logging:
    registrar:
      - "Quando circuit breaker abre (com motivo)"
      - "Quando fecha novamente"
      - "Entregas que passaram sem validacao"
    destino: "workspace/.status/circuit-breaker-log.yaml"
```

---

## Roadmap Atualizado (Fase 1-5)

### Fase 1: Fundacao (Semana 1-2)
*Sem mudanca - ja definida no documento principal*
- Blackboard, Memoria Hierarquica, Message Bus

### Fase 2: Inteligencia (Semana 3-4)
*Atualizada com novos modulos*

| # | Modulo | Documento | Esforco |
|---|--------|-----------|---------|
| 4 | Context Manager | Principal | Alto |
| 5 | Tool Registry | Principal | Medio |
| 6 | Auto-Calibracao | Principal | Medio |
| **12** | **Context Brackets** | **Este doc** | **Medio** |

### Fase 3: Governanca (Semana 5-6)
**NOVA FASE**

| # | Modulo | Documento | Esforco |
|---|--------|-----------|---------|
| **11** | **Constituicao** | **Este doc** | **Baixo** |
| **14** | **Modos de Permissao** | **Este doc** | **Medio** |
| **16** | **Configuracao em Camadas** | **Este doc** | **Medio** |

### Fase 4: Autonomia (Semana 7-8)
*Atualizada*

| # | Modulo | Documento | Esforco |
|---|--------|-----------|---------|
| 7 | Task Scheduler | Principal | Alto |
| 8 | Agent Lifecycle | Principal | Medio |
| 9 | DAG Workflows | Principal | Alto |
| **15** | **Self-Critique** | **Este doc** | **Medio** |
| **17** | **Circuit Breaker** | **Este doc** | **Baixo** |

### Fase 5: Otimizacao (Semana 9-10)
**NOVA FASE**

| # | Modulo | Documento | Esforco |
|---|--------|-----------|---------|
| 10 | Event Bus | Principal | Alto |
| **13** | **Reuso Inteligente** | **Este doc** | **Alto** |
| 12 | Observabilidade | Principal | Baixo |

---

## Resumo: 17 Modulos Totais

| # | Modulo | Categoria | Prioridade |
|---|--------|-----------|------------|
| 1 | Task Scheduler | Kernel | Alta |
| 2 | Message Bus + Blackboard | Kernel | Critica |
| 3 | Event Bus | Kernel | Media |
| 4 | Tool Registry | Kernel | Media |
| 5 | Memoria Hierarquica | Core | Critica |
| 6 | Agent Lifecycle | Kernel | Alta |
| 7 | Context Manager | Kernel | Alta |
| 8 | DAG Workflows | Core | Alta |
| 9 | Auto-Calibracao | Core | Media |
| 10 | Observabilidade | Core | Media |
| 11 | Constituicao | **Governanca** | Alta |
| 12 | Context Brackets | **Kernel** | Alta |
| 13 | Reuso Inteligente | **Kernel** | Media |
| 14 | Modos de Permissao | **Governanca** | Media |
| 15 | Self-Critique | **Core** | Alta |
| 16 | Configuracao em Camadas | **Governanca** | Media |
| 17 | Circuit Breaker | **Core** | Baixa |

---

*Documento complementar gerado em 19/02/2026*
*Versao: 1.0*
*Complementa: SLEEP-AGENT-V5-EVOLUCAO.md*
