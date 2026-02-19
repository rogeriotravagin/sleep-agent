# Roadmap Estrategico

Guia para criar roadmaps orientados a resultados (outcome-driven).

## O que e um Roadmap

```
Roadmap = Comunicacao visual de direcao estrategica do produto

NAO e:
- Lista de features com datas
- Compromisso de entrega
- Contrato com stakeholders

E:
- Comunicacao de intencao
- Alinhamento de prioridades
- Conexao estrategia-execucao
```

## Tipos de Roadmap

### 1. Feature Roadmap (Tradicional - Evitar)
```
Q1          Q2          Q3          Q4
+----------+----------+----------+----------+
| Feature A| Feature C| Feature E| Feature G|
| Feature B| Feature D| Feature F| Feature H|
+----------+----------+----------+----------+

Problemas:
- Foco em output, nao outcome
- Gera expectativa de entrega
- Dificil adaptar a mudancas
- Nao explica o "por que"
```

### 2. Outcome Roadmap (Recomendado)
```
Q1                  Q2                  Q3
+------------------+------------------+------------------+
| OUTCOME:         | OUTCOME:         | OUTCOME:         |
| Aumentar         | Reduzir          | Expandir para    |
| ativacao 20%     | churn 15%        | novo mercado     |
|                  |                  |                  |
| Iniciativas:     | Iniciativas:     | Iniciativas:     |
| - Novo onboarding| - Health scoring | - i18n           |
| - Welcome emails | - Alertas        | - Compliance     |
+------------------+------------------+------------------+

Beneficios:
- Foco em resultados
- Flexibilidade nas solucoes
- Explica o "por que"
- Alinha times autonomos
```

### 3. Now/Next/Later (Mais Flexivel)
```
+------------------+------------------+------------------+
|       NOW        |       NEXT       |      LATER       |
|   (Este sprint)  |  (Proximo tri)   |    (Futuro)      |
+------------------+------------------+------------------+
| Alta confianca   | Media confianca  | Baixa confianca  |
| Detalhado        | Explorado        | Conceitual       |
| Comprometido     | Planejado        | Possibilidade    |
+------------------+------------------+------------------+

Vantagens:
- Evita datas especificas
- Mostra nivel de certeza
- Facil de atualizar
```

### 4. Theme-Based Roadmap
```
TEMA: ENGAJAMENTO    TEMA: CRESCIMENTO    TEMA: MONETIZACAO
+------------------+ +------------------+ +------------------+
| Q1: Gamification | | Q1: Referral     | | Q1: Premium tier |
| Q2: Social       | | Q2: Viral loops  | | Q2: Usage-based  |
| Q3: Community    | | Q3: Partnerships | | Q3: Enterprise   |
+------------------+ +------------------+ +------------------+

Vantagens:
- Agrupa por objetivo estrategico
- Permite trabalho paralelo
- Comunica temas, nao features
```

## Niveis de Roadmap

### Nivel Estrategico (Leadership)
```
Horizonte: 1-3 anos
Granularidade: Temas/Bets estrategicas
Audiencia: Executives, Board, Investors

Exemplo:
2024: Dominar mercado Brasil
2025: Expandir para LATAM
2026: Atingir IPO-ready metrics
```

### Nivel Tatico (Product Leadership)
```
Horizonte: 2-4 trimestres
Granularidade: Outcomes/Iniciativas
Audiencia: Product managers, stakeholders

Exemplo:
Q1: Aumentar retencao 20%
Q2: Lancar tier enterprise
Q3: Reduzir CAC em 30%
```

### Nivel Operacional (Squads)
```
Horizonte: 1-2 sprints
Granularidade: User stories/Tasks
Audiencia: Time de desenvolvimento

Exemplo:
Sprint 1: Implementar health score
Sprint 2: Dashboard de alertas
Sprint 3: Automacao de outreach
```

## Construindo o Roadmap

### Passo 1: Conectar a Estrategia
```
Product Vision (10 anos)
        |
        v
Product Strategy (2-3 anos)
        |
        v
OKRs (Trimestral)
        |
        v
Roadmap (Outcome-driven)
        |
        v
Backlog (User Stories)
```

### Passo 2: Identificar Outcomes
```
Para cada OKR, pergunte:
- Qual comportamento do usuario queremos mudar?
- Qual metrica vai mover?
- Como saberemos que tivemos sucesso?

Exemplo:
OKR: Aumentar receita recorrente
Outcome: Melhorar conversao de trial para pago de 8% para 15%
```

### Passo 3: Mapear Iniciativas
```
Para cada Outcome:
- Quais oportunidades identificamos no discovery?
- Quais solucoes foram validadas?
- Quais hipoteses queremos testar?

Exemplo:
Outcome: Aumentar conversao trial->pago
Iniciativas:
- Novo onboarding guiado
- Email sequence de ativacao
- Trial extendido para power users
- Desconto first-time buyer
```

### Passo 4: Priorizar
```
Usar frameworks (RICE, Value/Effort)
Considerar:
- Impacto no outcome
- Confianca na solucao
- Esforco necessario
- Dependencias
- Timing de mercado
```

