# Plano de Modularização - Ralph Framework

## Problema

O `frameworks/ralph/templates/` contém arquivos específicos de domínio que violam o princípio de modularidade do Sleep Agent.

## Princípio Arquitetural

> **Se é específico → extensões/**
> **Se é genérico → frameworks/**
> **Se genérico precisa de info específica → genérico direciona para extensões**

---

## Arquivos a Reorganizar

### Grupo 1: Específicos de Educação/Cursos
**Origem:** `frameworks/ralph/templates/`
- `prompt-curso.md`
- `prd-curso.json`

**Destino:** `extensoes/educacao/ralph/templates/`

---

### Grupo 2: Específicos de Marketing/Vendas
**Origem:** `frameworks/ralph/templates/`
- `prompt-pagina-vendas.md`
- `prd-pagina-vendas.json`

**Destino:** `extensoes/marketing/ralph/templates/`

---

### Grupo 3: Específicos de Resumo de Livros
**Origem:** `frameworks/ralph/templates/`
- `prompt-booksummary.md`
- `prompt-booksummary-story.md`
- `prd-booksummary.json`
- `prd-booksummary-8story.json`
- `progress-booksummary.txt`

**Destino:** `extensoes/resumo-livros/ralph/templates/`

---

### Grupo 4: Específicos de Extensões (Meta)
**Origem:** `frameworks/ralph/templates/`
- `prompt-extensao.md`
- `prd-extensao.json`

**Destino:** `extensoes/criador-extensoes/ralph/templates/`

---

## Arquivos Genéricos (Permanecem em frameworks/ralph/templates/)

✅ **Manter:**
- `prompt.md` - Prompt genérico do Ralph
- `prompt-content.md` - Prompt genérico para content mode
- `prd.json` - Template base genérico
- `prd-content.json` - Template content mode genérico
- `prd-template.md` - Template markdown genérico
- `tasks-template.md` - Template de tasks genérico
- `progress.txt` - Progress log genérico
- `handoff-template.md` - Handoff genérico
- `examples-section-template.md` - Template de exemplos genérico
- `prd-migrate-v2.md` - Migração genérica

✅ **Avaliar prompts de refactoring:**
- `prompt-refactor.md`
- `prompt-refactor-examples.md`
- `prompt-add-examples.md`

Se são genéricos (refatoração de qualquer código) → **manter**
Se são específicos de algum domínio → **mover**

---

## Sistema de Descoberta Dinâmica

O Ralph genérico deve ser capaz de descobrir templates específicos das extensões:

### 1. Ralph Genérico (frameworks/ralph/)

```yaml
# frameworks/ralph/config.yaml
template_discovery:
  enabled: true
  search_paths:
    - "extensoes/*/ralph/templates/"
    - "extensoes/*/templates/ralph/"
```

### 2. Template Loader

```markdown
# frameworks/ralph/tasks/load-template.md
# Task: Load Ralph Template

## Input
- template_type (ex: "curso", "pagina-vendas", "booksummary")

