# Frameworks de Analise - Base de Conhecimento

## Frameworks Estrategicos

### 5 Forcas de Porter

Analise da atratividade e dinamica competitiva de um mercado.

```
                    [Novos Entrantes]
                          |
                          v
[Poder Fornecedores] --> [RIVALIDADE] <-- [Poder Compradores]
                          ^
                          |
                    [Substitutos]
```

| Forca | Perguntas Chave |
|-------|-----------------|
| **Rivalidade** | Quantos concorrentes? Qual a intensidade? Diferenciacao? |
| **Novos Entrantes** | Barreiras de entrada? Capital necessario? Regulacao? |
| **Substitutos** | Produtos alternativos? Custo de troca? |
| **Poder do Fornecedor** | Concentracao? Dependencia? Integracao? |
| **Poder do Comprador** | Concentracao? Informacao? Sensibilidade a preco? |

### SWOT

Analise interna e externa da organizacao.

```
          | Positivo        | Negativo
----------|-----------------|------------------
Interno   | FORCAS          | FRAQUEZAS
Externo   | OPORTUNIDADES   | AMEACAS
```

**TOWS Matrix (acoes estrategicas):**
- SO: Usar forcas para aproveitar oportunidades
- WO: Superar fraquezas para aproveitar oportunidades
- ST: Usar forcas para mitigar ameacas
- WT: Minimizar fraquezas para evitar ameacas

### PESTEL

Analise de macroambiente.

| Fator | Exemplos |
|-------|----------|
| **P**olitico | Regulacao, estabilidade, politicas fiscais |
| **E**conomico | PIB, inflacao, taxa de juros, cambio |
| **S**ocial | Demografia, cultura, comportamento |
| **T**ecnologico | Inovacao, automacao, digitalizacao |
| **E**cologico | Sustentabilidade, regulacao ambiental |
| **L**egal | Leis trabalhistas, protecao dados, contratos |

---

## Frameworks de Mercado

### TAM SAM SOM

Dimensionamento de mercado em tres niveis.

```
+---------------------------+
|           TAM             |  Total Addressable Market
|    +------------------+   |  (Mercado total)
|    |       SAM        |   |  Serviceable Addressable Market
|    |   +---------+    |   |  (Mercado que podemos alcancar)
|    |   |   SOM   |    |   |  Serviceable Obtainable Market
|    |   +---------+    |   |  (Mercado que vamos capturar)
|    +------------------+   |
+---------------------------+
```

**Calculos:**
- **TAM:** Receita total se tivessemos 100% do mercado
- **SAM:** TAM x % que podemos servir (geografia, segmento)
- **SOM:** SAM x market share realista (1-5 anos)

### BCG Matrix

Portfolio de produtos por participacao e crescimento.

```
              Market Share
         Alto            Baixo
       +--------+--------+
Alto   | STAR   | ?      |  <- Investir
Growth |        | QUESTION|
       +--------+--------+
Baixo  | CASH   | DOG    |  <- Colher/Desinvestir
       | COW    |        |
       +--------+--------+
```

### Matriz de Ansoff

Estrategias de crescimento.

```
              Produtos
         Existentes    Novos
       +-----------+-----------+
Exist. | Penetracao| Desenvolv.|
Mercado| de Mercado| Produtos  |
       +-----------+-----------+
Novos  | Desenvolv.| Diversi-  |
       | Mercados  | ficacao   |
       +-----------+-----------+
```

---

## Frameworks de Analytics

### AARRR (Pirate Metrics)

Funil de metricas para startups.

| Estagio | Pergunta | Metricas Tipicas |
|---------|----------|------------------|
| **A**cquisition | Como descobrem? | Visitantes, CAC, fontes |
| **A**ctivation | Primeira boa experiencia? | Sign-ups, onboarding completion |
| **R**etention | Voltam? | DAU/MAU, retention rate, cohort |
| **R**eferral | Indicam? | NPS, K-factor, referrals |
| **R**evenue | Pagam? | ARPU, LTV, conversao |

### HEART Framework (Google)

Metricas de experiencia do usuario.

| Dimensao | Descricao | Exemplo |
|----------|-----------|---------|
| **H**appiness | Satisfacao | NPS, CSAT, pesquisa |
| **E**ngagement | Nivel de uso | Sessoes, tempo, profundidade |
| **A**doption | Novos usuarios | Sign-ups, feature adoption |
| **R**etention | Usuarios que voltam | Churn, retention |
| **T**ask Success | Eficiencia | Completion rate, erros |

### North Star Metric

Uma metrica que captura o valor central entregue ao cliente.

**Caracteristicas:**
- Conectada a receita de longo prazo
- Reflete valor entregue ao cliente
- Acionavel pelas equipes
- Mensuravel com frequencia

