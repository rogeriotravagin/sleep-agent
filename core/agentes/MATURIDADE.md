# Sistema de Maturidade de Agentes

O Sleep Agent usa um sistema de niveis para medir a completude e qualidade de cada agente. Isso ajuda a identificar quais agentes estao prontos para uso e quais precisam de melhorias.

---

## Por que Niveis de Maturidade?

Nem todo agente esta igualmente preparado. Alguns tem:
- Persona bem definida
- Processo claro
- Tarefas prontas
- Base de conhecimento rica
- Templates e exemplos

Outros podem estar em desenvolvimento ou ter apenas o basico.

**Os niveis ajudam a:**
- Saber o que esperar de cada agente
- Identificar onde investir melhorias
- Garantir qualidade minima antes de usar

---

## 3 Niveis de Maturidade

### Nivel 1: Basico

O agente funciona, mas com capacidades limitadas.

**O que tem:**
- Persona definida (quem e, como fala)
- Processo basico de trabalho

**O que falta:**
- Tarefas estruturadas
- Base de conhecimento
- Templates
- Exemplos

**Quando usar:**
- Tarefas simples e diretas
- Quando nao precisa de muita especializacao
- Para experimentar o agente

**Indicador visual:** `[*--]`

---

### Nivel 2: Intermediario

O agente esta funcional e util para a maioria dos casos.

**O que tem:**
- Tudo do Nivel 1
- Tarefas estruturadas (pelo menos 3)
- Base de conhecimento basica
- Pelo menos 1 workflow

**O que pode faltar:**
- Templates completos
- Exemplos detalhados
- Gates de qualidade especificos

**Quando usar:**
- Maioria das situacoes
- Tarefas do dia-a-dia
- Quando precisa de resultado estruturado

**Indicador visual:** `[**-]`

---

### Nivel 3: Completo

O agente esta totalmente equipado e pronto para qualquer situacao.

**O que tem:**
- Tudo do Nivel 2
- Templates para cada tarefa
- Exemplos detalhados
- Gates de qualidade especificos
- Documentacao completa
- Integracao com sistema de memoria

**Quando usar:**
- Tarefas criticas
- Quando precisa de maximo controle
- Para resultados profissionais

**Indicador visual:** `[***]`

---

## Checklist de Maturidade

### Nivel 1 (Basico)

```
[ ] Arquivo de agente existe (agentes/NOME.md)
[ ] Persona definida (quem e, especialidade)
[ ] Processo de trabalho descrito
[ ] Tom de voz definido
```

### Nivel 2 (Intermediario)

```
Tudo do Nivel 1, mais:
[ ] Pelo menos 3 tarefas em tarefas/
[ ] Arquivos de conhecimento em conhecimento/
[ ] Pelo menos 1 workflow em workflows/
[ ] Referencias bibliograficas
```

### Nivel 3 (Completo)

```
Tudo do Nivel 2, mais:
[ ] Template para cada tarefa
[ ] Exemplos de uso documentados
[ ] Gates de qualidade especificos
[ ] Integracao com memoria (captura insights)
[ ] Documentacao completa
```

---

## Como Ver Maturidade

### Comando

```
/maturidade
```

### Saida Exemplo

```
Maturidade dos Agentes
======================

Marketing:
  [***] Copywriter - Completo
  [**-] Estrategista - Intermediario
  [**-] Trafego - Intermediario

Branding:
  [***] Designer - Completo
  [**-] UI/UX - Intermediario
  [**-] Brand Strategist - Intermediario
  [*--] Design Analyst - Basico

Customer Success:
  [**-] CSM - Intermediario
  [*--] Onboarding - Basico
```

---

## Como Evoluir um Agente

### De Nivel 1 para Nivel 2

1. Criar pelo menos 3 tarefas estruturadas
2. Adicionar arquivos de conhecimento
3. Criar pelo menos 1 workflow

### De Nivel 2 para Nivel 3

1. Criar template para cada tarefa
2. Documentar exemplos de uso
3. Definir gates de qualidade especificos
4. Configurar captura de insights
5. Completar documentacao

---

## Formato no extensao.yaml

```yaml
agentes:
  - nome: copywriter
    arquivo: agentes/COPYWRITER.md
    maturidade: 3  # 1, 2 ou 3
    checklist:
      persona: true
      processo: true
      tarefas: true
      conhecimento: true
      workflows: true
      templates: true
      exemplos: true
      gates: true
      memoria: true
      documentacao: true

  - nome: trafego
    arquivo: agentes/TRAFEGO.md
    maturidade: 2
    checklist:
      persona: true
      processo: true
      tarefas: true
      conhecimento: true
      workflows: true
      templates: false
      exemplos: false
      gates: false
      memoria: false
      documentacao: false
```

---

## Quando Usar Cada Nivel

| Situacao | Nivel Minimo Recomendado |
|----------|-------------------------|
| Teste rapido | 1 |
| Uso casual | 1 |
| Tarefa simples | 1 |
| Tarefa do dia-a-dia | 2 |
| Resultado estruturado | 2 |
| Tarefa critica | 3 |
| Cliente importante | 3 |
| Entrega profissional | 3 |

---

## Alertas de Maturidade

O Sleep Agent pode alertar quando:

- Voce tenta usar agente nivel 1 para tarefa complexa
- Agente nao tem conhecimento necessario
- Tarefa requer template que nao existe

**Exemplo:**
```
[Aviso] O agente Trafego esta em nivel 2 (Intermediario).
        Para criar campanha completa, recomendo usar workflow
        que combina Estrategista + Copywriter + Trafego.

        Deseja continuar assim mesmo? (sim/nao)
```

---

## Beneficios do Sistema

1. **Transparencia** - Sabe o que esperar de cada agente
2. **Qualidade** - Agentes nivel 3 garantem melhor resultado
3. **Evolucao** - Identifica onde melhorar
4. **Confianca** - Usa agentes apropriados para cada tarefa
