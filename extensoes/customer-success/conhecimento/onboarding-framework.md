# Framework de Onboarding

## Visao Geral

Onboarding e o processo de levar novos clientes ao primeiro valor e estabelecer fundacao para sucesso a longo prazo.

> "O onboarding nao termina quando o setup termina. Termina quando o cliente tem sucesso." - Lincoln Murphy

---

## Time to First Value (TTFV)

### O que e TTFV

Tempo entre a compra e o momento em que o cliente percebe valor.

```
TTFV = Data First Value - Data Compra

Exemplo:
- Compra: 1 de Janeiro
- First Value: 8 de Janeiro
- TTFV: 7 dias
```

### Por que TTFV Importa

| TTFV | Impacto | Dado |
|------|---------|------|
| <7 dias | Retencao 95%+ | Intercom Study |
| 7-30 dias | Retencao 70-85% | |
| >30 dias | Retencao <50% | |

### Reducao de TTFV

| Estrategia | Descricao | Impacto |
|------------|-----------|---------|
| Pre-boarding | Preparar antes do kickoff | -3 dias |
| Templates | Configuracoes pre-prontas | -2 dias |
| Automacao | Setup automatico | -5 dias |
| Self-service | Cliente faz sozinho | -1 dia |
| Kickoff focado | Ir direto ao valor | -2 dias |

---

## "Aha Moment"

### O que e Aha Moment

O momento em que o cliente percebe o valor do produto.

### Exemplos de Aha Moments

| Produto | Aha Moment |
|---------|------------|
| Slack | Primeira conversa em canal |
| Dropbox | Primeiro arquivo sincronizado |
| Zoom | Primeira reuniao sem problemas |
| HubSpot | Primeiro lead capturado |
| Salesforce | Primeiro deal fechado no CRM |

### Identificando Seu Aha Moment

1. **Analise Cohorts** - Usuarios retidos vs churned
2. **Entrevistas** - "Quando percebeu valor?"
3. **Dados de Uso** - Acoes correlacionadas com retencao
4. **Testes A/B** - Validar hipoteses

### Acelerando o Aha Moment

```
Tradicional:
Signup → Tour → Setup → Config → Uso → Aha!
(pode levar semanas)

Otimizado:
Signup → Aha! rapido → Setup completo → Uso avancado
(dias)
```

---

## Modelos de Onboarding

### High-Touch (Enterprise)

| Caracteristica | Descricao |
|----------------|-----------|
| Ticket | >$50k ARR |
| Duracao | 30-90 dias |
| Pessoas | CSM + Implementation |
| Touchpoints | 10-15 reunioes |
| Customizacao | Alta |

**Processo Tipico:**
1. Kickoff executivo
2. Discovery tecnico
3. Configuracao assistida
4. Integrações
5. Migracao de dados
6. Treinamentos (multiplos)
7. Go-live
8. Hypercare
9. Handoff para CSM

### Mid-Touch (Mid-Market)

| Caracteristica | Descricao |
|----------------|-----------|
| Ticket | $10-50k ARR |
| Duracao | 14-30 dias |
| Pessoas | CSM pooled |
| Touchpoints | 3-5 reunioes |
| Customizacao | Media |

**Processo Tipico:**
1. Kickoff
2. Setup guiado
3. Treinamento principal
4. Go-live
5. Check-in 30 dias

### Tech-Touch (SMB/Self-Service)

| Caracteristica | Descricao |
|----------------|-----------|
| Ticket | <$10k ARR |
| Duracao | <7 dias |
| Pessoas | Produto + Auto |
| Touchpoints | 0-1 reuniao |
| Customizacao | Baixa/Templates |

**Processo Tipico:**
1. Welcome email automatico
2. Product tour in-app
3. Setup wizard
4. Triggers comportamentais
5. Check-in automatizado

---

## Kickoff Meeting

### Objetivos do Kickoff

1. **Alinhar expectativas** - O que vamos fazer juntos
2. **Confirmar objetivos** - Por que compraram
3. **Definir sucesso** - Como saberemos que deu certo
4. **Estabelecer timeline** - Quando chegaremos la
5. **Identificar stakeholders** - Quem esta envolvido
6. **Criar engajamento** - Motivar participacao

### Agenda Modelo (60 min)

```
00-05: Boas-vindas e apresentacoes
05-15: Revisao de objetivos e expectativas
15-25: Overview do processo de onboarding
25-35: Definicao de sucesso e metricas
35-45: Timeline e marcos
45-55: Papeis e responsabilidades
55-60: Proximos passos e homework
```

### Perguntas Essenciais

| Pergunta | Por que |
|----------|---------|
| Por que compraram? | Entender motivacao real |
| O que seria sucesso? | Definir meta clara |
| Quem precisa ser treinado? | Planejar treinamentos |
| Qual o timeline ideal? | Definir urgencia |
| Quais preocupacoes? | Antecipar problemas |

---

## Playbook de Onboarding

### Estrutura de Playbook

