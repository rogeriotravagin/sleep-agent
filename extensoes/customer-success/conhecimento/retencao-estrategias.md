# Estrategias de Retencao

## Visao Geral

Retencao e a capacidade de manter clientes ao longo do tempo. E mais barato e rentavel reter do que adquirir.

> "A 5% increase in customer retention can increase company revenue by 25-95%." - Bain & Company

---

## Economia da Retencao

### Custo de Churn

| Metrica | Impacto |
|---------|---------|
| CAC | 5-25x mais caro adquirir vs reter |
| Churn 5%/mes | 46% de perda anual |
| Churn 2%/mes | 21% de perda anual |
| Cada 1% churn | -12% receita em 5 anos |

### Valor da Retencao

```
Cliente retido por mais 1 ano:
- +100% do valor do primeiro ano
- +Probabilidade de expansion
- +Referencias e advocacy
- +Feedback para produto
```

---

## Tipos de Churn

### Churn Voluntario vs Involuntario

| Tipo | Causa | Solucao |
|------|-------|---------|
| **Voluntario** | Cliente decide cancelar | CS, valor, relacionamento |
| **Involuntario** | Falha de pagamento | Dunning, retry, notificacoes |

### Distribuicao Tipica

```
Churn Total = 100%

Voluntario: 70-80%
├── Nao ve valor: 40%
├── Mudou prioridades: 20%
├── Competitor: 10%
└── Preco: 10%

Involuntario: 20-30%
├── Cartao expirado: 60%
├── Limite excedido: 25%
└── Conta fechada: 15%
```

---

## Sinais de Risco (Early Warning)

### Indicadores de Churn

| Categoria | Sinal | Peso |
|-----------|-------|------|
| **Uso** | Login declinando | Alto |
| **Uso** | Features core abandonadas | Alto |
| **Engajamento** | Sem resposta a emails | Medio |
| **Engajamento** | Cancelou reunioes | Medio |
| **Suporte** | Tickets criticos | Alto |
| **Suporte** | Reclamacoes repetidas | Alto |
| **Stakeholder** | Champion saiu | Critico |
| **Stakeholder** | Novo decisor | Medio |
| **Financeiro** | Pagamento atrasado | Alto |
| **Financeiro** | Pediu desconto | Medio |

### Sistema de Alertas

```
Alerta Vermelho (Acao em 24h):
- Pediu cancelamento
- Champion saiu
- Pagamento falhou 3x
- NPS 0-3

Alerta Laranja (Acao em 48h):
- Uso caiu >50%
- Ticket critico aberto
- Sem login >14 dias
- NPS 4-5

Alerta Amarelo (Acao em 1 semana):
- Uso declinando
- Sem resposta a contato
- Reuniao cancelada
- NPS 6
```

---

## Playbooks de Retencao

### Save Play - Cliente Pediu Cancelamento

```
Dia 0: Pedido de cancelamento recebido

Hora 1: Ligacao imediata
- Entender motivo real
- Escutar sem defender
- Documentar feedback

Hora 4: Analise interna
- Revisar historico
- Identificar opcoes
- Preparar proposta

Dia 1: Proposta de retencao
- Addressing root cause
- Oferta de valor (nao desconto)
- Plano de acao concreto

Dia 3: Follow-up
- Verificar decisao
- Se ficou: plano de sucesso
- Se saiu: exit interview

Pos-churn (se aplicavel):
- Pesquisa de saida
- Analise de causa raiz
- Documentar aprendizado
- Planejar win-back
```

### Save Play - Uso Declinando

```
Gatilho: Uso caiu >30% em 30 dias

Semana 1:
- [ ] Analisar dados de uso
- [ ] Identificar causa provavel
- [ ] Email personalizado
- [ ] Propor call de check-in

Semana 2:
- [ ] Call de diagnostico
- [ ] Entender mudancas no cliente
- [ ] Criar plano de reengajamento
- [ ] Enviar recursos relevantes

Semana 3:
- [ ] Treinamento focado (se necessario)
- [ ] Apresentar novos features
- [ ] Conectar com outros usuarios
- [ ] Verificar progresso

Semana 4:
- [ ] Avaliar resultado
- [ ] Ajustar Health Score
- [ ] Documentar learnings
```

---

## Estrategias Proativas

### 1. Customer Health Monitoring

```
Monitoramento Diario:
- Health Score por cliente
- Alertas automaticos
- Dashboard de risco

Acoes por Score:
80-100: Focus em expansion
60-79:  Monitor de perto
40-59:  Intervencao planejada
<40:    Save play urgente
```

### 2. Success Planning

| Elemento | Descricao |
|----------|-----------|
| Objetivos | Metas claras do cliente |
| Milestones | Marcos de sucesso |
| Metricas | Como medir progresso |
| Responsaveis | Quem faz o que |
| Timeline | Quando cada coisa |

### 3. Regular Business Reviews (QBRs)

```
Frequencia por Tier:
Enterprise: Trimestral
Mid-Market: Semestral
SMB: Anual (se presencial)
```

### 4. Executive Sponsorship

