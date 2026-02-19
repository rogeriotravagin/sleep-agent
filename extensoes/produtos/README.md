# Extensao Produtos - Sleep Agent

Framework completo para **Gestao de Produtos** baseado nas melhores praticas do mercado.

## Visao Geral

Esta extensao transforma profissionais nao-tecnicos em gestores de produto eficientes, usando metodologias consagradas de empresas como Google, Amazon, Netflix e Spotify.

### Frameworks Incorporados

| Framework | Autor/Fonte | Aplicacao |
|-----------|-------------|-----------|
| Product Operating Model | Marty Cagan (SVPG) | Estrutura de times e cultura |
| Continuous Discovery | Teresa Torres | Processo de descoberta |
| RICE Prioritization | Intercom | Priorizacao de backlog |
| Kano Model | Noriaki Kano | Categorizacao de features |
| Jobs to Be Done | Clayton Christensen | Entendimento de usuarios |
| OKRs | Intel/Google | Alinhamento estrategico |
| North Star Metric | Amplitude | Metrica principal |
| AARRR Pirate Metrics | Dave McClure | Funil de crescimento |
| Dual-Track Agile | Jeff Patton | Discovery + Delivery |

## Comandos Rapidos

```bash
# Carregar extensao
/produtos

# Modos de trabalho
/iniciante-produtos     # Estruturar produto rapidamente
/produto-completo       # Processo completo (7 fases)
/discovery-sprint       # Sprint de discovery

# Tarefas de estrategia
/definir-visao          # Visao e missao
/criar-okrs             # OKRs de produto
/validar-pmf            # Product-Market Fit

# Tarefas de discovery
/mapear-oportunidades   # Opportunity Solution Tree
/planejar-entrevistas   # Entrevistas de discovery
/analisar-jobs          # Jobs to Be Done

# Tarefas de delivery
/priorizar-backlog      # RICE ou Kano
/criar-roadmap          # Roadmap outcome-driven
/definir-metricas       # North Star e AARRR
```

## Agentes Especializados

### Product Strategist (`/estrategista`)
Especialista em estrategia de produto, OKRs e Product-Market Fit.
- Define visao, missao e estrategia
- Cria OKRs alinhados
- Valida PMF
- Aplica Product Operating Model

### Discovery Lead (`/discovery`)
Especialista em Continuous Discovery e validacao.
- Aplica framework Teresa Torres
- Cria Opportunity Solution Trees
- Conduz entrevistas story-based
- Analisa Jobs to Be Done

### Delivery Manager (`/delivery`)
Especialista em priorizacao, roadmap e metricas.
- Prioriza com RICE, Kano, MoSCoW
- Cria roadmaps outcome-driven
- Define North Star e metricas
- Gerencia backlog e delivery

## Modo Iniciante

O caminho mais rapido para estruturar seu produto:

```bash
/iniciante-produtos
```

1. Responda 5 perguntas simples
2. Sistema processa automaticamente
3. Ralph gera estrutura completa

### O que voce recebe:
- Estrategia documentada
- OKRs iniciais
- Opportunity Solution Tree
- Backlog priorizado
- Metricas recomendadas
- Roadmap de 90 dias

## Base de Conhecimento

| Arquivo | Conteudo |
|---------|----------|
| `product-operating-model.md` | Framework SVPG completo |
| `continuous-discovery.md` | Metodo Teresa Torres |
| `prioritization-frameworks.md` | RICE, Kano, MoSCoW, JTBD |
| `product-metrics.md` | North Star, AARRR, HEART |
| `okrs-produto.md` | OKRs aplicados a produto |
| `product-market-fit.md` | Validacao de PMF |
| `dual-track-agile.md` | Discovery + Delivery |
| `roadmap-estrategico.md` | Roadmaps baseados em outcomes |

## Referencias Principais

### Livros Essenciais
- **Inspired** - Marty Cagan
- **Empowered** - Marty Cagan
- **Transformed** - Marty Cagan
- **Continuous Discovery Habits** - Teresa Torres
- **The Lean Startup** - Eric Ries

### Sites de Referencia
- [SVPG](https://www.svpg.com) - Silicon Valley Product Group
- [Product Talk](https://www.producttalk.org) - Teresa Torres
- [Product School](https://productschool.com) - Recursos e cursos

## Estrutura de Output

```
output/[produto]/produtos/
  estrategias/    # Documentos de estrategia
  okrs/           # OKRs definidos
  roadmaps/       # Roadmaps criados
  discovery/      # Artefatos de discovery
  metricas/       # Dashboards de metricas
  priorizacoes/   # Analises de priorizacao
```

## Integracoes

- **Marketing**: Go-to-Market, posicionamento
- **Customer Success**: Retencao, feedback, health score

---

**Versao:** 1.0
**Status:** Ativo
**Comando:** `/produtos`
