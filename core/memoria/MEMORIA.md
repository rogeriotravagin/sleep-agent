# Sistema de Memoria do Sleep Agent v5

O Sleep Agent possui um sistema de memoria **hierarquico em 3 camadas** que persiste informacoes importantes entre sessoes, permitindo que o assistente "lembre" de decisoes, padroes e aprendizados anteriores.

---

## Por que Memoria Hierarquica?

Imagine um assistente que lembra de tudo, mas nao sabe o que e mais importante. Acaba confuso com informacao demais. O sistema hierarquico resolve isso:

- **Camada 1 (Trabalho):** O que esta acontecendo AGORA (volatil)
- **Camada 2 (Episodica):** O que aconteceu RECENTEMENTE (decai com o tempo)
- **Camada 3 (Semantica):** O que e PERMANENTE (regras, padroes, decisoes)

---

## Onde fica a Memoria?

```
workspace/.memoria/
├── trabalho.yaml           # Camada 1: Sessao atual (volatil)
├── episodica/              # Camada 2: Ultimas semanas
│   ├── 2026-02-19.yaml     #   Cada dia tem seu arquivo
│   └── ...
├── semantica/              # Camada 3: Permanente
│   ├── marca.yaml          #   Tudo sobre a marca
│   ├── publico.yaml        #   Tudo sobre o publico
│   ├── processo.yaml       #   Como o usuario gosta de trabalhar
│   ├── tecnico.yaml        #   Padroes tecnicos
│   └── alertas.yaml        #   Armadilhas permanentes
└── _legado/                # Backup dos arquivos v4
```

---

## Camada 1: Memoria de Trabalho

**Duracao:** Apenas a sessao atual
**Arquivo:** `workspace/.memoria/trabalho.yaml`
**Capacidade:** ~50 itens

Armazena o contexto imediato da conversa:

```yaml
itens:
  - timestamp: "2026-02-19T10:30:00"
    tipo: "decisao"
    conteudo: "Headline vai usar tom direto com numeros"
    fonte: "copywriter"
    relevancia: "alta"
    promover: true   # Sera salvo na episodica ao encerrar
```

**Ao encerrar a sessao:**
- Itens marcados com `promover: true` vao para episodica
- O resto e descartado
- Decisoes importantes vao direto para semantica

---

## Camada 2: Memoria Episodica

**Duracao:** 30 dias (com decaimento)
**Diretorio:** `workspace/.memoria/episodica/`
**Um arquivo por dia:** `YYYY-MM-DD.yaml`

Armazena eventos recentes com contexto:

```yaml
data: "2026-02-19"
sessoes: 2
itens:
  - timestamp: "2026-02-19T10:30:00"
    tipo: "insight"
    conteudo: "Headlines com numeros concretos funcionam melhor para este cliente"
    fonte: "copywriter"
    categoria: "publico"
    acessos: 1
```

**Regras de decaimento:**
- Itens acessados 3+ vezes → **Promovidos para semantica**
- Itens nunca acessados apos 30 dias → **Removidos**

---

## Camada 3: Memoria Semantica

**Duracao:** Permanente
**Diretorio:** `workspace/.memoria/semantica/`
**Organizada por categoria**

```yaml
itens:
  - conteudo: "Tom de voz: direto, conversacional, sem jargoes"
    definido_em: "2026-02-19"
    definido_por: "estrategista"
    acessos: 12
    ultima_consulta: "2026-02-19"
```

**Categorias:**

| Categoria | Arquivo | O que guarda |
|-----------|---------|-------------|
| Marca | `marca.yaml` | Identidade, valores, visual, tom de voz |
| Publico | `publico.yaml` | ICP, personas, comportamentos |
| Processo | `processo.yaml` | Como o usuario gosta de trabalhar |
| Tecnico | `tecnico.yaml` | Padroes de formato, APIs, restricoes |
| Alertas | `alertas.yaml` | Armadilhas permanentes a evitar |

---

## Como o Sleep Agent usa a Memoria

### Ao Iniciar uma Tarefa

1. **Carregar trabalho.yaml** - contexto da sessao atual
2. **Buscar semantica relevante** - por categoria da tarefa
3. **Buscar episodica recente** - tarefas similares dos ultimos 7 dias
4. **Verificar alertas** - armadilhas a evitar
5. **Montar contexto** combinando as 3 camadas

### Durante a Tarefa

6. **Registrar no trabalho.yaml** - decisoes e insights
7. **Consultar semantica** quando precisar de regras

### Ao Finalizar uma Tarefa

8. **Atualizar trabalho.yaml** - marcar itens para promocao
9. **Se decisao importante** → registrar em semantica
10. **Se armadilha nova** → registrar em semantica/alertas

### Ao Encerrar a Sessao

11. **Itens promovidos** de trabalho → episodica do dia
12. **Limpar trabalho.yaml** para proxima sessao

---

## Busca por Relevancia

| Fator | Peso | O que mede |
|-------|------|-----------|
| Recencia | 30% | Quanto mais recente, mais relevante |
| Frequencia | 20% | Quanto mais acessado, mais relevante |
| Categoria | 30% | Match de categoria com tarefa atual |
| Importancia | 20% | O usuario marcou como importante? |

Itens com score abaixo de 40% nao sao incluidos no contexto.

---

## Integracao com Blackboard

| | Memoria | Blackboard |
|---|---------|-----------|
| **Escopo** | Entre sessoes | Dentro da sessao |
| **Duracao** | Permanente/decai | Sessao atual |
| **Conteudo** | Aprendizados e regras | Estado operacional |
| **Quem usa** | Consulta no inicio | Consulta a todo momento |

---

## Comandos de Memoria

| Comando | O que faz |
|---------|-----------|
| `/memoria` | Ver resumo das 3 camadas |
| `/memoria trabalho` | Ver contexto da sessao atual |
| `/memoria episodica` | Ver aprendizados recentes |
| `/memoria semantica` | Ver conhecimento permanente |
| `/memoria adicionar` | Adicionar item manualmente |
| `/memoria promover` | Promover item para camada superior |
| `/memoria limpar trabalho` | Limpar sessao atual |

---

## Privacidade

A memoria fica **apenas no seu computador**, na pasta do workspace. Nada e enviado para servidores externos.

---

## Migracao v4 → v5

Arquivos v4 preservados em `workspace/.memoria/_legado/`.
Ver detalhes em `workspace/.memoria/_legado/MIGRACAO.md`
