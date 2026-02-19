# Product-Market Fit (PMF)

Guia para encontrar, medir e manter o Product-Market Fit.

## O que e Product-Market Fit

> "Product-Market Fit significa estar em um bom mercado com um produto capaz de satisfazer esse mercado."
> - Marc Andreessen

```
PMF = Produto que resolve problema real
      para mercado grande o suficiente
      de forma melhor que alternativas
```

## Por que PMF e Importante

### Estatisticas
- 34% das startups falham por nao encontrar PMF
- Empresas pre-PMF nao devem escalar
- PMF determina se vale investir em growth

### Antes vs Depois de PMF
```
PRE-PMF                         POS-PMF
- Foco em discovery             - Foco em growth
- Time pequeno                  - Time crescendo
- Burn rate baixo               - Investir em escala
- Pivotar se necessario         - Otimizar o que funciona
- Experimentar muito            - Executar com excelencia
```

## Sinais de Product-Market Fit

### Sinais Positivos
```
[ ] Usuarios pagam pelo produto
[ ] Retencao estavel ou crescente
[ ] Crescimento organico (word of mouth)
[ ] Usuarios reclamam quando produto falha
[ ] Demanda maior que capacidade de atender
[ ] Usuarios encontram o produto sozinhos
[ ] Alta taxa de referral
[ ] Usuarios usam mesmo com bugs/problemas
```

### Sinais Negativos (Sem PMF)
```
[ ] Precisa convencer muito para vender
[ ] Alta taxa de churn
[ ] Usuarios param de usar apos trial
[ ] Nenhum crescimento organico
[ ] Feedback vago ou indiferente
[ ] Baixo engajamento
[ ] Usuarios pedem features basicas
```

## Como Medir PMF

### 1. Sean Ellis Test (Mais Usado)

**Pergunta:**
> "Como voce se sentiria se nao pudesse mais usar [produto]?"

**Opcoes:**
- Muito desapontado
- Um pouco desapontado
- Nao desapontado (nao e muito util)

**Interpretacao:**
```
% "Muito desapontado"

>40% = Provavelmente tem PMF
25-40% = Quase la, precisa ajustes
<25% = Sem PMF, precisa pivotar
```

**Benchmark:**
- Slack: 51%
- Superhuman: 22% -> 58% (apos trabalhar PMF)

### 2. Retention Curve

```
USUARIOS RETIDOS
100%|*
    | *
    |  *
    |   *  *  *  *  *  *  <- PMF (estabiliza)
    |    \
    |     \
    |      \            <- Sem PMF (continua caindo)
    +--------------------> TEMPO
     D1  D7 D14 D30 D60
```

**PMF Presente:**
- Curva estabiliza em algum ponto
- Grupo de usuarios que permanece

**Sem PMF:**
- Curva continua caindo
- Eventualmente chega a zero

### 3. Net Promoter Score (NPS)

```
Pergunta: "De 0-10, qual a probabilidade de recomendar?"

Promoters (9-10): Entusiastas
Passives (7-8): Satisfeitos mas vulneraveis
Detractors (0-6): Insatisfeitos

NPS = % Promoters - % Detractors

Interpretacao:
>50 = Excelente, provavel PMF
0-50 = Bom, pode melhorar
<0 = Problematico, sem PMF
```

### 4. Cohort Analysis

```
Analisar se cohorts mais recentes retêm melhor
= Produto melhorando = Caminhando para PMF

       Semana 0  Semana 4  Semana 8
Jan       100%      20%       10%
Fev       100%      25%       15%
Mar       100%      35%       25%  <- Melhorando!
Abr       100%      45%       35%  <- PMF emergindo
```

### 5. Metricas Qualitativas

```
[ ] Usuarios descrevem produto para outros facilmente?
[ ] Feedback e especifico e construtivo (vs vago)?
[ ] Usuarios sugerem melhorias (vs reclamar)?
[ ] Tem "power users" que usam intensamente?
[ ] Usuarios comparam com alternativas (sabem o que querem)?
```

## Caminho para PMF

### Framework Lean Startup
```
      IDEIA
        |
        v
    +-------+
    | BUILD |-----> PRODUTO
    +-------+          |
        ^              v
        |         +---------+
        |         | MEASURE |----> DADOS
        |         +---------+
        |              |
        +-- LEARN <----+
               |
               v
        [Pivotar ou Perseverar?]
```

### Fases

