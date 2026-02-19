# Análise de Processos Manuais

## O Que é Análise de Processos?

**Definição:** É o ato de entender, documentar e mapear um processo atual para identificar oportunidades de melhoria e automação.

**Objetivo:** Transformar um processo manual confuso em uma sequência clara de passos que podem ser otimizados ou automatizados.

## Metodologia: 5 Etapas

### Etapa 1: DESCOBERTA
**O que fazer:** Ouvir o cliente descrever o processo em suas próprias palavras.

**Como fazer:**
- Deixe o cliente falar livremente
- Faça perguntas abertas: "Como você faz X hoje?"
- Não interrompa para corrigir ou sugerir
- Anote palavras-chave e termos que ele usa

**Perguntas essenciais:**
- "Pode me descrever o processo do início ao fim?"
- "O que dispara esse processo? (O que te faz começar?)"
- "Com que frequência você faz isso?"
- "Quanto tempo leva, em média?"

### Etapa 2: MAPEAMENTO
**O que fazer:** Documentar o processo passo a passo.

**Framework: SIPOC**
```
SUPPLIER → INPUT → PROCESS → OUTPUT → CUSTOMER

Fornecedor  Entrada   Processo   Saída     Cliente
(Quem dá)   (O quê)   (Como)     (Resulta) (Quem recebe)
```

**Exemplo:**
```
FORNECEDOR: Sistema de vendas
INPUT: Notificação de nova venda
PROCESSO:
  1. Receber email com dados da venda
  2. Abrir planilha de controle
  3. Copiar dados do email
  4. Colar na próxima linha da planilha
  5. Abrir CRM
  6. Buscar cliente pelo email
  7. Atualizar status para "Cliente Ativo"
OUTPUT: Venda registrada e cliente ativado
CUSTOMER: Time comercial
```

**Template de Mapeamento:**
```markdown
## Processo: [Nome do Processo]

### Informações Gerais
- **Responsável:** Quem executa
- **Frequência:** Diária/Semanal/Mensal
- **Tempo médio:** X minutos/horas
- **Volume:** Quantas vezes por período

### Fluxo de Trabalho

#### Passo 1: [Nome do Passo]
- **O que faz:** Descrição
- **Onde:** Sistema/ferramenta usada
- **Dados necessários:** Informações requeridas
- **Tempo estimado:** X minutos
- **Possíveis problemas:** Erros comuns

#### Passo 2: [Nome do Passo]
...

### Pontos de Decisão
- Se [condição], então [ação A], senão [ação B]

### Exceções e Casos Especiais
- Caso 1: [descrição e como tratar]
- Caso 2: [descrição e como tratar]
```

### Etapa 3: ANÁLISE
**O que fazer:** Identificar gargalos, redundâncias e oportunidades.

**Perguntas para análise:**
- Quais passos são mais demorados?
- Onde acontecem mais erros?
- Quais passos são repetitivos?
- O que poderia ser eliminado?
- O que poderia ser combinado?
- O que poderia ser automatizado?

**Framework: 7 Desperdícios (Lean)**
1. **Transporte:** Mover dados entre sistemas desnecessariamente
2. **Inventário:** Acumular trabalho pendente
3. **Movimento:** Navegar entre muitas telas/sistemas
4. **Espera:** Aguardar aprovações ou carregamentos
5. **Sobreprodução:** Fazer mais do que o necessário
6. **Sobreprocessamento:** Passos redundantes
7. **Defeitos:** Erros que requerem retrabalho

**Matriz de Análise:**
```
Passo | Valor | Tempo | Erro% | Oportunidade
------|-------|-------|-------|-------------
  1   | Alto  | 2min  | 0%    | -
  2   | Baixo | 10min | 5%    | Automatizar
  3   | Alto  | 1min  | 0%    | -
  4   | Baixo | 15min | 10%   | Eliminar/Automatizar
```

### Etapa 4: PRIORIZAÇÃO
**O que fazer:** Decidir o que atacar primeiro.

