# Metricas de Customer Success

## Visao Geral

Metricas de CS sao divididas em:
- **Leading Indicators**: Preditivas, antecipam resultados
- **Lagging Indicators**: Resultado, medem o que aconteceu

---

## Health Score

### O que e Health Score

Sistema de pontuacao que mede a "saude" do relacionamento com cada cliente.

### Componentes Tipicos

| Componente | Peso Sugerido | O que Mede |
|------------|---------------|------------|
| Uso do Produto | 25-35% | Logins, features, frequencia |
| Engajamento | 20-25% | Reunioes, respostas, NPS |
| Suporte | 15-20% | Volume tickets, satisfacao |
| Financeiro | 10-15% | Pagamentos, crescimento |
| Relacionamento | 10-15% | Stakeholders, sponsor |

### Modelo de Calculo

```
Health Score = Σ (Componente × Peso)

Exemplo:
- Uso: 80 × 0.30 = 24
- Engajamento: 70 × 0.25 = 17.5
- Suporte: 90 × 0.20 = 18
- Financeiro: 100 × 0.15 = 15
- Relacionamento: 60 × 0.10 = 6
Total: 80.5 (Amarelo)
```

### Thresholds

| Score | Status | Acao |
|-------|--------|------|
| 80-100 | Verde (Saudavel) | Expansion focus |
| 60-79 | Amarelo (Atencao) | Monitorar, engajar |
| 40-59 | Laranja (Risco) | Intervencao |
| 0-39 | Vermelho (Critico) | Save play urgente |

### Boas Praticas

1. **Comece simples** - 3-5 indicadores
2. **Use dados objetivos** - Evite subjetividade
3. **Calibre regularmente** - Ajuste pesos
4. **Automatize** - Coleta manual nao escala
5. **Acione** - Score sem acao e inutil

---

## Net Promoter Score (NPS)

### O que e NPS

Metrica de lealdade baseada na pergunta:
> "Em uma escala de 0-10, qual a probabilidade de voce recomendar nossa empresa?"

### Calculo

```
NPS = % Promotores - % Detratores

Promotores: 9-10
Neutros: 7-8
Detratores: 0-6
```

### Benchmarks por Industria

| Industria | NPS Medio | Excelente |
|-----------|-----------|-----------|
| SaaS B2B | 30-40 | >50 |
| SaaS B2C | 25-35 | >45 |
| Servicos | 35-45 | >55 |
| E-commerce | 40-50 | >60 |

### Tipos de NPS

| Tipo | Quando | Objetivo |
|------|--------|----------|
| Transactional | Apos interacao | Feedback pontual |
| Relationship | Periodico (trimestral) | Visao geral |
| Post-Onboarding | Fim do onboarding | Avaliar inicio |

### Closed-Loop Feedback

```
1. COLETAR → NPS enviado
2. CLASSIFICAR → Promotor/Neutro/Detrator
3. ANALISAR → Categorizar motivos
4. AGIR → Contatar, resolver
5. FECHAR → Confirmar resolucao
6. APRENDER → Melhorar processo
```

---

## Customer Satisfaction (CSAT)

### O que e CSAT

Mede satisfacao pontual com interacao ou experiencia.

### Pergunta Tipica
> "Quao satisfeito voce esta com [interacao]?"
> Escala: 1-5 ou 1-7

### Calculo

```
CSAT = (Respostas Positivas / Total Respostas) × 100

Positivas = 4-5 (escala 1-5) ou 5-7 (escala 1-7)
```

### Quando Usar

| Situacao | CSAT | NPS |
|----------|------|-----|
| Pos-suporte | ✓ | |
| Pos-treinamento | ✓ | |
| Pos-onboarding | ✓ | ✓ |
| Trimestral | | ✓ |
| Pos-QBR | ✓ | |

---

## Customer Effort Score (CES)

### O que e CES

Mede o esforco necessario para resolver problema ou usar produto.

### Pergunta Tipica
> "Quao facil foi resolver seu problema?"
> Escala: 1-7 (1=muito dificil, 7=muito facil)

### Por que CES Importa

| Metrica | Correlacao com Lealdade |
|---------|------------------------|
| CSAT | Media |
| NPS | Alta |
| CES | Muito Alta |

> "96% dos clientes com alto esforco se tornam disleais" - CEB/Gartner

### Quando Medir

- Pos-ticket de suporte
- Pos-self-service
- Pos-onboarding
- Pos-feature complexa

---

## Churn Rate

### Tipos de Churn

