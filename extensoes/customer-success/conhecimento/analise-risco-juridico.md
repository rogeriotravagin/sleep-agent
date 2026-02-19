# Metodologia de Análise de Risco Jurídico
## Framework para Avaliação de Riscos Legais em Casos Críticos de CS

> **Objetivo:** Fornecer metodologia clara e objetiva para CSMs avaliarem riscos jurídicos e tomarem decisões informadas, sem precisar ser advogado.

---

## 🎯 O que é Análise de Risco Jurídico?

É o processo de avaliar:
1. **Probabilidade** de o caso virar processo judicial
2. **Embasamento legal** do cliente (ele tem razão?)
3. **Vulnerabilidades** da empresa (onde estamos expostos?)
4. **Custo** de litígio vs. custo de acordo
5. **Impacto** de precedente (outros casos similares)

**Importante:** Esta análise é feita por CS para **decisões iniciais**. Casos complexos SEMPRE devem ir para jurídico.

---

## 📊 Framework de Análise em 5 Etapas

### ETAPA 1: CLASSIFICAR O TIPO DE RECLAMAÇÃO

#### Tipo A: Vício de Produto/Serviço
**Base Legal:** CDC Art. 18, 20
**Descrição:** Produto/serviço não funciona como deveria
**Exemplos:**
- Software com bugs críticos
- Produto recebido com defeito
- Serviço não executado corretamente

**Risco:** 🔴 ALTO (se dentro do prazo legal e não resolvido)

---

#### Tipo B: Publicidade Enganosa / Promessa Não Cumprida
**Base Legal:** CDC Art. 30, 37
**Descrição:** O que foi prometido não foi entregue
**Exemplos:**
- Landing page prometeu feature X, produto não tem
- Sales prometeu resultado Y, não foi atingido
- Marketing mostrou interface diferente da real

**Risco:** 🔴 ALTO (oferta vincula fornecedor)

---

#### Tipo C: Cobrança Indevida
**Base Legal:** CDC Art. 42
**Descrição:** Cliente foi cobrado incorretamente
**Exemplos:**
- Cobrança após cancelamento
- Valor diferente do contratado
- Cobrança de serviço não contratado

**Risco:** 🔴 CRÍTICO (cliente tem direito a receber EM DOBRO)

---

#### Tipo D: Dificuldade de Cancelamento
**Base Legal:** CDC Art. 6º III, Art. 39
**Descrição:** Cliente quer cancelar mas empresa dificulta
**Exemplos:**
- "Precisa ligar para cancelar" (quando contratou online)
- Burocracia excessiva
- Demora proposital
- Cobrar multa abusiva

**Risco:** 🟠 GRAVE (prática abusiva clara)

---

#### Tipo E: Direito de Arrependimento (7 dias)
**Base Legal:** CDC Art. 49
**Descrição:** Cliente comprou online e quer devolver em 7 dias
**Exemplos:**
- Qualquer compra online/telefone
- Cliente não precisa justificar
- Deve receber 100% de volta

**Risco:** 🟠 GRAVE (se negar = violação clara)

---

#### Tipo F: Cláusula Abusiva
**Base Legal:** CDC Art. 51
**Descrição:** Contrato tem cláusula que viola CDC
**Exemplos:**
- Multa de cancelamento desproporcional
- "Não nos responsabilizamos por nada"
- Aumento unilateral de preço
- Cliente obrigado a arbitragem

**Risco:** 🟡 MODERADO (cláusula é nula, mas pode negociar)

---

#### Tipo G: Expectativa Frustrada (Sem Base Legal)
**Base Legal:** Nenhuma
**Descrição:** Cliente esperava algo, mas produto/serviço está conforme especificado
**Exemplos:**
- "Pensei que faria X" (mas não prometido)
- "Não gostei" (mas funciona)
- "Não serve para mim" (fora do prazo de 7 dias)

**Risco:** 🟢 BAIXO (sem violação CDC)

---

