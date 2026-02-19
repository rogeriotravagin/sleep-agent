# Microlearning - Base de Conhecimento

## O que é Microlearning

Microlearning é uma abordagem de aprendizagem que entrega conteúdo em pequenas doses, focadas e facilmente consumíveis.

> "Menos é mais quando se trata de aprendizagem eficaz." — Will Thalheimer

## Características

| Aspecto | Microlearning | Aprendizagem Tradicional |
|---------|---------------|-------------------------|
| Duração | 3-7 minutos | 30-60 minutos |
| Foco | Um objetivo | Múltiplos objetivos |
| Formato | Variado, mobile-friendly | Predominantemente texto/vídeo longo |
| Acesso | On-demand, just-in-time | Agendado, sequencial |
| Retenção | Alta (foco + repetição) | Variável |

## Quando Usar Microlearning

### ✅ Ideal Para

- **Conceitos específicos:** Uma técnica, uma fórmula, um processo
- **Reforço:** Revisar conteúdo já aprendido
- **Just-in-time:** Resolver problema imediato
- **Mobile learning:** Aprender em movimento
- **Atualização:** Mudanças pequenas em processos
- **Soft skills:** Dicas práticas aplicáveis

### ❌ Não Ideal Para

- Conceitos complexos que precisam de contexto amplo
- Primeira exposição a assunto totalmente novo
- Desenvolvimento de habilidades complexas
- Certificações formais
- Conteúdo que requer prática supervisionada

## Formatos de Microlearning

### 1. Micro-Vídeo

```
Duração: 2-5 minutos
Estrutura:
- Hook (15 seg)
- Conceito (1-2 min)
- Exemplo (1-2 min)
- Resumo + CTA (30 seg)
```

**Quando usar:** Demonstrações, tutoriais, explicações visuais

---

### 2. Infográfico Interativo

```
Elementos:
- Título chamativo
- 3-5 blocos de informação
- Ícones/ilustrações
- Dados/estatísticas
- CTA final
```

**Quando usar:** Processos, comparações, estatísticas

---

### 3. Flashcards Digitais

```
Estrutura:
- Frente: Pergunta ou termo
- Verso: Resposta ou definição
- Opção de "Lembrei" / "Não lembrei"
```

**Quando usar:** Vocabulário, conceitos, revisão

---

### 4. Quiz Rápido

```
Formato:
- 5-10 questões
- Feedback imediato
- Explicação da resposta correta
- Pontuação e progresso
```

**Quando usar:** Verificação, reforço, gamificação

---

### 5. Podcast/Áudio

```
Duração: 3-10 minutos
Estrutura:
- Introdução do tema
- Conteúdo principal
- Resumo
- Ação sugerida
```

**Quando usar:** Conceitos, reflexões, commute learning

---

### 6. Checklist/Job Aid

```
Formato:
- Título da tarefa
- Passos numerados
- Checkboxes
- Dicas/alertas
```

**Quando usar:** Procedimentos, rotinas, suporte ao trabalho

---

### 7. Simulação Curta

```
Estrutura:
- Cenário breve
- Decisão do usuário
- Feedback imediato
- Consequência da escolha
```

**Quando usar:** Tomada de decisão, soft skills, atendimento

---

### 8. Card de Dica

```
Formato:
- Uma dica por card
- Visual atraente
- Facilmente compartilhável
- Série de cards = trilha
```

**Quando usar:** Dicas diárias, séries temáticas, engajamento

---

## Design de Microlearning

### Princípio 1: Um Objetivo

```
❌ "Nesta lição, você vai aprender sobre vendas,
    incluindo prospecção, qualificação e fechamento."

✅ "Nesta lição, você vai aprender 3 perguntas
    de qualificação que identificam clientes sérios."
```

### Princípio 2: Foco no Essencial

```
Perguntar:
- O que é ESSENCIAL para o objetivo?
- O que é IMPORTANTE mas pode ser material extra?
- O que é INTERESSANTE mas não necessário?

Incluir: Apenas o ESSENCIAL
```

### Princípio 3: Ação Imediata

```
Todo micro-conteúdo termina com:
"Agora, [ação específica que pode fazer imediatamente]"

Exemplos:
- "Agora, identifique um cliente e faça essas 3 perguntas."
- "Agora, abra seu projeto e aplique a fórmula."
- "Agora, escreva sua versão nos comentários."
```

### Princípio 4: Standalone

```
Cada micro-conteúdo deve funcionar sozinho.
Não depender de ter visto o anterior.
Ter contexto suficiente para entender.
```

---

## Estrutura de Micro-Aula

### Template Padrão (5 minutos)

```
[0:00-0:15] HOOK
Pergunta ou estatística que captura atenção

[0:15-0:30] OBJETIVO
"Você vai aprender [resultado específico]"

[0:30-2:00] CONCEITO
O que é e por que importa

[2:00-3:30] EXEMPLO
Aplicação prática demonstrada

[3:30-4:30] RESUMO
3 pontos principais (máximo)

[4:30-5:00] CTA
Ação específica e imediata
```

