# Metricas de Produto

Guia completo de frameworks de metricas para produtos digitais.

## Principios de Boas Metricas

### Caracteristicas
```
[ ] Acionavel - Voce pode agir sobre ela
[ ] Acessivel - Time consegue entender
[ ] Auditavel - Dados sao confiaveis
[ ] Comparavel - Pode ver tendencias
[ ] Relevante - Conectada ao negocio
```

### Input vs Output Metrics
```
INPUT METRICS (Leading)          OUTPUT METRICS (Lagging)
- Causam mudancas               - Resultado de mudancas
- Mais controlaveis             - Menos controlaveis
- Alertam antes                 - Confirmam depois

Ex: Numero de experimentos      Ex: Receita
Ex: Velocidade de carregamento  Ex: Retencao
```

---

## 1. North Star Metric (NSM)

A metrica unica que representa valor entregue ao usuario.

### Conceito
```
North Star Metric = Medida que captura o valor central
                    que seu produto entrega aos usuarios

Criterios:
1. Expressa valor ao usuario (nao so ao negocio)
2. Leading indicator de receita
3. Mensuravel
4. Todos podem influenciar
```

### Framework North Star (Amplitude)
```
                   NORTH STAR METRIC
                          |
    +---------------------+---------------------+
    |                     |                     |
  INPUT 1              INPUT 2              INPUT 3
  [Breadth]            [Depth]             [Frequency]
  Quantos?             Quanto?             Com que frequencia?
```

### Exemplos por Tipo de Produto
```
| Produto | North Star | Inputs |
|---------|------------|--------|
| Spotify | Tempo de streaming | Usuarios ativos, playlists criadas |
| Airbnb | Noites reservadas | Listagens, buscas, bookings |
| Slack | Mensagens enviadas | Times ativos, canais criados |
| Netflix | Horas assistidas | Titulos iniciados, completos |
| Facebook | DAU | Posts, likes, shares |
```

### Como Definir Sua North Star
```
1. Qual o valor central do produto?
   "Usuarios usam [produto] para [resultado]"

2. Qual acao representa esse valor?
   "Quando usuario faz [X], ele recebeu valor"

3. Como medir essa acao?
   "[Metrica] por [periodo]"

4. Quais inputs a influenciam?
   "[Input 1], [Input 2], [Input 3]"
```

---

## 2. AARRR (Pirate Metrics)

Framework de Dave McClure (500 Startups) para funil de crescimento.

### O Funil
```
    ACQUISITION      Como usuarios chegam?
         |
         v
    ACTIVATION       Usuarios tem primeira boa experiencia?
         |
         v
    RETENTION        Usuarios voltam?
         |
         v
    REVENUE          Usuarios pagam?
         |
         v
    REFERRAL         Usuarios indicam?
```

### Metricas por Etapa

**Acquisition (Aquisicao)**
```
Metricas:
- Visitantes unicos
- Custo por aquisicao (CPA)
- Canal de origem
- Taxa de conversao visita->signup

Benchmark SaaS B2B:
- CPA: $50-500
- Visita->Signup: 2-5%
```

**Activation (Ativacao)**
```
Metricas:
- Taxa de completar onboarding
- Time to value (TTV)
- Usuarios que chegam ao "Aha moment"
- Activation rate

Benchmark SaaS:
- Onboarding completion: 30-60%
- TTV: < 7 dias ideal
```

**Retention (Retencao)**
```
Metricas:
- DAU/MAU ratio
- Churn rate (mensal)
- Retention curve
- Net Revenue Retention (NRR)

Benchmark SaaS:
- DAU/MAU: >20% bom, >50% excelente
- Churn: <5% mensal bom
- NRR: >100% excelente
```

**Revenue (Receita)**
```
Metricas:
- MRR/ARR
- ARPU (Average Revenue Per User)
- LTV (Lifetime Value)
- LTV:CAC ratio

Benchmark SaaS:
- LTV:CAC > 3:1
- CAC payback < 12 meses
```

**Referral (Indicacao)**
```
Metricas:
- NPS (Net Promoter Score)
- Viral coefficient (K-factor)
- Referral rate
- % crescimento organico

Benchmark:
- NPS > 50 excelente
- K-factor > 1 = crescimento viral
```

### Template AARRR Dashboard
```
ACQUISITION
| Metrica | Atual | Meta | Trend |
|---------|-------|------|-------|
| Visitors | X | Y | +/-% |
| Signups | X | Y | +/-% |
| Conv Rate | X% | Y% | +/-% |
| CPA | $X | $Y | +/-% |

[Repetir para cada etapa]
```

---

## 3. HEART Framework (Google)

Framework focado em experiencia do usuario.

### Dimensoes
```
HAPPINESS    - Satisfacao, NPS, CSAT
ENGAGEMENT   - Frequencia, intensidade de uso
ADOPTION     - Novos usuarios, features adotadas
RETENTION    - Usuarios que voltam
TASK SUCCESS - Eficiencia, taxa de conclusao
```