```yaml
Playbook: [Nome do Segmento]
Duracao: [X dias]
Objetivo: [Resultado esperado]

Fase 1: Boas-vindas (Dias 0-1)
  - Tarefas:
    - [ ] Enviar email boas-vindas
    - [ ] Liberar acesso
    - [ ] Agendar kickoff
  - Owner: [CSM/Onboarding]
  - Automacoes: [Lista]

Fase 2: Kickoff (Dias 1-3)
  - Tarefas:
    - [ ] Realizar kickoff
    - [ ] Documentar objetivos
    - [ ] Criar plano de sucesso
  - Owner: [CSM]
  - Recursos: [Docs, deck]

Fase 3: Setup (Dias 3-10)
  ...

Fase 4: First Value (Dias 10-14)
  ...

Fase 5: Treinamento (Dias 14-21)
  ...

Fase 6: Handoff (Dias 21-30)
  ...
```

### Checklist de Ativacao

| Marco | Criterio | Medicao |
|-------|----------|---------|
| Setup completo | Config basica ok | Sistema |
| Primeiro login | Usuario logou | Analytics |
| First action | Acao principal feita | Produto |
| First value | Resultado alcancado | CSM verifica |
| Team activated | 3+ usuarios ativos | Analytics |
| Workflow set | Processo funcionando | CSM verifica |

---

## Comunicacao de Onboarding

### Sequencia de Emails

| Dia | Email | Objetivo |
|-----|-------|----------|
| 0 | Boas-vindas | Empolgacao, acesso |
| 1 | Getting started | Primeiros passos |
| 3 | Setup reminder | Garantir progresso |
| 7 | First win | Celebrar marco |
| 14 | Deep dive | Feature avancada |
| 21 | Check-in | Feedback |
| 30 | Success recap | Resumo de valor |

### Template: Email de Boas-vindas

```
Assunto: Bem-vindo(a) a [Produto] - Vamos comecar!

Ola [Nome],

Seja muito bem-vindo(a) a [Produto]!

Estamos empolgados em ter voce conosco e comprometidos
em ajuda-lo(a) a [resultado principal].

**Seus primeiros passos:**
1. Acesse sua conta: [link]
2. Complete o setup inicial (~10 min)
3. [Acao que leva ao Aha Moment]

**Precisa de ajuda?**
- Central de ajuda: [link]
- Agendar call: [link]
- Email: [suporte]

Seu(sua) CSM, [Nome], entrara em contato em breve
para agendar nosso kickoff.

Vamos juntos!

[Assinatura]
```

---

## Metricas de Onboarding

### KPIs Principais

| Metrica | Formula | Meta |
|---------|---------|------|
| TTFV | Dias ate first value | <7 dias |
| Activation Rate | % clientes ativados | >80% |
| Onboarding NPS | NPS pos-onboarding | >50 |
| Setup Time | Dias para setup | <3 dias |
| Training Completion | % treinamento completo | >90% |

### Dashboard de Onboarding

```
┌──────────────────────────────────────────────┐
│         ONBOARDING DASHBOARD                  │
├──────────────────────────────────────────────┤
│                                               │
│  Clientes em Onboarding: 45                  │
│                                               │
│  ┌─────────────────────────────────────┐     │
│  │ Fase         │ Qtd │ % │ On Track  │     │
│  │──────────────┼─────┼───┼───────────│     │
│  │ Kickoff      │ 12  │27%│ 10 (83%)  │     │
│  │ Setup        │ 15  │33%│ 12 (80%)  │     │
│  │ First Value  │ 10  │22%│ 9 (90%)   │     │
│  │ Treinamento  │ 8   │18%│ 7 (87%)   │     │
│  └─────────────────────────────────────┘     │
│                                               │
│  TTFV Medio: 8.5 dias (Meta: <7)             │
│  Activation Rate: 82% (Meta: >80%)           │
│  Onboarding NPS: 54 (Meta: >50)              │
│                                               │
└──────────────────────────────────────────────┘
```

---

## Problemas Comuns

### Red Flags e Acoes

| Sinal | Significado | Acao |
|-------|-------------|------|
| Kickoff remarcado 2x | Baixa prioridade | Escalar, revalidar |
| Sem login em 5 dias | Desengajamento | Call urgente |
| Setup incompleto | Friccao tecnica | Suporte proativo |
| 1 usuario apenas | Risco de champion | Expandir usuarios |
| Perguntas basicas | Treinamento insuficiente | Sessao extra |

### Save Plays de Onboarding

**Cliente parado no setup:**
1. Email com video passo-a-passo
2. Call de 15 min para resolver
3. Oferecer setup assistido
4. Escalar se necessario

**Champion desengajado:**
1. Identificar causa
2. Revalidar objetivos
3. Mostrar quick wins
4. Envolver sponsor

---

## Boas Praticas

### Do's

1. **Foque no valor, nao em features**
2. **Personalize por segmento**
3. **Celebre pequenas vitorias**
4. **Seja proativo**
5. **Documente tudo**
6. **Meca e itere**

### Don'ts

1. **Nao sobrecarregue com informacao**
2. **Nao assuma que todos sao iguais**
3. **Nao ignore sinais de friccao**
4. **Nao espere o cliente pedir ajuda**
5. **Nao pule etapas para acelerar**

---

## Referencias

### Livros
- "Product-Led Onboarding" - Ramli John
- "Intercom on Onboarding" - Intercom

### Ferramentas
- Appcues
- Userpilot
- Pendo
- WalkMe

---

*Base de Conhecimento - Extensao Customer Success*
