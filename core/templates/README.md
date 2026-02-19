# Templates do Sleep Agent

Esta pasta contem os templates base usados pelo sistema.

---

## Templates Disponiveis

### tarefa.yaml

Template basico para criar tarefas simples.

**Use quando:**
- Tarefa e direta e bem definida
- Nao precisa de muito contexto
- Execucao rapida (1-3 passos)

**Estrutura:**
- Identificacao
- Entradas
- Passos
- Saida
- Gates simples

---

### contexto-completo.yaml

Template rico para tarefas complexas que precisam de contexto detalhado.

**Use quando:**
- Tarefa e complexa ou ambigua
- Precisa de muito contexto para executar bem
- Multiplos passos com verificacoes
- Precisa integrar com sistema de memoria

**Estrutura:**
- Identificacao
- Contexto completo (objetivo, decisoes, restricoes, background)
- Entradas com validacao
- Passos com autocritica (verificacao em cada passo)
- Progresso rastreavel
- Memoria relevante (insights, alertas, padroes)
- Quality Gates em 3 niveis
- Captura de aprendizados

**Diferenciais:**
- Cada passo tem ponto de verificacao
- Integra com sistema de memoria
- Gates em 3 niveis (automatico, agente, humano)
- Captura novos aprendizados ao final

---

### progresso.md

Template para rastrear progresso de tarefas ou projetos.

---

## Quando usar cada template

| Cenario | Template Recomendado |
|---------|---------------------|
| Criar headline simples | tarefa.yaml |
| Criar identidade visual completa | contexto-completo.yaml |
| Responder pergunta rapida | Nenhum (resposta direta) |
| Desenvolver oferta completa | contexto-completo.yaml |
| Analisar referencia visual | tarefa.yaml |
| Criar campanha multi-canal | contexto-completo.yaml |

---

## Como criar uma nova tarefa

1. Copie o template apropriado
2. Preencha os campos com sua tarefa
3. Salve na pasta `tarefas/` da extensao correspondente
4. Adicione a referencia no `extensao.yaml`

---

## Validacao

Antes de usar um template preenchido, verifique:

- [ ] Todos os campos obrigatorios preenchidos
- [ ] Passos sao claros e executaveis
- [ ] Gates sao verificaveis
- [ ] Conhecimento referenciado existe