**Matriz Impacto vs Esforço:**
```
        Alto Impacto
            |
    B       |       A
  (Depois)  |  (PRIORIDADE)
            |
─────────────────────────────
            |
    D       |       C
 (Ignorar)  |    (Depois)
            |
        Baixo Impacto
```

**A - Alta prioridade:** Alto impacto + Baixo esforço
- Economiza muito tempo
- Fácil de implementar
- **COMECE POR AQUI**

**B - Média prioridade:** Alto impacto + Alto esforço
- Vale a pena, mas requer planejamento
- Faça após os "quick wins"

**C - Baixa prioridade:** Baixo impacto + Baixo esforço
- Se sobrar tempo

**D - Não fazer:** Baixo impacto + Alto esforço
- Não vale o investimento

### Etapa 5: PROPOSTA
**O que fazer:** Apresentar solução de forma clara.

**Template de Proposta:**
```markdown
## Proposta de Otimização: [Nome do Processo]

### Situação Atual
- **Tempo total:** X horas/dia ou semana
- **Erros:** Y por semana
- **Custo (tempo):** Z horas/mês
- **Principais dores:** Lista dos problemas

### Solução Proposta

#### O Que Vamos Fazer
[Descrição em linguagem simples]

#### Como Vai Funcionar
1. [Passo 1 - em linguagem não-técnica]
2. [Passo 2 - em linguagem não-técnica]
3. [Passo 3 - em linguagem não-técnica]

#### Benefícios Quantificados
- ⏱️ Economia de tempo: X horas/semana
- ✅ Redução de erros: Y% menos erros
- 😊 Melhoria de qualidade de vida: [descrição]
- 💰 Economia equivalente: R$ Z/mês (se calculável)

#### O Que Precisamos
- [Requisito 1]
- [Requisito 2]
- [Requisito 3]

#### Prazo Estimado
[Fases e tempo estimado]

#### Limitações e Pontos de Atenção
- [Limitação 1]
- [Ponto de atenção 1]

### Próximos Passos
1. [Ação 1]
2. [Ação 2]
3. [Ação 3]
```

## Perguntas por Categoria

### Sobre o Processo Atual
- "Pode me descrever o processo do início ao fim?"
- "Como você sabe que precisa fazer isso?"
- "O que você faz primeiro? E depois?"
- "Quanto tempo leva cada parte?"
- "Quais partes são mais chatas ou demoradas?"

### Sobre Ferramentas e Sistemas
- "Que sistemas ou ferramentas você usa?"
- "Você precisa fazer login em algum site?"
- "De onde vêm os dados que você usa?"
- "Para onde vão os dados depois?"
- "Você usa planilhas? Bancos de dados? Formulários web?"

### Sobre Frequência e Volume
- "Com que frequência você faz isso?"
- "Quantas vezes por dia/semana/mês?"
- "Varia muito ou é sempre a mesma quantidade?"
- "Tem períodos de pico?"

### Sobre Regras e Validações
- "Tem alguma regra especial que você precisa seguir?"
- "Como você decide [X]?"
- "O que você faz se [situação Y] acontecer?"
- "Existem exceções no processo?"
- "Como você valida se está correto?"

### Sobre Erros e Problemas
- "Onde acontecem mais erros?"
- "Que tipos de erro são mais comuns?"
- "O que você faz quando dá erro?"
- "O que mais te frustra nesse processo?"
- "O que você gostaria que fosse diferente?"

### Sobre Resultado Esperado
- "Como você sabe que terminou?"
- "O que seria um resultado perfeito?"
- "Quem usa o resultado do seu trabalho?"
- "Como você comunica que terminou?"

## Identificando Oportunidades de Automação

### ✅ BOM CANDIDATO para Automação
- Processo repetitivo e previsível
- Regras claras e bem definidas
- Alto volume de execuções
- Consome muito tempo
- Propenso a erros humanos
- Usa sistemas com API ou interface web estável

**Exemplos:**
- Copiar dados entre sistemas
- Preencher formulários com dados de planilha
- Baixar relatórios diários
- Enviar emails baseados em gatilhos
- Atualizar status em múltiplos sistemas