#### Tipo H: Má-fé / Tentativa de Extorsão
**Base Legal:** Nenhuma (cliente age de má-fé)
**Descrição:** Cliente tenta tirar vantagem indevida
**Exemplos:**
- Usar produto e devolver (fora do prazo)
- Ameaçar com processo falso
- Pedir compensação absurda

**Risco:** 🟢 BAIXO (empresa pode ser firme)

---

## 📐 ETAPA 2: CALCULAR SCORE DE RISCO JURÍDICO

### Usar esta fórmula:

**Risco Jurídico = (Base Legal × 4) + (Prazo × 3) + (Evidências × 2) + (Precedente × 1)**

*Máximo: 100 pontos*

---

### 2.1 Base Legal (0-10)

| Score | Situação |
|-------|----------|
| **10** | CDC claramente violado, cliente tem razão total |
| **8** | CDC provavelmente violado, cliente tem razão provável |
| **6** | Área cinzenta, depende de interpretação |
| **4** | CDC provavelmente não violado, cliente tem razão fraca |
| **2** | CDC claramente não violado, cliente sem razão legal |
| **0** | Cliente age de má-fé |

**Multiplicador: ×4**

---

### 2.2 Prazo Legal (0-10)

| Score | Situação |
|-------|----------|
| **10** | Dentro do prazo legal (7, 30 ou 90 dias) |
| **7** | Prazo vencido recentemente (até 6 meses) |
| **4** | Prazo vencido há mais de 6 meses |
| **2** | Prazo vencido há mais de 1 ano |
| **0** | Prescrito (mais de 5 anos) |

**Multiplicador: ×3**

---

### 2.3 Evidências (0-10)

| Score | Situação |
|-------|----------|
| **10** | Cliente tem todas as evidências (prints, emails, gravações) |
| **7** | Cliente tem a maioria das evidências |
| **5** | Evidências divididas (ambos têm pontos) |
| **3** | Empresa tem mais evidências que cliente |
| **0** | Empresa tem todas as evidências, cliente não tem nada |

**Multiplicador: ×2**

---

### 2.4 Precedente (0-10)

| Score | Situação |
|-------|----------|
| **10** | Muitos casos similares que empresa perdeu |
| **7** | Alguns casos similares contra empresa |
| **5** | Sem precedente claro |
| **3** | Alguns casos similares que empresa ganhou |
| **0** | Muitos casos similares que empresa ganhou |

**Multiplicador: ×1**

---

### Interpretação do Score Final

| Score | Classificação | Ação |
|-------|---------------|------|
| **80-100** | 🔴 RISCO CRÍTICO | Envolver jurídico IMEDIATAMENTE |
| **60-79** | 🟠 RISCO ALTO | Resolver em 24h ou envolver jurídico |
| **40-59** | 🟡 RISCO MODERADO | Resolver em 48h com compensação |
| **20-39** | 🟢 RISCO BAIXO | Resolver com processo padrão CS |
| **0-19** | 🟢 RISCO MÍNIMO | Pode ser firme, documentar bem |

---

## 🔍 ETAPA 3: CHECKLIST DE VULNERABILIDADES

**Avaliar onde a empresa está exposta:**

### ✅ Vulnerabilidades de Informação/Publicidade

- [ ] Landing pages prometem mais do que produto entrega?
- [ ] Sales deck tem informações que não são verdadeiras?
- [ ] Depoimentos são reais ou fabricados?
- [ ] Comparações com concorrentes são verdadeiras?
- [ ] Garantias são claras e cumpridas?

**Se SIM para qualquer:** 🔴 Vulnerabilidade Art. 30, 37 CDC

---

### ✅ Vulnerabilidades de Produto/Serviço

- [ ] Produto/serviço tem bugs/defeitos conhecidos?
- [ ] Downtime frequente sem SLA claro?
- [ ] Features prometidas não funcionam?
- [ ] Qualidade inferior ao especificado?

**Se SIM para qualquer:** 🔴 Vulnerabilidade Art. 18, 20 CDC

---

### ✅ Vulnerabilidades de Cobrança

- [ ] Sistema de cobrança tem erros conhecidos?
- [ ] Cobranças acontecem após cancelamento?
- [ ] Valores cobrados diferem do contratado?
- [ ] Dificuldade de estornar cobranças erradas?