**Exemplos:**
| Empresa | North Star |
|---------|------------|
| Spotify | Tempo de escuta |
| Airbnb | Noites reservadas |
| Slack | Mensagens enviadas |
| Facebook | Daily Active Users |

### So What Framework (Kaushik)

Todo dado deve responder:

```
1. SO WHAT?     -> Por que esse numero importa?
2. WHAT CHANGED? -> Comparar com baseline (antes, meta, mercado)
3. WHY?         -> Causa raiz da mudanca
4. NOW WHAT?    -> Acao clara a ser tomada
```

---

## Frameworks de Segmentacao

### RFM (Recency, Frequency, Monetary)

Segmentacao de clientes por comportamento de compra.

| Dimensao | Pergunta | Score |
|----------|----------|-------|
| **R**ecency | Quando foi a ultima compra? | 1-5 (5 = recente) |
| **F**requency | Quantas vezes comprou? | 1-5 (5 = frequente) |
| **M**onetary | Quanto gastou no total? | 1-5 (5 = alto valor) |

**Segmentos tipicos:**
- Champions (555): Melhores clientes
- Loyal Customers (X5X): Compradores frequentes
- At Risk (2XX): Compravam, mas pararam
- Lost (111): Inativos ha muito tempo

### Customer Lifetime Value (CLV)

Valor total esperado de um cliente ao longo do relacionamento.

**Formula simplificada:**
```
CLV = (Ticket Medio) x (Frequencia de Compra) x (Tempo de Retencao)
```

**Uso:**
- Definir quanto investir em aquisicao (CAC)
- Priorizar segmentos de maior valor
- Avaliar ROI de iniciativas de retencao

### Cohort Analysis

Agrupar usuarios por caracteristica comum (geralmente data de aquisicao) e acompanhar comportamento ao longo do tempo.

```
Cohort  | M0   | M1   | M2   | M3   | M4   | M5
--------|------|------|------|------|------|------
Jan     | 100% | 40%  | 30%  | 25%  | 22%  | 20%
Fev     | 100% | 42%  | 32%  | 27%  | 24%  |
Mar     | 100% | 38%  | 28%  | 24%  |      |
```

**Insights:**
- Identificar melhoria/piora de retencao
- Comparar impacto de mudancas
- Projetar LTV por cohort

---

## Frameworks de Visualizacao

### Hierarquia de Informacao

Organize dashboards do geral para o especifico:

```
Nivel 1: Executive Summary (1 tela)
    |
    v
Nivel 2: KPIs por Area (2-3 telas)
    |
    v
Nivel 3: Detalhamento (drill-down)
```

### Escolha de Grafico

| Objetivo | Grafico |
|----------|---------|
| Comparar categorias | Barras |
| Mostrar tendencia | Linha |
| Mostrar partes de um todo | Pizza (max 5 partes) |
| Mostrar distribuicao | Histograma |
| Mostrar correlacao | Scatter plot |
| Mostrar fluxo | Sankey |
| Mostrar composicao ao longo do tempo | Area empilhada |

### Principios de Data Viz (Tufte)

1. **Maximize data-ink ratio:** Remover elementos desnecessarios
2. **Evitar chartjunk:** Nada de efeitos 3D ou decoracoes
3. **Integridade grafica:** Escala proporcional aos dados
4. **Pequenos multiplos:** Repetir graficos pequenos para comparar
5. **Layering:** Usar cores e tamanhos com proposito

---

## Frameworks de Decisao

### ICE (Impact, Confidence, Ease)

Priorizacao de iniciativas.

| Criterio | Pergunta | Score (1-10) |
|----------|----------|--------------|
| **I**mpact | Qual o potencial de impacto? | |
| **C**onfidence | Quao confiante estamos? | |
| **E**ase | Quao facil de implementar? | |

**ICE Score = (I x C x E) / 3**

### RICE (Reach, Impact, Confidence, Effort)

Variacao do ICE com foco em alcance.

| Criterio | Descricao |
|----------|-----------|
| **R**each | Quantos usuarios afetados? (numero) |
| **I**mpact | Quanto impacto por usuario? (0.25 a 3) |
| **C**onfidence | Nivel de certeza? (%) |
| **E**ffort | Esforco em pessoa-mes |

**RICE Score = (R x I x C) / E**

### Decision Matrix

Comparar opcoes em multiplos criterios.

```
Criterio   | Peso | Opcao A | Opcao B | Opcao C
-----------|------|---------|---------|--------
Custo      | 30%  | 8 (2.4) | 6 (1.8) | 4 (1.2)
Velocidade | 25%  | 6 (1.5) | 8 (2.0) | 9 (2.25)
Qualidade  | 25%  | 9 (2.25)| 7 (1.75)| 5 (1.25)
Risco      | 20%  | 7 (1.4) | 5 (1.0) | 3 (0.6)
-----------|------|---------|---------|--------
TOTAL      | 100% | 7.55    | 6.55    | 5.30
```