**Fase 1: Problem-Solution Fit**
```
Pergunta: O problema que queremos resolver e real e importante?

Atividades:
- Entrevistas de discovery
- Jobs to Be Done analysis
- Validacao do problema (sem produto)

Criterio de Sucesso:
- Usuarios confirmam problema existe
- Problema e frequente/importante
- Usuarios tentam resolver ativamente
```

**Fase 2: Solution-Market Fit**
```
Pergunta: Nossa solucao resolve o problema de forma unica?

Atividades:
- MVP / Prototipo
- Testes com early adopters
- Iteracao rapida

Criterio de Sucesso:
- Usuarios usam o MVP
- Feedback especifico
- Disposicao para pagar
```

**Fase 3: Product-Market Fit**
```
Pergunta: O produto cria valor real para mercado grande?

Atividades:
- Otimizar onboarding
- Melhorar retencao
- Identificar segmento ideal

Criterio de Sucesso:
- Sean Ellis Test >40%
- Retencao estabilizada
- Crescimento organico
```

**Fase 4: Scale**
```
Pergunta: Como crescer mantendo PMF?

Atividades:
- Growth experiments
- Expansao de canais
- Automacao

Criterio de Sucesso:
- Unit economics positivos
- PMF mantido em escala
- Novos segmentos com PMF
```

## ICP (Ideal Customer Profile)

### Por que ICP Importa
```
PMF nao e universal - e especifico para um segmento

Erro comum: Tentar PMF para "todo mundo"
Correto: PMF para ICP especifico primeiro
```

### Template ICP
```markdown
# Ideal Customer Profile

## Demograficos
- Industria: [Ex: SaaS B2B]
- Tamanho: [Ex: 50-200 funcionarios]
- Localizacao: [Ex: Brasil, America Latina]
- Cargo do decisor: [Ex: VP de Produto]

## Psicograficos
- Mentalidade: [Ex: Data-driven, early adopter]
- Valores: [Ex: Eficiencia, inovacao]

## Comportamentais
- Usa atualmente: [Ex: Planilhas, Jira]
- Problema principal: [Ex: Falta de visibilidade]
- Trigger de compra: [Ex: Time crescendo]

## Sinais de Fit
- [Sinal 1: Ex: Usa Slack]
- [Sinal 2: Ex: Time de produto estruturado]
- [Sinal 3: Ex: Orcamento de ferramentas]
```

## Pivots

### Quando Pivotar
```
Considerar pivot se:
- Sean Ellis Test < 25% por 3+ meses
- Retencao nao melhora com iteracoes
- CAC insustentavel
- Mercado muito pequeno
- Concorrencia domina completamente
```

### Tipos de Pivot
```
| Tipo | Mudanca | Exemplo |
|------|---------|---------|
| Customer Segment | Quem | B2C -> B2B |
| Problem | O que resolve | Feature -> Produto |
| Solution | Como resolve | App -> Bot |
| Channel | Como vende | Online -> Field sales |
| Revenue Model | Como cobra | Freemium -> Enterprise |
| Technology | Como constroi | Custom -> Platform |
```

### Framework de Decisao
```
              ALTO
                |
   PERSEVERAR   |   PIVOTAR
   (dados bons, |   (mercado bom,
   continuar)   |   produto errado)
                |
EVIDENCIA ------+------ EVIDENCIA
DE FIT         |        CONTRA FIT
                |
   ITERAR       |   MATAR
   (ajustes     |   (mercado ruim,
   necessarios) |   desistir)
                |
              BAIXO
           TAMANHO DE MERCADO
```

## Mantendo PMF

### PMF nao e Permanente
```
Riscos de perder PMF:
- Mercado muda (tecnologia, regulacao)
- Concorrentes surgem
- Produto estagna
- Expansion para segmentos errados
```

### Monitoramento Continuo
```
Metricas para acompanhar:
[ ] Sean Ellis Test trimestral
[ ] NPS mensal
[ ] Retention curves por cohort
[ ] Churn rate e motivos
[ ] Feedback qualitativo
```

## PMF para Novos Segmentos

### Expansao Cuidadosa
```
1. Confirmar PMF no segmento atual
2. Identificar segmento adjacente
3. Validar problema existe no novo segmento
4. Testar com pequeno grupo
5. Confirmar PMF no novo segmento
6. Escalar se positivo
```

## Referencias

- **The Lean Startup** - Eric Ries
- **The Mom Test** - Rob Fitzpatrick
- **Running Lean** - Ash Maurya
- **Superhuman's PMF Engine** - Rahul Vohra (First Round Review)
- **12 Things About PMF** - Tren Griffin
