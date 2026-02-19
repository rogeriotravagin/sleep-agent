# Dual-Track Agile

Framework para integrar Discovery e Delivery de forma continua.

## O que e Dual-Track Agile

```
Duas trilhas paralelas que alimentam uma a outra:

DISCOVERY TRACK              DELIVERY TRACK
(Descobrir o que construir)  (Construir com qualidade)
        |                           ^
        |     BACKLOG VALIDADO      |
        +-------------------------->+
        |                           |
        |     LEARNINGS/FEEDBACK    |
        +<--------------------------+
```

## Por que Dual-Track

### Problema do Modelo Tradicional
```
CASCATA / FASES SEQUENCIAIS:

Discovery -> Specs -> Design -> Development -> Launch

Problemas:
- Descobertas tardias sao caras
- Feedback so no final
- Time de produto ocioso durante dev
- Time de dev ocioso durante discovery
```

### Solucao Dual-Track
```
DISCOVERY =============================>
           \   \   \   \   \   \
            -> -> -> -> -> -> (itens validados)
           /   /   /   /   /   /
DELIVERY  ==============================>

Beneficios:
- Descoberta continua
- Feedback constante
- Times produtivos sempre
- Risco reduzido
```

## Como Funciona

### Discovery Track

**Objetivo:** Reduzir risco antes de construir

**Atividades:**
```
[ ] Entrevistas com usuarios (semanais)
[ ] Analise de dados de uso
[ ] Prototipos e testes de conceito
[ ] Validacao de hipoteses
[ ] Definicao de problemas
```

**Output:**
```
- Oportunidades validadas
- Solucoes testadas
- Hipoteses confirmadas/refutadas
- User stories prontas para delivery
```

**Quem participa:**
```
PM + Designer + Tech Lead (minimo)
+ Pesquisadores (se tiver)
+ Engineers interessados
```

### Delivery Track

**Objetivo:** Construir com qualidade e velocidade

**Atividades:**
```
[ ] Refinamento de backlog
[ ] Sprint planning
[ ] Desenvolvimento
[ ] Code review
[ ] QA
[ ] Deploy
```

**Output:**
```
- Produto funcionando
- Features entregues
- Bugs corrigidos
- Debito tecnico endereçado
```

**Quem participa:**
```
Engineers + QA + DevOps
+ PM (parcial)
+ Designer (parcial)
```

## Integracao entre Tracks

### Backlog como Interface
```
         DISCOVERY                    DELIVERY
              |                          |
              v                          v
    [Oportunidade]               [Sprint Backlog]
         |                              ^
         v                              |
    [Solucao testada]                   |
         |                              |
         v                              |
    [User Story validada] ------->------+
         |                              |
         v                              v
    [Criterios de aceitacao]    [Implementacao]
         |                              |
         +------- FEEDBACK <------------+
```

### Definition of Ready (DoR)

Item so entra em Delivery quando:
```
[ ] Problema validado com usuarios
[ ] Solucao testada (prototipo/conceito)
[ ] Riscos principais mitigados
[ ] User story clara e completa
[ ] Criterios de aceitacao definidos
[ ] Time de delivery envolvido no design
[ ] Dependencias mapeadas
[ ] Estimativa de esforço existe
```

### Feedback Loop

```
DELIVERY -> DISCOVERY:
- Complexidade tecnica imprevista
- Oportunidades de simplificacao
- Dados de uso pos-lancamento
- Bugs como fonte de insights

DISCOVERY -> DELIVERY:
- Mudancas de prioridade
- Refinamentos de solucao
- Novos criterios de aceitacao
- Cancelamento de itens invalidados
```

## Cadencia

### Semana Tipica
```
SEGUNDA
Discovery: Revisar aprendizados, planejar semana
Delivery: Sprint planning / Daily

TERCA
Discovery: Entrevistas com usuarios
Delivery: Desenvolvimento

QUARTA
Discovery: Sintese de entrevistas, prototipacao
Delivery: Desenvolvimento

QUINTA
Discovery: Testes de prototipo
Delivery: Desenvolvimento

SEXTA
Discovery: Documentar learnings, preparar backlog
Delivery: Code review, QA, Deploy
```

### Balanco de Tempo

**Para PM:**
```
Discovery: 60-70%
Delivery: 30-40%
```

**Para Designer:**
```
Discovery: 70-80%
Delivery: 20-30% (acompanhamento)
```

**Para Tech Lead:**
```
Discovery: 20-30% (viabilidade)
Delivery: 70-80%
```

**Para Engineers:**
```
Discovery: 10-20% (participacao pontual)
Delivery: 80-90%
```

## Rituais