**Se SIM para qualquer:** 🔴 Vulnerabilidade CRÍTICA Art. 42 CDC (dobro)

---

### ✅ Vulnerabilidades de Contrato/Termos

- [ ] Termos de uso têm cláusulas abusivas (Art. 51)?
- [ ] Multas de cancelamento desproporcionais?
- [ ] "Não nos responsabilizamos" genérico?
- [ ] Empresa pode alterar preço unilateralmente?
- [ ] Cliente obrigado a arbitragem?

**Se SIM para qualquer:** 🟠 Vulnerabilidade Art. 51 CDC (cláusula nula)

---

### ✅ Vulnerabilidades de Cancelamento

- [ ] Cancelamento mais difícil que contratação?
- [ ] Exige ligação/email quando contratou online?
- [ ] Demora mais que 48h para processar?
- [ ] Pede "motivo" para cancelar?
- [ ] Dificulta de propósito?

**Se SIM para qualquer:** 🟠 Vulnerabilidade Art. 39 CDC (prática abusiva)

---

### ✅ Vulnerabilidades de Arrependimento (7 dias)

- [ ] Vendas online não oferecem devolução em 7 dias?
- [ ] Devolução não é imediata e integral?
- [ ] Exige justificativa para arrependimento?
- [ ] Cobra "restocking fee"?

**Se SIM para qualquer:** 🟠 Vulnerabilidade Art. 49 CDC

---

## 💰 ETAPA 4: ANÁLISE DE CUSTO-BENEFÍCIO

### Calcular:

#### 4.1 Custo de Litigar (Se for para justiça)

**Custos Diretos:**
- Honorários advocatícios (estimativa: R$ 5.000 - R$ 50.000+)
- Custas processuais
- Perícias (se necessário)
- Tempo da equipe interna

**Custos Indiretos:**
- Tempo de gestão/diretoria
- Desgaste reputacional
- Energia emocional

**Risco de Perder:**
- Valor em disputa
- Custas do processo
- Honorários de sucumbência
- Danos morais (se pedido)

**Total Estimado de Custo de Litígio:** R$ ____________

---

#### 4.2 Custo de Acordo (Resolver agora)

**Custos Diretos:**
- Valor de reembolso/compensação
- Tempo de CS (algumas horas)

**Custos Indiretos:**
- Precedente (outros podem pedir igual)
- Nenhum desgaste adicional

**Total Estimado de Custo de Acordo:** R$ ____________

---

### Comparação:

```
Se Custo de Acordo < (Custo de Litígio × Probabilidade de Perder)
→ Acordo é melhor opção financeira
```

**Exemplo:**
- Custo de Acordo: R$ 2.000
- Custo de Litígio: R$ 15.000
- Probabilidade de Perder: 70%
- Cálculo: R$ 2.000 < (R$ 15.000 × 0,7 = R$ 10.500)
- **Conclusão:** Acordo é muito melhor

---

## 📋 ETAPA 5: DECISÃO FINAL

### Decision Tree:

```
1. Cliente tem base legal forte (Score > 60)?
   └─ SIM → Resolver imediatamente, compensar
   └─ NÃO → Ir para 2

2. Cliente está dentro do prazo legal?
   └─ SIM → Ir para 3
   └─ NÃO → Risco reduzido, pode negociar mais

3. Exposição pública ou risco reputacional alto?
   └─ SIM → Resolver rapidamente
   └─ NÃO → Ir para 4

4. Custo de acordo < custo de litígio?
   └─ SIM → Fazer acordo
   └─ NÃO → Ir para 5

5. Caso pode criar precedente perigoso?
   └─ SIM → Avaliar com liderança/jurídico
   └─ NÃO → Pode ser mais firme

6. Cliente está de má-fé?
   └─ SIM → Ser firme, documentar, limites claros
   └─ NÃO → Buscar win-win
```

---

## 🎯 Matriz de Decisão

