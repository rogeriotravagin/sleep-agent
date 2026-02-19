# Asset Engine - Reuso Inteligente de Ativos

O Asset Engine analisa entregas anteriores antes de criar algo novo. Em vez de criar tudo do zero, o sistema decide: REUSAR, ADAPTAR ou CRIAR.

---

## Por que Reuso Inteligente?

No v4, toda tarefa comecava do zero. Se o usuario ja tinha 5 headlines aprovadas, o agente nao consultava nenhuma. Resultado: inconsistencia, tempo perdido, e o agente nao "aprendia" o estilo do usuario.

O Asset Engine resolve isso:

- **Consistencia:** Entregas novas seguem o padrao das anteriores
- **Velocidade:** Reusar ou adaptar e mais rapido que criar
- **Aprendizado:** O sistema "lembra" o que o usuario gostou
- **Economia:** Menos iteracoes ate aprovacao

---

## A Decisao: REUSAR / ADAPTAR / CRIAR

| Decisao | Score | O que acontece | Exemplo |
|---------|-------|----------------|---------|
| **REUSAR** | >= 90% | Usa direto, sem mudanca | Paleta de cores ja definida |
| **ADAPTAR** | 60-89% | Usa como base, modifica | Headline de produto A para produto B |
| **CRIAR** | < 60% | Cria do zero | Primeiro email da marca |

---

## Como o Score e Calculado

5 fatores com pesos diferentes:

| Fator | Peso | O que avalia |
|-------|------|--------------|
| Tipo | 40% | Mesmo tipo de ativo? (headline vs headline) |
| Marca | 20% | Mesma marca ou produto? |
| Publico | 20% | Mesmo publico-alvo? |
| Tempo | 10% | Quao recente? |
| Aprovacao | 10% | Foi aprovado pelo usuario? |

**Formula:**
```
score = (tipo * 0.4) + (marca * 0.2) + (publico * 0.2) + (tempo * 0.1) + (aprovacao * 0.1)
```

---

## Ciclo de Vida dos Ativos

```
Entrega criada
    ↓
Gate nivel 3 (usuario aprova)
    ↓
Ativo indexado no inventario ──────────────────────┐
    ↓                                               │
Reusado/Adaptado em novas tarefas                  │
    ↓                                               │
Reusado 3+ vezes? ──SIM──→ Promovido a template   │
    ↓ NAO                                           │
60 dias sem uso E nunca reusado?                   │
    ↓ SIM                                           │
Depreciado (excluido de buscas)  ←─────────────────┘
```

### Criacao
Todo output aprovado pelo usuario (gate nivel 3) e automaticamente indexado no inventario. Tags sao extraidas do conteudo.

### Promocao
Ativos reusados 3+ vezes viram **templates oficiais** com variaveis parametrizaveis, salvos em `extensoes/{ext}/templates/`.

### Depreciacao
Ativos nao usados em 60 dias e nunca reusados sao marcados como deprecated. Nao aparecem mais em buscas, mas nao sao deletados.

---

## Exemplo Pratico

```
Usuario: "Cria uma headline para o novo curso do Tiago"

[Asset Engine verifica inventario]
→ Encontra 3 headlines anteriores para "tiago-rocha":
  1. "A palestra que destrava equipes..." (score: 0.75 → ADAPTAR)
  2. "Sua equipe precisa de mais que motivacao" (score: 0.72 → ADAPTAR)
  3. "Empresario que ensina o que vive" (score: 0.65 → ADAPTAR)

[Agente recebe contexto extra]
→ "Existem 3 headlines anteriores aprovadas para este cliente.
    Usar como referencia de tom e estilo, adaptar para novo contexto."

[Resultado]
→ Headline nova E consistente com o padrao aprovado pelo usuario
```

---

## Inventario de Ativos

Armazenado em `workspace/.state/asset-index.yaml`:

```yaml
ativos:
  - id: "asset_001"
    tipo: "headline"
    subtipo: "headline-principal"
    conteudo_resumo: "A palestra que destrava equipes..."
    marca: "tiago-rocha"
    publico: "empresas"
    criado_em: "2026-02-19"
    aprovado: true
    vezes_reusado: 2
    vezes_adaptado: 1
    tags: ["palestra", "corporativo", "lideranca"]
```

---

## Integracao com o Sistema

### Com o Event Bus
- Escuta `gate.passou (nivel 3)` para indexar novos ativos
- Emite `ativo.indexado`, `ativo.reusado`, `ativo.promovido`

### Com o Blackboard
- Resultados da busca ficam em `blackboard.ativos_relevantes`
- Agentes consultam automaticamente antes de criar

### Com o Context Manager
- Ativos relevantes carregados como nivel 3 (sob demanda)
- Nao ocupa contexto ate ser necessario

### Com a Memoria
- Insights sobre reuso alimentam memoria semantica
- Ex: "Para este cliente, headlines com numeros funcionam"

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `kernel/asset-engine/ASSET-ENGINE.md` | Este documento |
| `kernel/asset-engine/decision.yaml` | Engine de decisao e scoring |
| `workspace/.state/asset-index.yaml` | Inventario de ativos |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/ativos` | Ver inventario de ativos |
| `/ativos buscar {tipo}` | Buscar ativos por tipo |
| `/ativos stats` | Estatisticas de reuso |