### Discovery Sync (2x/semana, 30min)
```
Participantes: PM, Designer, Tech Lead

Agenda:
1. O que aprendemos? (10min)
2. O que vamos testar? (10min)
3. O que esta pronto para delivery? (10min)
```

### Backlog Refinement (1x/semana, 1h)
```
Participantes: PM, Designer, Engineers

Agenda:
1. Apresentar itens do discovery (15min)
2. Tirar duvidas tecnicas (15min)
3. Estimar complexidade (20min)
4. Definir criterios de aceitacao (10min)
```

### Sprint Review (1x/sprint)
```
Participantes: Time completo + Stakeholders

Agenda:
1. Demo do que foi entregue
2. Metricas de impacto
3. Learnings do discovery
4. Proximos passos
```

### Retrospectiva Dual-Track (Mensal)
```
Participantes: Time completo

Perguntas:
1. Discovery esta alimentando delivery adequadamente?
2. Delivery esta dando feedback para discovery?
3. DoR esta sendo respeitado?
4. Onde estamos perdendo tempo?
```

## Anti-Patterns

### 1. Discovery como Fase
```
ERRADO:
"Vamos fazer 3 meses de discovery, depois 6 de delivery"

CERTO:
Discovery e delivery acontecem em paralelo, sempre
```

### 2. Handoff Wall
```
ERRADO:
Discovery joga spec "por cima do muro" para delivery

CERTO:
Colaboracao continua, engineers participam de discovery
```

### 3. Discovery sem Delivery
```
ERRADO:
Discovery descobre muitas coisas mas nada e construido

CERTO:
Discovery alimenta delivery com ritmo sustentavel
```

### 4. Delivery sem Discovery
```
ERRADO:
Time de delivery implementa features sem validacao

CERTO:
So entra em delivery o que passou por discovery
```

### 5. PM faz tudo sozinho
```
ERRADO:
PM faz discovery, escreve specs, e joga para dev

CERTO:
Trio (PM, Designer, Tech Lead) faz discovery junto
```

## Metricas de Saude

### Discovery Track
```
[ ] Entrevistas por semana: >= 1
[ ] Tempo medio de validacao: < 2 semanas
[ ] Taxa de itens invalidados: 30-50% (normal)
[ ] Backlog de itens validados: 2-3 sprints
```

### Delivery Track
```
[ ] Velocity estavel
[ ] Items devolvidos para discovery: < 10%
[ ] Bugs em producao: trending down
[ ] Cycle time: trending down
```

### Integracao
```
[ ] Lead time (idea to production): tracking
[ ] % de features baseadas em discovery: > 80%
[ ] Impacto medio de features: measured
```

## Ferramentas Sugeridas

### Discovery
```
- Figma (prototipos)
- Miro (mapeamento)
- Maze/Usertesting (testes)
- Dovetail/Notion (sintese)
```

### Delivery
```
- Jira/Linear (backlog)
- GitHub/GitLab (codigo)
- Notion/Confluence (docs)
```

### Integracao
```
- Productboard (feedback -> roadmap)
- Amplitude/Mixpanel (dados de uso)
- Slack (comunicacao)
```

## Templates

### Discovery Ticket
```markdown
# [DISCOVERY] Nome da Oportunidade

## Hipotese
Acreditamos que [usuarios] tem problema com [X]
porque [evidencia inicial]

## Objetivo
Validar se [hipotese] e verdadeira

## Metodo
- [ ] Entrevistas (N usuarios)
- [ ] Analise de dados
- [ ] Teste de prototipo

## Criterio de Sucesso
Consideramos validado se [criterio]

## Timeline
[Data estimada de conclusao]

## Status
[ ] Planejado
[ ] Em andamento
[ ] Concluido - Validado
[ ] Concluido - Invalidado
```

### Transition to Delivery
```markdown
# [READY] Nome da Feature

## Contexto
[Link para discovery ticket]

## Problema Validado
[Resumo do que descobrimos]

## Solucao Proposta
[Descricao da solucao testada]

## User Story
Como [persona]
Quero [acao]
Para que [beneficio]

## Criterios de Aceitacao
- [ ] [Criterio 1]
- [ ] [Criterio 2]
- [ ] [Criterio 3]

## Riscos Mitigados
- [x] Desejabilidade (testado com N usuarios)
- [x] Viabilidade (validado com tech lead)
- [x] Usabilidade (prototipo testado)

## Estimativa
[Story points / T-shirt size]

## Dependencias
- [Dependencia 1]
```

## Referencias

- **Dual Track Development** - Jeff Patton
- **Inspired** - Marty Cagan
- **Continuous Discovery Habits** - Teresa Torres
- **User Story Mapping** - Jeff Patton