| Risco Jurídico | Risco Reputacional | Custo | Ação Recomendada |
|----------------|-------------------|-------|------------------|
| 🔴 Alto | 🔴 Alto | Alto | Envolver jurídico + liderança + resolver RÁPIDO |
| 🔴 Alto | 🟢 Baixo | Alto | Envolver jurídico + acordo formal |
| 🔴 Alto | 🔴 Alto | Baixo | Resolver imediatamente (sem jurídico) |
| 🟠 Médio | 🔴 Alto | Qualquer | Resolver em 24h + compensar |
| 🟠 Médio | 🟡 Médio | Baixo | Resolver em 48h |
| 🟢 Baixo | 🔴 Alto | Qualquer | Resolver por reputação |
| 🟢 Baixo | 🟢 Baixo | Qualquer | Processo padrão CS |

---

## 📝 Template de Análise de Risco Jurídico

```markdown
# ANÁLISE DE RISCO JURÍDICO - Caso [ID]

## 1. CLASSIFICAÇÃO

**Tipo de Reclamação:** [A-H]
**Base Legal:** [Art. CDC]

## 2. SCORE DE RISCO

**Base Legal:** [0-10] × 4 = [score]
**Prazo:** [0-10] × 3 = [score]
**Evidências:** [0-10] × 2 = [score]
**Precedente:** [0-10] × 1 = [score]

**TOTAL:** [0-100]
**Classificação:** 🔴 CRÍTICO / 🟠 ALTO / 🟡 MODERADO / 🟢 BAIXO

## 3. ANÁLISE LEGAL

**Cliente tem razão?** [SIM / PARCIAL / NÃO]

**Artigos CDC aplicáveis:**
- Art. [X] - [descrição]
- Art. [Y] - [descrição]

**Vulnerabilidades da empresa:**
- [Vulnerabilidade 1]
- [Vulnerabilidade 2]

**Pontos de defesa:**
- [Defesa 1]
- [Defesa 2]

## 4. ANÁLISE FINANCEIRA

**Custo estimado de litígio:** R$ [valor]
**Custo estimado de acordo:** R$ [valor]
**Recomendação financeira:** [Acordo / Litigar]

## 5. PRECEDENTE

**Este caso pode criar precedente para:**
- [Situação 1]
- [Situação 2]

**Casos similares anteriores:**
- [Caso A] - Resultado: [...]
- [Caso B] - Resultado: [...]

## 6. RECOMENDAÇÃO

**Ação:** [Resolver / Acordo / Envolver Jurídico / Ser Firme]
**Prazo:** [Imediato / 24h / 48h]
**Escalação:** [SIM - Jurídico/Liderança / NÃO]

**Justificativa:**
[Explicação da recomendação]

## 7. PLANO DE AÇÃO

1. [Ação 1]
2. [Ação 2]
3. [Ação 3]

---

**Analisado por:** [Nome]
**Data:** [Data]
```

---

## 🚨 Red Flags que Exigem Ação Imediata

**Envolver JURÍDICO imediatamente se:**
- ✅ Cliente mencionou advogado
- ✅ Recebeu notificação extrajudicial
- ✅ Caso já é processo judicial
- ✅ Cobrança indevida com valor alto (risco de dobro)
- ✅ Múltiplos clientes com mesmo problema
- ✅ Vulnerabilidade sistêmica identificada
- ✅ Score de risco > 80

**Envolver LIDERANÇA imediatamente se:**
- ✅ Exposição pública com alta visibilidade
- ✅ Decisão cria precedente importante
- ✅ Valor em disputa > [threshold empresa]
- ✅ Cliente VIP/estratégico

---

## 🛡️ Como Proteger a Empresa

### Documentação é Tudo

**Sempre documentar:**
- ✅ Termos aceitos pelo cliente (timestamp)
- ✅ Emails enviados (confirmações, avisos)
- ✅ Comunicações do cliente (prints, gravações)
- ✅ Ações tomadas pela empresa
- ✅ Tentativas de resolução

**💡 Lembre-se:** No CDC, inversão do ônus da prova. **Empresa precisa provar que agiu certo.**

---

### Comunicação Consciente

