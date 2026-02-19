# Quality Gates - Sistema de Validacao

O Sleep Agent usa um sistema de validacao em 3 niveis para garantir que cada entrega atenda aos padroes de qualidade.

---

## Por que 3 Niveis?

Nem toda verificacao e igual. Algumas sao simples e podem ser automaticas, outras precisam de um "segundo par de olhos", e algumas so voce pode decidir.

| Nivel | Quem Valida | Velocidade | Quando Usar |
|-------|-------------|------------|-------------|
| 1 | Automatico | Instantaneo | Formato, completude, regras objetivas |
| 2 | Outro Agente | Rapido | Consistencia, qualidade tecnica |
| 3 | Voce | Variavel | Satisfacao, alinhamento com expectativa |

---

## Nivel 1: Verificacao Automatica

O Sleep Agent verifica automaticamente, sem precisar perguntar.

### Tipos de verificacao:

**Formato**
- Arquivo esta no formato correto?
- Estrutura segue o template?
- Campos obrigatorios preenchidos?

**Completude**
- Todos os itens solicitados foram gerados?
- Nenhuma secao vazia ou incompleta?
- Tamanho adequado (nao muito curto)?

**Regras Objetivas**
- Segue padroes definidos?
- Nao contem erros obvios?
- Referencias existem?

### Exemplo de gates nivel 1:

```yaml
nivel_1_automatico:
  - verificacao: "Arquivo tem mais de 100 palavras?"
    tipo: "tamanho"
  - verificacao: "Todas as secoes do template preenchidas?"
    tipo: "completude"
  - verificacao: "Formato markdown valido?"
    tipo: "formato"
```

### Acoes automaticas:

- **Passou:** Continua para proximo nivel
- **Falhou:** Tenta corrigir automaticamente ou avisa o problema

---

## Nivel 2: Validacao por Agente

Outro agente especializado revisa o trabalho (como pedir opiniao de um colega).

### Tipos de validacao:

**Consistencia**
- Esta alinhado com a identidade da marca?
- Linguagem adequada ao publico?
- Segue tom de voz definido?

**Qualidade Tecnica**
- Copy segue boas praticas?
- Design segue principios corretos?
- Estrategia faz sentido?

**Integracao**
- Funciona com outros materiais existentes?
- Nao contradiz decisoes anteriores?

### Exemplo de gates nivel 2:

```yaml
nivel_2_agente:
  - verificacao: "Copy usa gatilhos mentais adequados?"
    agente_revisor: "copywriter"
  - verificacao: "Visual segue identidade da marca?"
    agente_revisor: "designer"
  - verificacao: "Estrategia esta coerente com posicionamento?"
    agente_revisor: "estrategista"
```

### Acoes possiveis:

- **Aprovado:** Continua para proximo nivel
- **Ajustes sugeridos:** Mostra sugestoes, pergunta se quer aplicar
- **Problemas serios:** Alerta e sugere refazer

---

## Nivel 3: Aprovacao Humana

So voce pode decidir certas coisas. Este nivel garante que o resultado atende suas expectativas reais.

### Tipos de aprovacao:

**Satisfacao**
- O resultado atende suas expectativas?
- E isso que voce tinha em mente?

**Alinhamento**
- Representa bem seu negocio/marca?
- Voce usaria isso?

**Decisoes Finais**
- Algo precisa ser ajustado?
- Pode seguir em frente?

### Exemplo de gates nivel 3:

```yaml
nivel_3_humano:
  - verificacao: "O resultado atende suas expectativas?"
  - verificacao: "Algo precisa ser diferente?"
  - verificacao: "Posso salvar e continuar?"
```

### Opcoes para voce:

- **Aprovar:** Salva resultado e continua
- **Pedir ajustes:** Indica o que mudar
- **Refazer:** Comeca do zero com novas orientacoes

---

## Fluxo de Validacao

```
[Tarefa Concluida]
        |
        v
+------------------+
| NIVEL 1          |
| (Automatico)     |
+------------------+
        |
   Passou? ---Nao--> [Corrige automaticamente ou alerta]
        |
       Sim
        |
        v
+------------------+
| NIVEL 2          |
| (Agente Revisor) |
+------------------+
        |
   Aprovado? ---Nao--> [Mostra sugestoes de ajuste]
        |
       Sim
        |
        v
+------------------+
| NIVEL 3          |
| (Voce decide)    |
+------------------+
        |
   Satisfeito? ---Nao--> [Ajusta conforme pedido]
        |
       Sim
        |
        v
[Resultado Salvo]
```

---

## Gates Padrao por Tipo de Tarefa

### Criacao de Copy (Headlines, Emails)

