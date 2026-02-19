# Continuous Discovery (Teresa Torres)

Framework completo para descoberta continua de produto baseado no livro Continuous Discovery Habits.

## Conceito Central

> "Continuous discovery e, no minimo, touchpoints semanais com clientes pelo time que esta construindo o produto, onde conduzem pequenas atividades de pesquisa em busca de um resultado de produto desejado."
> - Teresa Torres

## Os 6 Habitos de Discovery

### 1. Outcome-Oriented Work

Comece com o resultado desejado, nao com features.

```
OUTCOME = Mudanca mensuravel no comportamento do usuario
          que gera valor para o negocio

Tipos de Outcomes:
- Business Outcomes: receita, market share, churn
- Product Outcomes: comportamento do usuario no produto
- Traction Metrics: adocao de feature especifica
```

**Hierarquia:**
```
Business Outcome (empresa)
    |
Product Outcome (time) <- Foco aqui
    |
Traction Metrics (feature)
```

### 2. Customer Interviews

Entrevistas semanais como habito keystone.

**Story-Based Interviews:**
```
Em vez de: "O que voce quer?"
Pergunte: "Conte-me sobre a ultima vez que voce..."

Por que funciona:
- Historias revelam comportamento real
- Evita vieses de "o que eu faria"
- Descobre necessidades latentes
```

**Estrutura da Entrevista:**
```
1. Contexto (2min)
   "Estamos pesquisando como pessoas [acao]"

2. Historia Principal (15min)
   "Conte-me sobre a ultima vez que voce [acao]"

   Follow-ups:
   - O que levou a isso?
   - O que aconteceu antes?
   - O que fez depois?
   - Como se sentiu?

3. Exploracao de Frequencia (5min)
   - Isso acontece com que frequencia?
   - Sempre e assim ou varia?

4. Encerramento (3min)
   - Algo mais que gostaria de compartilhar?
```

### 3. Opportunity Mapping

Mapeie o espaco de oportunidades.

**Opportunity Solution Tree (OST):**
```
                [OUTCOME DESEJADO]
                       |
        +--------------+--------------+
        |              |              |
   [Oportunidade] [Oportunidade] [Oportunidade]
        |              |              |
    +---+---+      +---+---+      +---+---+
    |       |      |       |      |       |
[Solucao][Solucao][Solucao][Solucao][Solucao][Solucao]
    |       |      |       |      |       |
[Teste] [Teste] [Teste] [Teste] [Teste] [Teste]
```

**Oportunidades:**
- Necessidades nao atendidas
- Pontos de dor (pain points)
- Desejos nao realizados

**Como Extrair de Entrevistas:**
```
Usuario diz: "Perdi 20 minutos procurando o arquivo certo"

Oportunidades:
- Encontrar arquivos rapidamente
- Organizar arquivos de forma intuitiva
- Saber onde esta cada arquivo
```

### 4. Prioritizing Opportunities

Escolha uma oportunidade por vez.

**Criterios de Priorizacao:**
```
[ ] Alinhada com o outcome?
[ ] Grande o suficiente para importar?
[ ] Pequena o suficiente para resolver em semanas?
[ ] Temos acesso aos usuarios afetados?
[ ] Time tem interesse/energia?
```

**Regra do "Crummy First Draft":**
- Nao espere perfeicao
- Comece com o que sabe
- Itere conforme aprende

### 5. Ideating Solutions

Gere multiplas solucoes.

**Compare and Contrast:**
```
Por que multiplas solucoes?
- Evita confirmation bias
- Permite trade-off analysis
- Aumenta chance de encontrar melhor opcao

Minimo: 3 solucoes diferentes para cada oportunidade
```

**Tecnicas de Ideacao:**
```
1. Brainstorm Individual (5min)
   - Cada pessoa gera ideias sozinha

2. Compartilhar (10min)
   - Cada um apresenta suas ideias

3. Construir (10min)
   - Combinar e evoluir ideias

4. Selecionar (5min)
   - Escolher 3 para testar
```

### 6. Testing Assumptions

Teste hipoteses antes de construir.

**Tipos de Assumptions:**
```
DESEJABILIDADE
- Usuarios querem isso?
- Resolve um problema real?

USABILIDADE
- Conseguem usar?
- Entendem como funciona?

VIABILIDADE
- Conseguimos construir?
- Temos tecnologia/skills?

NEGOCIO (Business Viability)
- Faz sentido economicamente?
- Cabe no modelo de negocio?
```