**NUNCA escrever:**
- ❌ "Você está errado"
- ❌ "Não temos responsabilidade"
- ❌ "Problema é seu"
- ❌ "Não vamos fazer nada"
- ❌ "Pode processar se quiser"

**SEMPRE escrever:**
- ✅ Fatos objetivos
- ✅ Referências a documentos
- ✅ Soluções propostas
- ✅ Prazos específicos
- ✅ Tom profissional e respeitoso

---

## 💼 Quando é Hora de Envolver Jurídico

### Checklist:

**Envolver jurídico SE:**
- [ ] Score de risco > 80
- [ ] Ameaça formal de processo
- [ ] Cliente mencionou advogado
- [ ] Notificação recebida
- [ ] Dúvida sobre responsabilidade legal
- [ ] Valor > R$ [threshold]
- [ ] Caso pode criar precedente perigoso
- [ ] Múltiplos clientes afetados
- [ ] Vulnerabilidade sistêmica identificada
- [ ] Cliente pediu acordo formal escrito

**Como preparar para jurídico:**
1. ✅ Documentar tudo (timeline, evidências)
2. ✅ Fazer análise de risco (este documento)
3. ✅ Preparar resumo executivo
4. ✅ Listar perguntas específicas
5. ✅ Não prometer nada ao cliente antes de alinhar

---

## 🎓 Interpretação do CDC para CSMs

### Princípios Fundamentais:

**1. CDC Protege o Consumidor (Hipossuficiente)**
- Na dúvida, juiz decide a favor do cliente
- Empresa precisa provar que está certa
- Cliente não precisa provar que está certo

**2. Oferta Vincula Fornecedor**
- O que você prometeu, você deve entregar
- Landing page = contrato
- Email de sales = contrato
- Post em rede social = contrato

**3. Cláusulas Abusivas São Nulas**
- Não importa se cliente "aceitou"
- Não importa se está nos termos
- Se é abusivo, é nulo

**4. Informação Clara é Obrigatória**
- Cliente deve entender facilmente
- Letras miúdas não protegem
- Ambiguidade = interpretação pró-cliente

**5. Direitos do CDC Não Podem Ser Renunciados**
- Cliente não pode "abrir mão"
- Cláusula que tenta isso é nula

---

## 📚 Artigos CDC Mais Acionados em Processos

| Artigo | Tema | % de Processos* |
|--------|------|-----------------|
| Art. 42 | Cobrança indevida | 35% |
| Art. 18 | Vício de produto | 25% |
| Art. 30/37 | Publicidade enganosa | 20% |
| Art. 39 | Práticas abusivas | 10% |
| Art. 49 | Arrependimento 7 dias | 5% |
| Art. 51 | Cláusulas abusivas | 5% |

*Estimativas baseadas em análise de jurisprudência PROCON/STJ

---

## 🎯 Resumo Executivo

**3 Perguntas Essenciais:**

### 1. Cliente tem razão legal?
- ✅ SIM → Resolver imediatamente
- 🟡 PARCIAL → Negociar acordo justo
- ❌ NÃO → Pode ser firme (com empatia)

### 2. Dentro do prazo legal?
- ✅ SIM → Risco alto, agir rápido
- ❌ NÃO → Risco reduzido, mais espaço para negociar

### 3. Vale a pena litigar?
- Custo de Acordo < Custo de Litígio → **FAÇA ACORDO**
- Custo de Acordo > Custo de Litígio → **AVALIAR COM JURÍDICO**

---

## 🏆 Objetivo Final

**Tomar decisões informadas que:**
1. ✅ Protegem a empresa legalmente
2. ✅ Minimizam custos
3. ✅ Resolvem o problema do cliente
4. ✅ Evitam processos desnecessários
5. ✅ Mantêm reputação da marca

**Lembre-se:** Você não precisa ser advogado para fazer boa análise de risco. Você precisa conhecer CDC, pensar criticamente e saber quando escalar.

---

**Esta metodologia permite que CSMs tomem 90% das decisões sem envolver jurídico, reservando o time legal para os 10% de casos realmente complexos.**