### Passo 5: Comunicar
```
Formatos por audiencia:

Board/Investors: 1-slider com bets estrategicas
Leadership: Quarterly view com outcomes
Product Team: Now/Next/Later com iniciativas
Engineering: Sprint backlog com stories
```

## Template de Roadmap

### Outcome-Based Roadmap
```markdown
# Product Roadmap [Ano]

## Contexto Estrategico
[Resumo da estrategia e OKRs do ano]

## North Star Metric
[Metrica principal que guia todas as decisoes]

---

## Q1: [Tema]

### Outcome Principal
[O que queremos alcancar - metrica]

### Por que agora?
[Justificativa estrategica]

### Iniciativas Planejadas
| Iniciativa | Confianca | Impacto | Squad |
|------------|-----------|---------|-------|
| [Nome] | Alta/Media/Baixa | [Estimativa] | [Time] |

### Riscos e Dependencias
- [Risco/Dependencia 1]

---

## Q2: [Tema]
[Mesmo formato]

---

## Backlog Estrategico
[Itens considerados para trimestres futuros]

---

## Changelog
| Data | Mudanca | Motivo |
|------|---------|--------|
| [Data] | [O que mudou] | [Por que] |
```

### Now/Next/Later Template
```markdown
# Roadmap - [Produto]
*Atualizado: [Data]*

## NOW (Committed)
*Este trimestre - Alta confianca*

### [Outcome 1]
- **Metrica:** [Atual -> Meta]
- **Iniciativas:**
  - [Iniciativa A] - Em progresso
  - [Iniciativa B] - Planejada

### [Outcome 2]
[...]

---

## NEXT (Planned)
*Proximo trimestre - Media confianca*

### [Outcome 3]
- **Hipotese:** [O que acreditamos]
- **A explorar:**
  - [Direcao A]
  - [Direcao B]

---

## LATER (Possible)
*Futuro - Baixa confianca*

### Temas em Consideracao
- [Tema 1]: [Breve descricao]
- [Tema 2]: [Breve descricao]

### Ideias no Radar
- [Ideia coletada de feedback]
- [Oportunidade de mercado]

---

## NOT Doing (Parked)
*Decidimos nao priorizar agora*

- [Item]: [Motivo]
```

## Comunicacao do Roadmap

### Principios
```
1. Transparencia com responsabilidade
   - Compartilhar direcao
   - Nao prometer datas

2. Atualizar regularmente
   - Minimo trimestral
   - Comunicar mudancas

3. Explicar o "por que"
   - Conectar a estrategia
   - Mostrar trade-offs

4. Deixar espaco para o imprevisto
   - Buffer para discovery
   - Capacidade para urgencias
```

### Stakeholder Communication
```
| Audiencia | Frequencia | Formato | Foco |
|-----------|------------|---------|------|
| Board | Trimestral | Slides | Bets estrategicas |
| Executives | Mensal | Review meeting | Outcomes e metricas |
| Sales/CS | Bi-semanal | Newsletter | O que esta vindo |
| Customers | Quando relevante | Blog/Changelog | Value delivery |
```

### Lidando com Pedidos
```
Quando stakeholder pede feature especifica:

1. ENTENDER o problema por tras
   "O que voce esta tentando resolver?"

2. REGISTRAR no backlog de discovery
   "Vou investigar isso com o time"

3. EXPLICAR o processo
   "Vamos validar e priorizar"

4. ATUALIZAR quando houver decisao
   "Decidimos [fazer/nao fazer] porque..."
```

## Anti-Patterns

### 1. Roadmap como Contrato
```
ERRADO:
"Prometemos feature X em Maio"

CERTO:
"Estamos focando em [outcome], explorando [iniciativas]"
```

### 2. Muito Detalhe no Futuro
```
ERRADO:
Especificar features para daqui 12 meses

CERTO:
Quanto mais longe, mais alto nivel
```

### 3. Nao Atualizar
```
ERRADO:
Roadmap de Janeiro ainda valido em Setembro

CERTO:
Revisao e comunicacao trimestral
```

### 4. Feature Factory Disfarçada
```
ERRADO:
"Outcome: Lancar features A, B, C"

CERTO:
"Outcome: Aumentar retencao 20% atraves de [hipoteses]"
```

## Metricas do Roadmap

### Tracking de Outcomes
```
| Outcome | Baseline | Target | Atual | Status |
|---------|----------|--------|-------|--------|
| Ativacao | 40% | 60% | 52% | On track |
| Retencao | 70% | 80% | 68% | At risk |
| NPS | 30 | 50 | 45 | On track |
```

### Health do Roadmap
```
[ ] % de iniciativas conectadas a outcomes
[ ] % de outcomes com metricas claras
[ ] Frequencia de atualizacao
[ ] Alinhamento entre times
[ ] Satisfacao de stakeholders
```

## Referencias

- **Escaping the Build Trap** - Melissa Perri
- **Product Roadmaps Relaunched** - C. Todd Lombardo
- **Inspired** - Marty Cagan
- [ProductPlan Roadmap Guide](https://www.productplan.com/learn/what-is-a-product-roadmap/)
- [Intercom on Roadmaps](https://www.intercom.com/blog/product-roadmap/)