```yaml
gates:
  nivel_1_automatico:
    - "Tamanho adequado ao formato?"
    - "Nao tem erros de portugues obvios?"
  nivel_2_agente:
    - "Usa gatilhos mentais eficazes?" (copywriter)
    - "Tom de voz consistente com marca?" (estrategista)
  nivel_3_humano:
    - "A mensagem representa bem seu negocio?"
    - "Voce enviaria isso para seus clientes?"
```

### Criacao Visual (Logo, Paleta)

```yaml
gates:
  nivel_1_automatico:
    - "Especificacoes tecnicas corretas?"
    - "Todos os formatos gerados?"
  nivel_2_agente:
    - "Segue principios de design?" (designer)
    - "Comunica valores da marca?" (estrategista)
  nivel_3_humano:
    - "Visualmente agradavel para voce?"
    - "Representa a essencia do seu negocio?"
```

### Estrategia (Posicionamento, ICP)

```yaml
gates:
  nivel_1_automatico:
    - "Todas as secoes preenchidas?"
    - "Dados e fontes referenciados?"
  nivel_2_agente:
    - "Estrategia e coerente internamente?" (estrategista)
    - "Publico bem definido?" (copywriter)
  nivel_3_humano:
    - "Faz sentido para seu negocio?"
    - "Voce concorda com as conclusoes?"
```

---

## Configurando Gates Customizados

Voce pode definir gates especificos para seu contexto:

```yaml
# No arquivo de tarefa ou workflow
gates:
  nivel_1_automatico:
    - verificacao: "Sua verificacao customizada"
      tipo: "formato|completude|regra"

  nivel_2_agente:
    - verificacao: "Sua verificacao customizada"
      agente_revisor: "qual-agente"

  nivel_3_humano:
    - verificacao: "Sua pergunta para o usuario"
```

---

## Auto-Calibracao (v5)

Os Quality Gates agora **aprendem com seus ajustes**. Se voce pede o mesmo tipo de correcao 3 ou mais vezes, o sistema detecta o padrao e sugere criar um novo gate automatico.

### Como Funciona

1. **Tracking:** Cada ajuste pedido e registrado em `core/qualidade/tracking.yaml`
2. **Deteccao:** O sistema identifica padroes recorrentes (mesmo ajuste, mesmo tipo de tarefa, 3+ vezes)
3. **Sugestao:** O sistema informa o padrao e sugere criar um gate automatico
4. **Aprovacao:** Voce decide se quer ativar o novo gate
5. **Aplicacao:** Proximas entregas passam pelo novo gate automaticamente

### Exemplo Pratico

```
Sessao 1: "Cria headline" → voce pede "mais informal"
Sessao 3: "Cria headline" → voce pede "tom mais leve"
Sessao 5: "Cria headline" → voce pede "menos formal"

Sistema detecta: "Tom informal pedido 3x em headlines"
Sistema sugere: "Quer que eu adicione verificacao de tom informal
                 para todas as headlines? Assim ja virao informais."

Voce: "Sim"

Proximas headlines passam por gate automatico de tom informal.
```

### Metricas

| Metrica | Descricao | Alvo |
|---------|-----------|------|
| Taxa de aprovacao | Entregas aprovadas sem ajustes | 90%+ |
| Taxa por tipo | Aprovacao por tipo de tarefa | 85%+ |
| Gates auto-criados | Novos gates criados por feedback | Crescente |
| Eficacia de gates | % de ajustes evitados pelo gate | 80%+ |

### Arquivos

| Arquivo | Funcao |
|---------|--------|
| `core/qualidade/auto-calibracao.yaml` | Configuracao e regras de aprendizado |
| `core/qualidade/tracking.yaml` | Metricas e historico de ajustes |

Ver detalhes: `core/qualidade/auto-calibracao.yaml`

---

## Boas Praticas

1. **Nivel 1 deve ser rapido** - Verificacoes objetivas, sem ambiguidade
2. **Nivel 2 agrega valor** - Nao repita o que nivel 1 ja faz
3. **Nivel 3 e sobre satisfacao** - Nao pergunte coisas tecnicas ao usuario
4. **Nem toda tarefa precisa de todos os niveis** - Use o bom senso
5. **Documente falhas** - Quando um gate falha, registre para melhorar
6. **Confie na auto-calibracao** - Ela melhora o sistema com o tempo

---

## Comandos

| Comando | Acao |
|---------|------|
| `/validar` | Executa gates da tarefa atual |
| `/gates` | Ver gates configurados |
| `/pular-gate` | Pula um gate especifico (use com cuidado) |
| `/calibracao` | Ver metricas de auto-calibracao |
| `/calibracao padroes` | Ver padroes detectados pendentes |