### Goals-Signals-Metrics (GSM)
```
Para cada dimensao:

GOAL: O que queremos alcancar?
SIGNAL: Que comportamento indica sucesso?
METRIC: Como medimos esse comportamento?
```

### Exemplo Completo
```
HAPPINESS
- Goal: Usuarios satisfeitos com a experiencia
- Signal: Feedback positivo, recomendacoes
- Metric: NPS > 50, CSAT > 4.5

ENGAGEMENT
- Goal: Usuarios usando ativamente
- Signal: Retorno frequente, uso profundo
- Metric: DAU/MAU > 25%, sessoes/dia > 2

ADOPTION
- Goal: Novos usuarios adotando produto
- Signal: Completam onboarding, usam core features
- Metric: Activation rate > 40%

RETENTION
- Goal: Usuarios continuam usando
- Signal: Voltam apos primeira semana
- Metric: D7 retention > 30%

TASK SUCCESS
- Goal: Usuarios completam tarefas facilmente
- Signal: Conclusao rapida, poucos erros
- Metric: Task completion > 90%, Error rate < 5%
```

---

## 4. Cohort Analysis

Analise de grupos de usuarios ao longo do tempo.

### Retention Cohort
```
         Semana 0  Semana 1  Semana 2  Semana 3
Jan W1      100%      45%       30%       25%
Jan W2      100%      48%       32%       28%
Jan W3      100%      52%       38%       32%
Feb W1      100%      55%       40%       35%

Leitura: Cohorts mais recentes estao retendo melhor
(melhoria no produto ou onboarding)
```

### Revenue Cohort
```
         Mes 0    Mes 1    Mes 2    Mes 3
Jan        $100     $95      $92      $90
Feb        $100     $98      $96      $94
Mar        $100     $102     $105     $108

Leitura: Cohort de Marco expandindo (upsell funcionando)
```

---

## 5. Metricas SaaS Essenciais

### Unit Economics
```
CAC = Custo de Aquisicao de Cliente
      Marketing + Vendas / Novos Clientes

LTV = Lifetime Value
      ARPU x Tempo medio de vida

LTV:CAC Ratio
- < 1:1 = Insustentavel
- 3:1 = Bom
- > 5:1 = Pode investir mais em aquisicao

CAC Payback
- Tempo para recuperar CAC
- < 12 meses = Saudavel
```

### Receita Recorrente
```
MRR = Monthly Recurring Revenue
ARR = Annual Recurring Revenue (MRR x 12)

MRR Components:
- New MRR: Novos clientes
- Expansion MRR: Upgrades
- Churn MRR: Cancelamentos
- Contraction MRR: Downgrades

Net MRR = New + Expansion - Churn - Contraction
```

### Net Revenue Retention (NRR)
```
NRR = (MRR inicio + Expansion - Churn - Contraction) / MRR inicio x 100

- < 100% = Perdendo receita
- 100% = Estavel
- > 100% = Crescendo sem novos clientes
- > 120% = Excelente (best-in-class SaaS)
```

---

## Dashboard de Metricas Recomendado

### Nivel Executivo
```
+------------------+------------------+------------------+
|    NORTH STAR    |       MRR        |    NPS/CSAT     |
|    [Metrica]     |    [Valor]       |    [Score]      |
+------------------+------------------+------------------+
|    LTV:CAC       |    CHURN         |    NRR          |
|    [Ratio]       |    [%]           |    [%]          |
+------------------+------------------+------------------+
```

### Nivel Time de Produto
```
FUNIL AARRR
+-------+-------+-------+-------+-------+
| ACQ   | ACT   | RET   | REV   | REF   |
| [%]   | [%]   | [%]   | [%]   | [%]   |
+-------+-------+-------+-------+-------+

ENGAGEMENT
+-----------+-----------+-----------+
| DAU       | Sessions  | Time      |
| [N]       | [N/user]  | [min]     |
+-----------+-----------+-----------+

RETENTION CURVE
[Grafico de retencao por cohort]
```

---

## Anti-Patterns (O que Evitar)

### Vanity Metrics
```
EVITAR                      PREFERIR
- Total de usuarios         -> Usuarios ativos
- Downloads                 -> Retained users
- Page views                -> Engaged sessions
- Registered users          -> Activated users
- Total revenue             -> Recurring revenue
```

### Gaming Metrics
```
Cuidados:
- Metrica isolada pode ser manipulada
- Sempre ter metricas de contrapeso
- Ex: Se medir velocidade, medir qualidade tambem
```

---

## Referencias

- **North Star Playbook** - Amplitude
- **Lean Analytics** - Alistair Croll
- **AARRR Pirate Metrics** - Dave McClure
- **HEART Framework** - Google
- **SaaS Metrics 2.0** - David Skok
