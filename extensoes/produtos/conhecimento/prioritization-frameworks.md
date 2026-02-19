# Frameworks de Priorizacao

Guia completo dos principais frameworks para priorizar backlog, features e iniciativas de produto.

## Visao Geral

| Framework | Melhor Para | Complexidade | Tempo |
|-----------|-------------|--------------|-------|
| RICE | Decisoes data-driven | Media | 30min |
| Kano | Entender satisfacao | Alta | 1h+ |
| MoSCoW | Sprint planning | Baixa | 15min |
| Value vs Effort | Decisoes rapidas | Baixa | 15min |
| JTBD/ODI | Inovacao | Alta | 2h+ |
| ICE | Experimentos | Baixa | 15min |

---

## 1. RICE Framework

Desenvolvido pela Intercom para priorizacao quantitativa.

### Formula
```
RICE Score = (Reach x Impact x Confidence) / Effort
```

### Componentes

**Reach (Alcance)**
- Quantas pessoas/eventos serao impactados
- Periodo definido (ex: usuarios/trimestre)
- Use dados reais quando possivel

```
Exemplos:
- 10.000 usuarios/mes
- 500 transacoes/semana
- 100% dos novos usuarios
```

**Impact (Impacto)**
Escala padrao:
```
3.0 = Massivo (game changer)
2.0 = Alto (melhoria significativa)
1.0 = Medio (melhoria notavel)
0.5 = Baixo (melhoria pequena)
0.25 = Minimo (quase imperceptivel)
```

**Confidence (Confianca)**
Quanto voce confia nas estimativas:
```
100% = Alta confianca (dados solidos)
80%  = Media confianca (algumas evidencias)
50%  = Baixa confianca (intuicao)
```

**Effort (Esforco)**
Tempo do time em person-months:
```
0.5 = Uma pessoa, 2 semanas
1.0 = Uma pessoa, 1 mes
2.0 = Duas pessoas, 1 mes
```

### Exemplo Pratico
```
| Feature | Reach | Impact | Conf | Effort | Score |
|---------|-------|--------|------|--------|-------|
| Search  | 5000  | 2      | 80%  | 2      | 4000  |
| Export  | 1000  | 3      | 100% | 1      | 3000  |
| Dark Mode| 3000 | 1      | 80%  | 0.5    | 4800  |
```

### Vantagens e Limitacoes
```
Vantagens:
+ Objetivo e quantificavel
+ Reduz vieses pessoais
+ Facil de comunicar

Limitacoes:
- Pode ser manipulado
- Reach nem sempre e mensuravel
- Nao considera estrategia
```

---

## 2. Kano Model

Desenvolvido por Noriaki Kano para categorizar features por satisfacao.

### Categorias

```
SATISFACAO
    ^
    |     Delighters (Atrativos)
    |         /
    |        /
    |-------/-------------> Must-be (Basicos)
    |      /
    |     / Performance (Lineares)
    |    /
    +---/--------------------> FUNCIONALIDADE
    |
```

**Must-be (Basicos)**
- Esperados, nao geram satisfacao quando presentes
- Causam grande insatisfacao quando ausentes
- Ex: Site carregar, botao de login funcionar

**Performance (Lineares)**
- Mais = mais satisfacao
- Relacao proporcional
- Ex: Velocidade, armazenamento

**Delighters (Atrativos)**
- Surpreendem positivamente
- Nao esperados
- Ex: Sugestoes inteligentes, personalizacao

**Indiferentes**
- Nao afetam satisfacao
- Dispensaveis

**Reversos**
- Causam insatisfacao quando presentes
- Alguns usuarios nao querem

### Como Aplicar

**Questionario Kano:**
Para cada feature, pergunte:
1. Funcional: "Como voce se sente se tiver X?"
2. Disfuncional: "Como voce se sente se NAO tiver X?"

**Opcoes de Resposta:**
```
1. Gosto muito
2. Espero que tenha
3. Neutro
4. Posso tolerar
5. Nao gosto
```

**Matriz de Classificacao:**
```
                    DISFUNCIONAL
                1    2    3    4    5
           1    Q    A    A    A    O
FUNCIONAL  2    R    I    I    I    M
           3    R    I    I    I    M
           4    R    I    I    I    M
           5    R    R    R    R    Q

A = Attractive (Delighter)
O = One-dimensional (Performance)
M = Must-be (Basic)
I = Indifferent
R = Reverse
Q = Questionable
```

### Estrategia de Priorizacao
```
1. Primeiro: Garantir todos os Must-be
2. Segundo: Maximizar Performance features
3. Terceiro: Adicionar Delighters para diferenciar
4. Evitar: Indiferentes e Reversos
```

---

## 3. MoSCoW

Simples e efetivo para sprint planning e MVPs.

### Categorias

**Must Have (M)**
- Essencial, sem isso nao funciona
- Requisitos nao negociaveis
- "Tem que ter"

**Should Have (S)**
- Importante mas nao vital
- Pode esperar se necessario
- "Deveria ter"