### Template de Quiz (3 minutos)

```
[Intro] "Vamos testar seu conhecimento sobre [tema]"

[Q1] Questão + 4 alternativas
[Feedback] Correto/Incorreto + explicação

[Q2] Questão + 4 alternativas
[Feedback] Correto/Incorreto + explicação

[Q3] Questão + 4 alternativas
[Feedback] Correto/Incorreto + explicação

[Resultado] Pontuação + o que revisar
```

### Template de Dica (1 minuto)

```
[Título] Dica [número]: [Resumo]

[Problema] Situação comum que a dica resolve

[Solução] A dica em si (1-2 frases)

[Exemplo] Como aplicar

[CTA] "Experimente hoje"
```

---

## Curva de Esquecimento e Espaçamento

### O Problema

```
Sem revisão:
Dia 1: 100% → Dia 2: 50% → Dia 7: 20% → Dia 30: ~5%
```

### A Solução: Repetição Espaçada

```
Com microlearning + espaçamento:
Dia 1: Conteúdo novo → 100%
Dia 2: Micro-revisão → 90%
Dia 7: Micro-revisão → 85%
Dia 14: Micro-revisão → 90%
Dia 30: Micro-revisão → 95%
```

### Implementação

```yaml
trilha_microlearning:
  dia_1:
    tipo: "conteudo_novo"
    duracao: 5 min
    formato: video

  dia_2:
    tipo: "reforco"
    duracao: 2 min
    formato: quiz

  dia_7:
    tipo: "pratica"
    duracao: 3 min
    formato: exercicio

  dia_14:
    tipo: "aplicacao"
    duracao: 5 min
    formato: cenario

  dia_30:
    tipo: "avaliacao"
    duracao: 5 min
    formato: projeto_mini
```

---

## Microlearning em Trilhas

### Estrutura de Trilha

```
TRILHA: [Tema Geral]
├── MÓDULO 1: [Subtema]
│   ├── Micro 1.1: Conceito básico (5 min)
│   ├── Micro 1.2: Exemplo prático (3 min)
│   ├── Micro 1.3: Quiz de fixação (2 min)
│   └── Micro 1.4: Desafio aplicado (5 min)
│
├── MÓDULO 2: [Subtema]
│   ├── Micro 2.1: ...
│   └── ...
│
└── PROJETO INTEGRADOR: (15-30 min)
    Aplica tudo que aprendeu
```

### Exemplo Prático

```
TRILHA: Técnicas de Persuasão

MÓDULO 1: Reciprocidade
├── 1.1: O que é reciprocidade (4 min - vídeo)
├── 1.2: 3 formas de aplicar (3 min - infográfico)
├── 1.3: Quiz: Identifique a técnica (2 min)
└── 1.4: Crie sua estratégia (5 min - exercício)

MÓDULO 2: Escassez
├── 2.1: Por que escassez funciona (4 min - vídeo)
├── 2.2: Escassez real vs artificial (3 min - comparativo)
├── 2.3: Quiz: Certo ou errado? (2 min)
└── 2.4: Aplique em seu produto (5 min - exercício)

PROJETO: Crie uma oferta usando 3 técnicas (20 min)
```

---

## Métricas de Microlearning

| Métrica | O que mede | Meta |
|---------|------------|------|
| Completion Rate | Conteúdos finalizados | > 80% |
| Average Session | Tempo por sessão | 5-10 min |
| Return Rate | Voltam para mais | > 60% |
| Quiz Scores | Aprendizado | > 70% |
| Application Rate | Aplicam no trabalho | > 40% |
| NPS | Satisfação | > 50 |

---

## Checklist de Microlearning

### Design
- [ ] Um objetivo claro
- [ ] Duração de 3-7 minutos
- [ ] Formato adequado ao conteúdo
- [ ] Mobile-friendly
- [ ] Standalone (funciona sozinho)

### Conteúdo
- [ ] Apenas o essencial incluído
- [ ] Exemplo prático presente
- [ ] Linguagem conversacional
- [ ] CTA específico no final

### Engajamento
- [ ] Hook nos primeiros segundos
- [ ] Visual atraente
- [ ] Interação incluída
- [ ] Feedback imediato

### Trilha
- [ ] Sequência lógica
- [ ] Repetição espaçada planejada
- [ ] Variedade de formatos
- [ ] Projeto integrador no final

---

## Ferramentas Recomendadas

### Criação
- Vídeo: Loom, Camtasia, ScreenFlow
- Infográficos: Canva, Piktochart
- Quiz: Google Forms, Typeform, Kahoot
- Flashcards: Anki, Quizlet

### Distribuição
- LMS: Moodle, Teachable, Thinkific
- Apps: Mobile-first platforms
- Email: Sequências automatizadas
- Chatbot: Micro-conteúdo via chat