### ⚠️ CANDIDATO MÉDIO para Automação
- Processo com algumas variações
- Algumas decisões subjetivas
- Volume médio
- Usa sistemas sem API documentada
- Requer scraping web

**Exemplos:**
- Aprovar pedidos com regras complexas
- Classificar documentos com padrões variados
- Integrar com sistemas antigos

### ❌ MAU CANDIDATO para Automação (por enquanto)
- Processo altamente variável e imprevisível
- Requer julgamento humano significativo
- Volume muito baixo (não compensa)
- Sistema com captcha ou anti-bot forte
- Processo muda constantemente

**Exemplos:**
- Análise criativa de casos únicos
- Negociações personalizadas
- Processos que mudam toda semana

## Calculando ROI (Retorno sobre Investimento)

### Fórmula Simples
```
ECONOMIA MENSAL =
  (Tempo atual por execução - Tempo com automação)
  × Execuções por mês
  × Custo da hora de trabalho

PAYBACK =
  Custo de desenvolvimento
  ÷ Economia mensal
```

### Exemplo
```
Situação Atual:
- Processo manual: 30 minutos
- Execuções: 20 vezes por dia = 400 vezes/mês
- Custo da hora: R$ 50

Com Automação:
- Processo automatizado: 2 minutos
- Redução: 28 minutos por execução

Economia:
28 min × 400 execuções = 11.200 min/mês = 187 horas/mês
187 horas × R$ 50 = R$ 9.350/mês

Se desenvolvimento custa R$ 5.000:
Payback = R$ 5.000 ÷ R$ 9.350 = 0,5 meses
ROI após 1 ano = R$ 112.200 - R$ 5.000 = R$ 107.200
```

## Red Flags: Quando NÃO Automatizar

### 🚩 Processo Ainda Não Estável
Se o processo muda toda semana, estabilize primeiro, automatize depois.

### 🚩 Falta de Clareza
Se o próprio cliente não consegue explicar claramente, não tem como automatizar.

### 🚩 Volume Muito Baixo
1 execução por mês? Provavelmente não vale a pena.

### 🚩 Requer Julgamento Humano Complexo
Se precisa de "bom senso" ou "experiência", automação não substitui (ainda).

### 🚩 Sistema com Captcha Agressivo
Sites com captcha em toda ação não podem ser automatizados.

### 🚩 Compliance e Segurança
Processos com restrições legais/segurança requerem cuidado extra.

## Checklist de Análise Completa

Antes de propor solução, garanta que tem:

- [ ] Processo mapeado do início ao fim
- [ ] Tempo de cada etapa documentado
- [ ] Frequência e volume identificados
- [ ] Sistemas e ferramentas listados
- [ ] Regras e validações documentadas
- [ ] Exceções e casos especiais mapeados
- [ ] Gargalos identificados
- [ ] Oportunidades priorizadas
- [ ] ROI calculado (estimativa)
- [ ] Limitações conhecidas
- [ ] Requisitos técnicos levantados
- [ ] Aprovação do cliente para avançar

## Documentação de Entrega

Ao finalizar análise, entregue:

### 1. Mapeamento de Processo Atual (AS-IS)
Diagrama ou documento mostrando como é hoje.

### 2. Proposta de Processo Otimizado (TO-BE)
Como ficará após automação.

### 3. Análise de Impacto
- Tempo economizado
- Erros reduzidos
- Benefícios intangíveis

### 4. Plano de Implementação
Fases, requisitos, prazos.

### 5. Matriz de Riscos
- O que pode dar errado
- Como mitigar

## Ferramentas Úteis

- **Mapeamento:** Lucidchart, Draw.io, Miro
- **Documentação:** Notion, Confluence, Google Docs
- **Priorização:** Planilhas, Trello
- **Análise de tempo:** Cronômetro, Toggle Track

## Exemplo Completo

Ver arquivo: `exemplos/analise-processo-exemplo.md`