**Assumption Mapping:**
```
                    RISCO ALTO
                        |
    +-------------------+-------------------+
    |                   |                   |
    | "Leap of Faith"   | Testar primeiro   |
    | Assumptions       |                   |
    |                   |                   |
SABEMOS +---------------+-------------------+ NAO SABEMOS
POUCO   |                   |                   | MUITO
    | Baixa prioridade  | Monitorar         |
    |                   |                   |
    +-------------------+-------------------+
                        |
                    RISCO BAIXO
```

**Metodos de Teste Rapidos:**
```
| Metodo | Tempo | Bom para |
|--------|-------|----------|
| One-question survey | 1 dia | Desejabilidade |
| Smoke test (landing) | 2 dias | Desejabilidade |
| Prototipo papel | 1 dia | Usabilidade |
| Prototipo clicavel | 3 dias | Usabilidade |
| Wizard of Oz | 1 semana | Viabilidade |
| Concierge | 1 semana | Negocio |
```

## Cadencia Semanal

```
SEGUNDA
[ ] Revisar aprendizados da semana anterior
[ ] Atualizar OST

TERCA-QUINTA
[ ] 1-2 entrevistas com usuarios
[ ] Executar testes de assumptions

SEXTA
[ ] Sintetizar aprendizados
[ ] Planejar proxima semana
[ ] Atualizar documentacao
```

## Product Trio

Discovery funciona melhor com o trio trabalhando junto:

```
PM (Product Manager)
- Lidera discovery
- Garante viabilidade de negocio
- Prioriza oportunidades

DESIGNER
- Conduz entrevistas
- Cria prototipos
- Garante usabilidade

ENGINEER
- Avalia viabilidade tecnica
- Sugere solucoes inovadoras
- Estima complexidade
```

**Rituais do Trio:**
```
Daily Standup: Sincronizar discovery e delivery
Weekly: Revisar OST e planejar testes
Interviews: Pelo menos 1 pessoa do trio presente
```

## Erros Comuns

### 1. Discovery como Fase
```
ERRADO: Discovery -> Delivery -> Discovery -> Delivery
CERTO: Discovery e Delivery em paralelo, continuamente
```

### 2. Perguntar o que Usuarios Querem
```
ERRADO: "Que feature voce gostaria?"
CERTO: "Conte sobre a ultima vez que..."
```

### 3. Testar Apenas Uma Solucao
```
ERRADO: Ter uma ideia favorita e validar
CERTO: Comparar 3+ solucoes diferentes
```

### 4. Esperar Certeza
```
ERRADO: Testar ate ter 100% certeza
CERTO: Reduzir risco suficiente para agir
```

## Templates

### Interview Synthesis
```markdown
# Sintese de Entrevista

**Entrevistado:** [Codigo/Nome]
**Data:** [Data]
**Entrevistador:** [Nome]

## Historia Principal
[Resumo da historia contada]

## Citacoes Importantes
- "[quote 1]"
- "[quote 2]"

## Oportunidades Identificadas
1. [Oportunidade extraida]
2. [Oportunidade extraida]

## Insights
[O que aprendemos de novo]

## Perguntas Abertas
[O que ainda queremos entender]
```

### Assumption Test Card
```markdown
# Teste de Assumption

**Hipotese:** Acreditamos que [X]
**Tipo:** [ ] Desejabilidade [ ] Usabilidade [ ] Viabilidade [ ] Negocio

**Teste:**
- Metodo: [Como vamos testar]
- Duracao: [Tempo]
- Participantes: [Quem/Quantos]

**Criterio de Sucesso:**
Se [X acontecer], consideramos validado

**Resultado:** [ ] Validado [ ] Invalidado [ ] Inconclusivo

**Aprendizado:**
[O que aprendemos]
```

## Referencias

- **Continuous Discovery Habits** - Teresa Torres
- [ProductTalk.org](https://www.producttalk.org) - Blog e recursos
- [Opportunity Solution Trees](https://www.producttalk.org/opportunity-solution-trees/)
- **Sprint** - Jake Knapp (complementar para testes rapidos)
