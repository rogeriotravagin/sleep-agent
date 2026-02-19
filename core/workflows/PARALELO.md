# Workflows Paralelos

O Sleep Agent suporta execucao paralela de tarefas independentes, aumentando a eficiencia quando varias coisas podem ser feitas ao mesmo tempo.

---

## O que sao Workflows Paralelos?

Em um workflow normal, tarefas sao executadas uma apos a outra:

```
Tarefa A → Tarefa B → Tarefa C → Fim
```

Em um workflow paralelo, tarefas independentes rodam ao mesmo tempo:

```
        ┌→ Tarefa B ─┐
Tarefa A│            │→ Tarefa D → Fim
        └→ Tarefa C ─┘
```

**Beneficio:** Menos tempo total de execucao.

---

## Quando Usar

Use execucao paralela quando:
- Tarefas NAO dependem uma da outra
- Cada tarefa gera um arquivo separado
- Ordem de conclusao nao importa

**Exemplos bons para paralelo:**
- Criar varias versoes de headline
- Gerar emails para diferentes segmentos
- Criar variantes de anuncios
- Desenvolver paleta de cores + tipografia

**NAO use paralelo quando:**
- Uma tarefa precisa do resultado da outra
- A ordem e importante
- Tarefas compartilham o mesmo arquivo

---

## Como Definir no Workflow

### Sintaxe

```yaml
fases:
  - numero: 1
    nome: DESCOBERTA
    paralelo: false  # Sequencial - faz primeiro
    tarefas:
      - pesquisar-mercado

  - numero: 2
    nome: CRIACAO
    paralelo: true   # Paralelo - faz ao mesmo tempo
    fork:
      - tarefa: criar-headline
        agente: copywriter
      - tarefa: criar-subheadline
        agente: copywriter
      - tarefa: definir-bullets
        agente: copywriter
    join:
      estrategia: aguardar_todos  # Espera todas terminarem

  - numero: 3
    nome: MONTAGEM
    paralelo: false  # Sequencial - usa resultados anteriores
    tarefas:
      - montar-landing
```

---

## Estrategias de Join

Quando tarefas paralelas terminam, o que fazer?

### aguardar_todos (Padrao)

Espera TODAS as tarefas terminarem antes de continuar.

```yaml
join:
  estrategia: aguardar_todos
```

### primeiro_sucesso

Continua assim que UMA tarefa termina com sucesso (cancela as outras).

```yaml
join:
  estrategia: primeiro_sucesso
```

### coletar_resultados

Espera todas e combina os resultados em um unico arquivo.

```yaml
join:
  estrategia: coletar_resultados
  arquivo_destino: "resultados-combinados.md"
```

---

## Exemplo Completo: Criar Variantes de Copy

```yaml
id: criar-variantes-copy
nome: Criar Variantes de Copy
descricao: Gera multiplas versoes de copy para teste A/B

fases:
  - numero: 1
    nome: BRIEFING
    paralelo: false
    agente: estrategista
    tarefas:
      - definir-mensagem-chave
    entregas:
      - briefing-copy.md

  - numero: 2
    nome: CRIACAO_PARALELA
    paralelo: true
    fork:
      - id: variante-a
        tarefa: criar-headline
        agente: copywriter
        parametros:
          estilo: "direto"
          gatilho_principal: "urgencia"
        output: headline-variante-a.md

      - id: variante-b
        tarefa: criar-headline
        agente: copywriter
        parametros:
          estilo: "storytelling"
          gatilho_principal: "curiosidade"
        output: headline-variante-b.md

      - id: variante-c
        tarefa: criar-headline
        agente: copywriter
        parametros:
          estilo: "prova-social"
          gatilho_principal: "autoridade"
        output: headline-variante-c.md

    join:
      estrategia: coletar_resultados
      arquivo_destino: todas-variantes.md

  - numero: 3
    nome: SELECAO
    paralelo: false
    agente: estrategista
    tarefas:
      - avaliar-variantes
    gates:
      nivel_3_humano:
        - "Qual variante voce prefere?"
```

---

## Como Funciona Internamente

1. **Fork:** Sleep Agent identifica tarefas marcadas como paralelas
2. **Execucao:** Processa tarefas "ao mesmo tempo" (na pratica, alterna rapidamente)
3. **Monitoramento:** Acompanha progresso de cada tarefa
4. **Join:** Quando todas terminam, combina resultados conforme estrategia
5. **Continuacao:** Passa para proxima fase com todos os outputs disponiveis

---

## Limitacoes

- Maximo de 5 tarefas paralelas por fase (para manter qualidade)
- Todas as tarefas paralelas devem ter o mesmo agente ou agentes independentes
- Tarefas paralelas nao podem editar o mesmo arquivo

---

## Indicadores no Status

Durante execucao paralela, o `/status` mostra:

```
Tarefa Atual: Criacao Paralela (Fase 2)
  [OK] Variante A - headline-direto
  [..] Variante B - headline-storytelling (em andamento)
  [..] Variante C - headline-prova-social (em andamento)

Progresso: 1/3 tarefas paralelas concluidas
```

---

## Boas Praticas

1. **Limite o paralelo** - Nao paralelise tudo, so o que faz sentido
2. **Defina outputs claros** - Cada tarefa paralela deve ter seu arquivo
3. **Use join apropriado** - Escolha estrategia que faz sentido
4. **Teste sequencial primeiro** - Garanta que tarefas funcionam antes de paralelizar
5. **Monitore recursos** - Muitas tarefas paralelas podem sobrecarregar
