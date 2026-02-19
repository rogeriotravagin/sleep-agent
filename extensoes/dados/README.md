# Extensao Dados - Data Intelligence

Framework completo de Data Intelligence para decisoes baseadas em dados.

---

## Visao Geral

A extensao Dados transforma informacoes brutas em insights acionaveis, combinando pesquisa profunda, analise de dados internos e inteligencia de mercado.

### Para quem e

- Gestores que precisam tomar decisoes baseadas em dados
- Times de BI e analytics
- Pesquisadores de mercado
- Qualquer profissional que trabalha com dados

### O que entrega

- Pesquisas profundas sobre qualquer tema
- Analises de dados internos
- Dashboards e KPIs estruturados
- Relatorios executivos
- Benchmarks e inteligencia competitiva
- Tendencias de mercado

---

## Agentes Disponiveis

### Cientista de Dados (`/cientista`)

Especialista em pesquisas profundas e analise exploratoria.

**Especialidades:**
- Pesquisa profunda de dados
- Analise exploratoria (EDA)
- Modelagem estatistica
- Data mining e descoberta de padroes
- Validacao de hipoteses

**Quando usar:**
- "Preciso entender por que X esta acontecendo"
- "Quero validar uma hipotese"
- "Preciso de uma pesquisa profunda sobre..."

### Analista de Dados (`/analista`)

Especialista em relatorios, dashboards e comunicacao de dados.

**Especialidades:**
- Construcao de relatorios executivos
- Design de dashboards
- Definicao de KPIs e metricas
- Storytelling com dados
- Analise de dados internos

**Quando usar:**
- "Preciso de um dashboard para acompanhar..."
- "Quero criar um relatorio para a diretoria"
- "Preciso definir metricas para..."

### Pesquisador de Mercado (`/pesquisador`)

Especialista em inteligencia competitiva e tendencias.

**Especialidades:**
- Inteligencia competitiva
- Pesquisa de mercado (TAM/SAM/SOM)
- Analise de tendencias
- Consumer insights
- Benchmarking

**Quando usar:**
- "Quero entender o mercado de..."
- "Preciso analisar os concorrentes"
- "Quais as tendencias do setor?"

---

## Comandos Disponiveis

### Ativar a Extensao

```
/dados
```

### Modos de Trabalho

| Comando | Descricao | Para quem |
|---------|-----------|-----------|
| `/iniciante-dados` | Analise rapida com 5 perguntas | Primeira vez |
| `/pesquisa-completa` | Pesquisa do zero ao relatorio | Pesquisa profunda |
| `/analise-completa` | Analise de dados internos | Dashboard + relatorio |

### Tarefas Rapidas

| Comando | O que faz | Agente |
|---------|-----------|--------|
| `/pesquisar` | Pesquisa profunda sobre um tema | Cientista |
| `/analisar` | Analise de dados internos | Analista |
| `/dashboard` | Estruturar dashboard de metricas | Analista |
| `/relatorio` | Criar relatorio executivo | Analista |
| `/benchmark` | Benchmarking competitivo | Pesquisador |
| `/tendencias` | Analise de tendencias de mercado | Pesquisador |

---

## Exemplos de Uso

### Pesquisa de Mercado

```
Voce: Quero entender o mercado de cursos online no Brasil

Sleep Agent: [Ativa Pesquisador de Mercado]
- Levanta TAM/SAM/SOM
- Mapeia principais players
- Identifica tendencias
- Gera relatorio completo
```

### Dashboard de Vendas

```
Voce: Preciso de um dashboard para acompanhar vendas

Sleep Agent: [Ativa Analista de Dados]
- Define North Star Metric
- Estrutura KPIs
- Planeja visualizacoes
- Documenta especificacao completa
```

### Analise de Churn

```
Voce: Por que estamos perdendo clientes?

Sleep Agent: [Ativa Cientista de Dados]
- Analisa dados de churn
- Identifica padroes
- Valida hipoteses
- Recomenda acoes
```

---

## Base de Conhecimento

A extensao usa os seguintes arquivos de conhecimento:

- `metodologias-pesquisa.md` - CRISP-DM, JTBD, amostragem
- `frameworks-analise.md` - Porter, SWOT, AARRR, RFM
- `storytelling-dados.md` - So What, piramide de Minto, visualizacao

---

## Integracao com Framework Data

A extensao aproveita o framework em `frameworks/data/` com clones especializados:

| Clone | Especialidade |
|-------|---------------|
| Peter Fader | CLV, RFM, Customer Centricity |
| Sean Ellis | AARRR, North Star, PMF |
| Nick Mehta | Health Score, Churn |
| Avinash Kaushik | Attribution, So What |
| David Spinks | Community Metrics |
| Wes Kao | Learning Outcomes |

---

## Estrutura da Extensao

```
extensoes/dados/
├── extensao.yaml              # Configuracao
├── README.md                  # Este arquivo
├── agentes/
│   ├── CIENTISTA-DADOS.md     # Pesquisa e EDA
│   ├── ANALISTA-DADOS.md      # Relatorios e dashboards
│   └── PESQUISADOR-MERCADO.md # Inteligencia competitiva
├── conhecimento/
│   ├── metodologias-pesquisa.md
│   ├── frameworks-analise.md
│   └── storytelling-dados.md
├── tarefas/
│   ├── pesquisa-profunda.yaml
│   ├── analise-dados-internos.yaml
│   ├── criar-dashboard.yaml
│   └── relatorio-executivo.yaml
└── workflows/
    ├── pesquisa-completa.yaml
    └── modo-iniciante-dados.yaml
```

---

## Output

Os resultados sao salvos em:

```
output/[produto]/
├── pesquisas/      # Pesquisas profundas
├── analises/       # Analises de dados
├── dashboards/     # Especificacoes de dashboard
└── relatorios/     # Relatorios executivos
```

---

## Proximos Passos

Apos ativar a extensao com `/dados`, voce pode:

1. Usar `/iniciante-dados` para uma analise rapida
2. Usar comandos especificos como `/pesquisar` ou `/dashboard`
3. Iniciar um workflow completo com `/pesquisa-completa`

---

*Extensao Dados v1.0*
*Sleep Agent - Framework de Agentes para Profissionais*
