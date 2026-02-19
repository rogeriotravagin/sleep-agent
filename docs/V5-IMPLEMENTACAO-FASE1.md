# V5 Fase 1 - Guia de Implementacao Pratica

## Prioridade: Blackboard + Memoria Hierarquica + Message Bus

Esta fase resolve o problema numero 1 do Sleep Agent: **perda de contexto entre agentes**.

---

## 1. Blackboard (Estado Compartilhado)

### O que criar

**Arquivo:** `workspace/.state/blackboard.yaml`

Este arquivo e o "quadro branco" que todos os agentes podem ler e escrever. Quando o Estrategista define o ICP, o Copywriter le automaticamente sem precisar perguntar de novo.

### Protocolo de Uso

Toda vez que um agente produz informacao reutilizavel:
1. **Escrever no blackboard** a informacao com timestamp e autor
2. **Ler o blackboard** antes de iniciar qualquer tarefa
3. **Nunca sobrescrever** sem versionar (manter historico)

### Categorias do Blackboard

```yaml
# workspace/.state/blackboard.yaml
versao: 1
sessao_id: "auto-gerado"
ultima_atualizacao: "ISO8601"

# Dados que QUALQUER agente pode precisar
marca:
  # Preenchido por: designer, brand-strategist
  nome: null
  tom_voz: null
  cores: { primaria: null, accent: null, fundo: null }
  fontes: { titulo: null, corpo: null }
  atualizado_por: null
  atualizado_em: null

publico:
  # Preenchido por: estrategista
  icp_resumo: null
  dor_principal: null
  desejo_principal: null
  linguagem_preferida: null  # formal, informal, tecnica
  atualizado_por: null
  atualizado_em: null

oferta:
  # Preenchido por: estrategista
  produto_nome: null
  preco: null
  garantia: null
  bonus: []
  mecanismo_unico: null
  atualizado_por: null
  atualizado_em: null

entregas:
  # Lista de outputs produzidos na sessao
  # Cada agente adiciona suas entregas aqui
  []
```

### Regras do Blackboard

1. **Leitura e livre** - Qualquer agente pode ler qualquer campo
2. **Escrita e por dono** - Cada categoria tem agentes autorizados
3. **Sempre com timestamp** - Toda escrita registra quando e quem
4. **Nunca deletar** - Campos podem ser atualizados, nunca removidos
5. **Sessao-scoped** - Blackboard e reiniciado a cada nova sessao (dados importantes vao para memoria)

### Integracao no Orquestrador

Adicionar ao processo de decisao (ORQUESTRADOR.md):

**Passo 0.5 (NOVO): Carregar Blackboard**
```
Antes de delegar qualquer tarefa:
1. Ler workspace/.state/blackboard.yaml
2. Incluir dados relevantes no contexto do agente
3. Instruir agente a atualizar blackboard ao concluir
```

---

## 2. Memoria Hierarquica

### Reestruturar de:

```
workspace/.memoria/
├── insights.yaml
├── decisoes.yaml
├── padroes.yaml
└── alertas.yaml
```

### Para:

```
workspace/.memoria/
├── trabalho.yaml          # NOVO: Sessao atual (volátil)
├── episodica/             # NOVO: Ultimas semanas
│   ├── 2026-02-19.yaml
│   ├── 2026-02-18.yaml
│   └── ...
├── semantica/             # NOVO: Permanente
│   ├── marca.yaml         # Tudo sobre a marca
│   ├── publico.yaml       # Tudo sobre o publico
│   ├── processo.yaml      # Como o usuario gosta de trabalhar
│   ├── tecnico.yaml       # Padroes tecnicos
│   └── alertas.yaml       # Armadilhas permanentes
└── _legado/               # Migracao dos arquivos v4
    ├── insights.yaml
    ├── decisoes.yaml
    ├── padroes.yaml
    └── alertas.yaml
```

### Regras de Migracao v4 → v5

```yaml
migracao:
  insights.yaml:
    destino: "episodica/ (se recente) ou semantica/ (se padrao)"
    criterio: "Se insight tem mais de 30 dias e foi acessado 3+ vezes → semantica"

  decisoes.yaml:
    destino: "semantica/{categoria}.yaml"
    criterio: "Decisoes sao sempre permanentes"

  padroes.yaml:
    destino: "semantica/{categoria}.yaml"
    criterio: "Padroes sao sempre permanentes"

  alertas.yaml:
    destino: "semantica/alertas.yaml"
    criterio: "Alertas sao sempre permanentes"
```

### Fluxo de Memoria por Sessao