**Could Have (C)**
- Bom ter se der tempo
- Facil de cortar
- "Poderia ter"

**Won't Have (W)**
- Nao agora, talvez depois
- Fora do escopo atual
- "Nao vai ter (agora)"

### Regra 60-20-20
```
Must Have:  60% do esforco maximo
Should Have: 20% do esforco
Could Have:  20% do esforco
```

### Exemplo Sprint
```
MUST HAVE (60%)
[X] Login com email
[X] Cadastro basico
[X] Dashboard inicial

SHOULD HAVE (20%)
[X] Recuperacao de senha
[ ] Notificacoes email

COULD HAVE (20%)
[ ] Login social
[ ] Personalizacao
[ ] Modo escuro

WON'T HAVE
- App mobile
- Integracao CRM
- Relatorios avancados
```

---

## 4. Value vs Effort Matrix

Visualizacao rapida para decisoes de priorizacao.

### Matriz 2x2
```
VALOR ALTO
    |
    |   Quick Wins    |    Big Bets
    |   (Fazer!)      |    (Planejar)
    |                 |
    +-----------------+-----------------+
    |                 |                 |
    |   Fill-ins      |    Money Pits   |
    |   (Se sobrar)   |    (Evitar!)    |
    |                 |                 |
    +-----------------+-----------------+-> ESFORCO ALTO
VALOR BAIXO         ESFORCO BAIXO
```

### Quadrantes

**Quick Wins (Alto Valor, Baixo Esforco)**
- Prioridade maxima
- ROI mais alto
- Fazer primeiro

**Big Bets (Alto Valor, Alto Esforco)**
- Projetos estrategicos
- Requerem planejamento
- Dividir em partes menores

**Fill-ins (Baixo Valor, Baixo Esforco)**
- Fazer se sobrar tempo
- Pequenas melhorias
- Nao priorizar

**Money Pits (Baixo Valor, Alto Esforco)**
- Evitar
- Desperdicio de recursos
- Questionar se necessario

---

## 5. Jobs to Be Done + Opportunity Scoring

Framework de Anthony Ulwick para inovacao orientada a resultados.

### Conceito
```
JTBD: O que o usuario esta tentando realizar?
      (Independente do produto)

"Usuarios nao querem uma furadeira de 1/4 polegada,
eles querem um buraco de 1/4 polegada."
```

### Opportunity Score
```
Opportunity = Importancia + (Importancia - Satisfacao)

Onde:
- Importancia: 1-10 (quao importante e o job)
- Satisfacao: 1-10 (quao bem e atendido hoje)
```

### Analise
```
IMPORTANCIA
    ^
10  |   Underserved     |   Table Stakes
    |   (Oportunidade!) |   (Manter)
    |                   |
  5 +---------+---------+
    |   Don't Bother    |   Overserved
    |   (Ignorar)       |   (Reduzir?)
    |                   |
    +-------------------+----------------> SATISFACAO
                       5               10
```

### Exemplo
```
| Job | Import. | Satisf. | Opportunity |
|-----|---------|---------|-------------|
| Encontrar arquivo | 9 | 4 | 14 |
| Compartilhar doc | 7 | 7 | 7 |
| Editar texto | 8 | 9 | 7 |
| Organizar pastas | 6 | 3 | 9 |
```

---

## 6. ICE Framework

Simples para priorizar experimentos e growth hacks.

### Formula
```
ICE = Impact x Confidence x Ease
```

### Escala (1-10)

**Impact:** Quanto vai impactar a metrica?
```
10 = Mudanca massiva
5  = Melhoria moderada
1  = Mudanca pequena
```

**Confidence:** Quao confiante voce esta?
```
10 = Certeza baseada em dados
5  = Alguma evidencia
1  = Puro chute
```

**Ease:** Quao facil e implementar?
```
10 = Trivial (horas)
5  = Moderado (dias)
1  = Complexo (semanas)
```

### Exemplo
```
| Experimento | I | C | E | Score |
|-------------|---|---|---|-------|
| Mudar CTA | 8 | 7 | 9 | 504 |
| Novo onboarding | 9 | 5 | 4 | 180 |
| A/B pricing | 10 | 3 | 6 | 180 |
```

---

## Quando Usar Cada Framework

```
Situacao                          Framework Recomendado
---------------------------------------------------------
Backlog trimestral                RICE
Entender o que usuarios querem    Kano
Sprint planning / MVP             MoSCoW
Decisao rapida em reuniao         Value vs Effort
Descobrir inovacao                JTBD + Opportunity
Priorizar experimentos            ICE
```

## Combinando Frameworks

**Abordagem Recomendada:**
```
1. Kano: Entender categorias de satisfacao
2. JTBD: Identificar oportunidades underserved
3. RICE: Priorizar quantitativamente
4. MoSCoW: Definir escopo do sprint
```

## Referencias

- **Intercom on Product Management** - RICE Framework
- **The Kano Model** - Noriaki Kano
- **What Customers Want** - Anthony Ulwick (JTBD/ODI)
- **DSDM Handbook** - MoSCoW Method