## Process
1. Verificar em frameworks/ralph/templates/{template_type}
2. Se não encontrar, buscar em extensoes/*/ralph/templates/{template_type}
3. Retornar path do template encontrado

## Output
- template_path
```

### 3. Extensões Auto-Registram Templates

```yaml
# extensoes/educacao/extensao.yaml
nome: educacao
ralph_templates:
  - tipo: curso
    prompt: ralph/templates/prompt-curso.md
    prd: ralph/templates/prd-curso.json
```

---

## Estrutura Pós-Reorganização

```
sleep-agent/
├── frameworks/
│   └── ralph/
│       ├── templates/
│       │   ├── prompt.md                    # ✅ GENÉRICO
│       │   ├── prompt-content.md            # ✅ GENÉRICO
│       │   ├── prd.json                     # ✅ GENÉRICO
│       │   ├── prd-content.json             # ✅ GENÉRICO
│       │   ├── progress.txt                 # ✅ GENÉRICO
│       │   └── handoff-template.md          # ✅ GENÉRICO
│       └── tasks/
│           └── load-template.md             # ✅ Descoberta dinâmica
│
└── extensoes/
    ├── educacao/
    │   ├── extensao.yaml                    # Define ralph_templates
    │   └── ralph/
    │       └── templates/
    │           ├── prompt-curso.md          # ⚡ ESPECÍFICO
    │           └── prd-curso.json           # ⚡ ESPECÍFICO
    │
    ├── marketing/
    │   └── ralph/
    │       └── templates/
    │           ├── prompt-pagina-vendas.md  # ⚡ ESPECÍFICO
    │           └── prd-pagina-vendas.json   # ⚡ ESPECÍFICO
    │
    ├── resumo-livros/
    │   └── ralph/
    │       └── templates/
    │           ├── prompt-booksummary.md    # ⚡ ESPECÍFICO
    │           └── prd-booksummary.json     # ⚡ ESPECÍFICO
    │
    └── criador-extensoes/
        └── ralph/
            └── templates/
                ├── prompt-extensao.md       # ⚡ ESPECÍFICO
                └── prd-extensao.json        # ⚡ ESPECÍFICO
```

---

## Benefícios

1. **Separação clara** - Ralph é genérico, conhecimento específico fica em extensões
2. **Modularidade** - Extensões podem ser adicionadas/removidas sem afetar Ralph
3. **Descoberta dinâmica** - Ralph descobre templates específicos automaticamente
4. **Reutilização** - Ralph pode ser usado em qualquer extensão
5. **Manutenibilidade** - Mudanças em domínios não afetam o core

---

## Passos de Implementação

### Fase 1: Criar Estrutura de Extensões
```bash
mkdir -p extensoes/educacao/ralph/templates
mkdir -p extensoes/marketing/ralph/templates
mkdir -p extensoes/resumo-livros/ralph/templates
mkdir -p extensoes/criador-extensoes/ralph/templates
```

### Fase 2: Mover Arquivos Específicos
```bash
# Educação
mv frameworks/ralph/templates/prompt-curso.md extensoes/educacao/ralph/templates/
mv frameworks/ralph/templates/prd-curso.json extensoes/educacao/ralph/templates/

# Marketing
mv frameworks/ralph/templates/prompt-pagina-vendas.md extensoes/marketing/ralph/templates/
mv frameworks/ralph/templates/prd-pagina-vendas.json extensoes/marketing/ralph/templates/

# Resumo de Livros
mv frameworks/ralph/templates/prompt-booksummary* extensoes/resumo-livros/ralph/templates/
mv frameworks/ralph/templates/prd-booksummary* extensoes/resumo-livros/ralph/templates/
mv frameworks/ralph/templates/progress-booksummary.txt extensoes/resumo-livros/ralph/templates/

# Criador de Extensões
mv frameworks/ralph/templates/prompt-extensao.md extensoes/criador-extensoes/ralph/templates/
mv frameworks/ralph/templates/prd-extensao.json extensoes/criador-extensoes/ralph/templates/
```

### Fase 3: Atualizar Configs
- Criar/atualizar `extensoes/*/extensao.yaml` para registrar templates Ralph
- Criar `frameworks/ralph/config.yaml` com sistema de descoberta

### Fase 4: Implementar Template Loader
- Criar task `frameworks/ralph/tasks/load-template.md`
- Atualizar scripts Ralph para usar descoberta dinâmica

### Fase 5: Testar
- Verificar que Ralph genérico ainda funciona
- Verificar que templates específicos são encontrados
- Testar com cada extensão

---

## Notas

- Manter `frameworks/ralph/templates/` apenas com templates genéricos
- Extensões podem ter seus próprios templates Ralph customizados
- Sistema de descoberta permite extensibilidade infinita
- Ralph permanece agnóstico de domínio