```
Inicio da sessao:
  1. Criar workspace/.memoria/trabalho.yaml (vazio)
  2. Carregar semantica relevante para a tarefa

Durante a sessao:
  3. Tudo que acontece vai para trabalho.yaml
  4. Consultas frequentes a semantica (busca por categoria)

Fim da sessao:
  5. trabalho.yaml → filtrar itens importantes
  6. Itens importantes → episodica/{data}.yaml
  7. Limpar trabalho.yaml

Manutencao periodica (health-check):
  8. Escanear episodica/ para itens com 30+ dias
  9. Se acessado 3+ vezes → promover para semantica
  10. Se nunca acessado → arquivar/remover
```

---

## 3. Message Bus (Handoff Estruturado)

### O que criar

**Arquivo:** `kernel/memory-bus/handoff-template.yaml`

Padrao para quando um agente precisa passar trabalho para outro.

### Formato de Handoff

```yaml
# Template de handoff entre agentes
handoff:
  de: "{agente_origem}"
  para: "{agente_destino}"
  timestamp: "ISO8601"

  contexto:
    tarefa_original: "O que foi pedido"
    o_que_ja_fiz: "Resumo do trabalho feito"
    decisoes_tomadas:
      - "Decisao 1: motivo"
      - "Decisao 2: motivo"

  entrega:
    arquivos: []
    dados:
      # Dados estruturados que o proximo agente precisa
      {}

  instrucoes:
    o_que_fazer: "O que o proximo agente deve fazer"
    restricoes: "O que NAO fazer"
    prioridade: "normal"

  blackboard_atualizado: true  # Confirma que atualizou o blackboard
```

### Exemplo Real

```yaml
handoff:
  de: "estrategista"
  para: "copywriter"
  timestamp: "2026-02-19T10:30:00"

  contexto:
    tarefa_original: "Criar campanha de lancamento do Curso Master X"
    o_que_ja_fiz: "Pesquisa de mercado, definicao de ICP, estruturacao de oferta"
    decisoes_tomadas:
      - "ICP: empresarios 30-50 anos, faturamento 50-500k. Motivo: maior volume no nicho."
      - "Preco R$1.997. Motivo: posicionamento premium mas acessivel."
      - "Garantia 30 dias. Motivo: padrao do mercado, reduz objecao."

  entrega:
    arquivos:
      - "workspace/empresa/marketing/pesquisa/pesquisa-curso-x.md"
      - "workspace/empresa/marketing/icp/icp-curso-x.md"
      - "workspace/empresa/marketing/oferta/oferta-curso-x.md"
    dados:
      icp_resumo: "Empresarios 30-50, 50-500k/mes, querem escalar sem perder qualidade"
      dor_principal: "Trabalham demais e nao conseguem delegar"
      mecanismo: "Metodo de Delegacao Inteligente em 5 Passos"
      tom: "Direto, conversacional, sem jargoes. Tratar como igual."

  instrucoes:
    o_que_fazer: "Criar headline, subheadline e 5 bullets para landing page"
    restricoes: "Nao usar promessas de resultado garantido. Nao usar 'lucro facil' ou 'sem esforco'."
    prioridade: "alta"

  blackboard_atualizado: true
```

### Integracao no Orquestrador

Atualizar processo de transicao entre agentes (ORQUESTRADOR.md):

**Antes (v4):**
```
Ao mudar de agente:
1. Informar mudanca
2. Manter contexto (narrativo)
3. Conectar entregas
```

**Depois (v5):**
```
Ao mudar de agente:
1. Agente atual preenche handoff estruturado
2. Agente atual atualiza blackboard
3. Orquestrador carrega handoff + blackboard para novo agente
4. Novo agente inicia com contexto completo e estruturado
```

---

## Checklist de Implementacao

### Semana 1: Blackboard
- [ ] Criar `workspace/.state/` (diretorio)
- [ ] Criar template `blackboard.yaml`
- [ ] Atualizar `ORQUESTRADOR.md` com Passo 0.5
- [ ] Atualizar `HEALTH-CHECK.md` para verificar `.state/`
- [ ] Testar: criar headline com blackboard preenchido vs vazio

### Semana 2: Memoria Hierarquica
- [ ] Criar estrutura `workspace/.memoria/` nova
- [ ] Criar script de migracao v4 → v5
- [ ] Atualizar `MEMORIA.md` com 3 camadas
- [ ] Atualizar health-check para nova estrutura
- [ ] Testar: sessao completa com 3 camadas

### Semana 2: Message Bus
- [ ] Criar `kernel/memory-bus/` (diretorio)
- [ ] Criar `handoff-template.yaml`
- [ ] Atualizar transicoes no orquestrador
- [ ] Testar: handoff estrategista → copywriter

---

## Resultado Esperado

Apos Fase 1, o Sleep Agent deve conseguir:

1. **Workflow sem perguntas repetidas:** Estrategista define ICP, Copywriter usa automaticamente
2. **Handoffs estruturados:** Contexto nunca se perde na transicao
3. **Memoria que evolui:** Itens importantes persistem, lixo e descartado
4. **Sessoes inteligentes:** Retoma de onde parou com contexto correto