| Tipo | Formula | Mede |
|------|---------|------|
| Customer Churn | Clientes perdidos / Clientes inicio | Volume de clientes |
| Revenue Churn | MRR perdido / MRR inicio | Impacto financeiro |
| Logo Churn | Logos cancelados / Logos inicio | Numero de contas |

### Calculo Churn Rate

```
Churn Rate Mensal = (MRR Churned / MRR Inicio Mes) × 100

Exemplo:
- MRR Inicio: $100,000
- MRR Churned: $3,000
- Churn Rate: 3%
```

### Churn Rate Anualizado

```
Churn Anual = 1 - (1 - Churn Mensal)^12

Exemplo:
- Churn Mensal: 3%
- Churn Anual: 1 - (1 - 0.03)^12 = 30.6%
```

### Benchmarks

| Tipo Negocio | Bom | Excelente |
|--------------|-----|-----------|
| Enterprise SaaS | <5% anual | <3% |
| Mid-Market | <10% anual | <7% |
| SMB | <15% anual | <10% |

---

## Net Revenue Retention (NRR)

### O que e NRR

Mede retencao de receita incluindo expansion e contraction.

### Formula

```
NRR = (MRR Inicio + Expansion - Contraction - Churn) / MRR Inicio × 100

Exemplo:
- MRR Inicio: $100,000
- Expansion: $10,000
- Contraction: $3,000
- Churn: $5,000
- NRR: ($100k + $10k - $3k - $5k) / $100k = 102%
```

### O que NRR Mostra

| NRR | Significado |
|-----|-------------|
| <90% | Problema serio - churn alto |
| 90-100% | Estavel, mas sem crescimento |
| 100-110% | Bom - expansion cobre churn |
| 110-130% | Otimo - crescimento forte |
| >130% | Excepcional (top performers) |

### NRR vs GRR

| Metrica | Inclui | Mostra |
|---------|--------|--------|
| GRR (Gross) | Apenas churn/contraction | Capacidade de reter |
| NRR (Net) | Churn + Expansion | Capacidade de crescer |

---

## Customer Lifetime Value (CLV/LTV)

### Formula Simples

```
LTV = ARPU × Margem Bruta × Vida Media

Exemplo:
- ARPU: $500/mes
- Margem: 80%
- Vida: 36 meses
- LTV: $500 × 0.80 × 36 = $14,400
```

### Formula com Churn

```
LTV = ARPU × Margem / Churn Rate Mensal

Exemplo:
- ARPU: $500
- Margem: 80%
- Churn: 3%
- LTV: $500 × 0.80 / 0.03 = $13,333
```

### Ratio LTV:CAC

| Ratio | Interpretacao |
|-------|---------------|
| <1:1 | Insustentavel |
| 1:1 - 3:1 | Preocupante |
| 3:1 - 5:1 | Saudavel |
| >5:1 | Pode investir mais em aquisicao |

---

## Time to Value (TTV)

### Tipos de TTV

| Metrica | Definicao |
|---------|-----------|
| Time to First Value | Tempo ate primeiro valor percebido |
| Time to Basic Value | Tempo ate uso basico |
| Time to Full Value | Tempo ate ROI completo |

### Benchmarks

| Complexidade | TTV Aceitavel |
|--------------|---------------|
| Self-service | <1 dia |
| SMB | 1-2 semanas |
| Mid-Market | 2-4 semanas |
| Enterprise | 4-12 semanas |

---

## Dashboard de Metricas CS

### Metricas Essenciais

```
┌─────────────────────────────────────────────────┐
│              DASHBOARD CS                        │
├─────────────────────────────────────────────────┤
│                                                  │
│  NRR: 108%     │  Churn: 2.5%    │  NPS: 52     │
│  ▲ +3%         │  ▼ -0.5%        │  ▲ +5        │
│                                                  │
├─────────────────────────────────────────────────┤
│                                                  │
│  Health Score Distribution:                      │
│  Verde: 65%  │  Amarelo: 25%  │  Vermelho: 10%  │
│                                                  │
├─────────────────────────────────────────────────┤
│                                                  │
│  TTV Medio: 12 dias    │  Onboarding NPS: 48    │
│                                                  │
└─────────────────────────────────────────────────┘
```

---

## Referencias

### Benchmarks
- OpenView Partners - SaaS Benchmarks
- Gainsight Benchmarks Report
- SaaStr Database

### Ferramentas
- Gainsight (Health Score)
- Delighted (NPS)
- ChurnZero (Churn)
- ProfitWell (Revenue)

---

*Base de Conhecimento - Extensao Customer Success*