| Nivel Cliente | Sponsor Interno |
|---------------|-----------------|
| C-Level | VP/Director |
| Director | Manager |
| Manager | CSM Senior |

### 5. Multi-threading

```
Risco: Apenas 1 contato no cliente

Estrategia:
1. Identificar 3-5 stakeholders
2. Construir relacionamento com cada
3. Incluir em comunicacoes
4. Envolver em treinamentos
5. Garantir sponsor executivo
```

---

## Prevencao de Churn Involuntario

### Dunning Management

| Falha | Acao |
|-------|------|
| 1a tentativa | Retry em 24h |
| 2a falha | Email + retry |
| 3a falha | Email urgente + SMS |
| 4a falha | Call do CS |
| 5a falha | Suspensao + final notice |

### Boas Praticas

1. **Notificar antes do vencimento**
2. **Multiplas formas de pagamento**
3. **Retry inteligente** (diferentes horarios)
4. **Comunicacao clara** (nao automatica demais)
5. **Facilitar atualizacao**

---

## Win-Back Campaigns

### Quando Aplicar

| Criterio | Win-back Viavel |
|----------|-----------------|
| Tempo desde churn | <6 meses |
| Motivo do churn | Resolvel |
| Relacionamento | Positivo |
| Produto evoluiu | Relevante |

### Estrategia de Win-Back

```
Mes 1 pos-churn:
- Email "Sentimos sua falta"
- Novidades desde que saiu
- Oferta especial

Mes 3 pos-churn:
- Email de updates
- Novo feature relevante
- Testemunho de cliente similar

Mes 6 pos-churn:
- Pesquisa de feedback
- Ultima tentativa
- Oferta de retorno
```

### Template Email Win-Back

```
Assunto: [Nome], sentimos sua falta + novidade especial

Ola [Nome],

Faz [X meses] que voce deixou [Produto] e
queriamos compartilhar algumas novidades:

Desde que voce saiu, lancamos:
- [Feature 1] - resolve [problema que tinha]
- [Feature 2] - novo recurso popular
- [Melhoria] - baseada em feedback como o seu

Gostaríamos de oferecer [oferta especial] para
você experimentar novamente.

Posso agendar 15 minutos para mostrar o que mudou?

[CTA: Agendar Demo]

[Assinatura]
```

---

## Net Revenue Retention

### Aumentando NRR

```
NRR = Retencao + Expansion - Contraction

Para aumentar:
1. Reduzir churn (retencao)
2. Aumentar upsell (expansion)
3. Reduzir downgrades (contraction)
```

### Estrategias de Expansion

| Tipo | Trigger | Abordagem |
|------|---------|-----------|
| Upsell | Proximo do limite | Oferecer upgrade |
| Cross-sell | Sucesso demonstrado | Produto complementar |
| Add users | Time crescendo | Mais licencas |
| Add teams | Sucesso em 1 area | Expandir departamentos |

---

## Metricas de Retencao

### KPIs Principais

| Metrica | Formula | Benchmark |
|---------|---------|-----------|
| Gross Retention | (MRR - Churn) / MRR | >90% |
| Net Retention | (MRR + Exp - Churn) / MRR | >100% |
| Logo Retention | Clientes fim / Clientes inicio | >85% |
| Save Rate | Saves / Pedidos cancel | >30% |

### Dashboard de Retencao

```
┌────────────────────────────────────────────┐
│         RETENTION DASHBOARD                 │
├────────────────────────────────────────────┤
│                                             │
│  GRR: 94%  │  NRR: 108%  │  Logo: 88%     │
│                                             │
│  Clientes em Risco: 23 (8%)                │
│  ├── Vermelho: 5                           │
│  ├── Laranja: 8                            │
│  └── Amarelo: 10                           │
│                                             │
│  Saves este mes: 7/12 (58%)                │
│  Win-backs: 3                               │
│                                             │
│  Churn por Motivo:                         │
│  ├── Nao ve valor: 45%                     │
│  ├── Prioridades: 25%                      │
│  ├── Competitor: 15%                       │
│  └── Preco: 15%                            │
│                                             │
└────────────────────────────────────────────┘
```

---

## Cultura de Retencao

### Responsabilidade Compartilhada

| Time | Contribuicao |
|------|--------------|
| Produto | Features que retém |
| Marketing | Comunicacao de valor |
| Vendas | Expectativas corretas |
| CS | Acompanhamento |
| Suporte | Resolucao rapida |
| Financeiro | Flexibilidade |

### Rituais de Retencao

1. **Weekly Risk Review** - Revisar clientes em risco
2. **Monthly Churn Analysis** - Analisar churns do mes
3. **Quarterly Voice of Churned** - Padroes de saida
4. **Win/Loss Review** - Saves bem-sucedidos

---

## Referencias

### Especialistas
- Lincoln Murphy - Proactive CS
- Patrick Campbell - ProfitWell, Churn
- Jason Lemkin - SaaStr

### Ferramentas
- ChurnZero
- Gainsight
- ProfitWell Retain
- Baremetrics

---

*Base de Conhecimento - Extensao Customer Success*
