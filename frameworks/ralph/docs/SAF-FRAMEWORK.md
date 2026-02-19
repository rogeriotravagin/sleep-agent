# Sleep Agent Framework (SAF)

**Versão:** 1.0
**Data:** 2026-02-01
**Status:** Official

---

## O que é o SAF?

O **Sleep Agent Framework (SAF)** é o framework proprietário do Sleep Agent para desenvolvimento autônomo orientado a stories. Ele define um conjunto de princípios e práticas que garantem qualidade, rastreabilidade e aprendizado acumulativo em projetos executados por agentes de IA.

---

## Princípios Fundamentais

### 1. 📖 Story-Driven Development

**Conceito:** Todo o contexto necessário deve estar no PRD (Product Requirements Document).

**Práticas:**
- ✅ PRD contém **Dev Notes** completas
- ✅ Nenhuma documentação externa é necessária
- ✅ Padrões da codebase documentados no PRD
- ✅ Dependências especificadas claramente
- ✅ Acceptance criteria específicos e verificáveis

**Benefício:** O agente nunca precisa "adivinhar" ou buscar informações externas.

---

### 2. 🚪 Quality Gates

**Conceito:** Uma story só está completa quando TODOS os quality gates passam.

**Quality Gates Obrigatórios:**

#### Code Quality
- [ ] `typecheck` passa (0 erros)
- [ ] `lint` passa (0 warnings)
- [ ] Sem `console.log` no código
- [ ] Error handling implementado
- [ ] Segue padrões existentes

#### Testing
- [ ] Unit tests escritos
- [ ] Todos tests passando
- [ ] Edge cases cobertos
- [ ] Manual testing (para UI)

#### Documentation
- [ ] File List atualizado
- [ ] Learnings documentados
- [ ] AGENTS.md atualizado (se aplicável)

#### Integration
- [ ] Funciona com código existente
- [ ] Sem breaking changes
- [ ] Performance aceitável

**Benefício:** Zero código quebrado ou incompleto.

---

### 3. 📋 Strict Sections (Seções Autorizadas)

**Conceito:** O agente só pode editar seções específicas do PRD e progress log.

**Seções Autorizadas:**

| Arquivo | Pode Editar | NÃO Pode Editar |
|---------|-------------|-----------------|
| **prd.json** | `passes` (false→true), `notes` | User stories, acceptance criteria |
| **progress.txt** | Session Log, File List, Patterns | Metadata do projeto |
| **handoff.md** | OVERWRITE completo | N/A |

**Benefício:** Previne scope creep e mudanças não autorizadas.

---

### 4. 📝 Dev Agent Record (Registro de Auditoria)

**Conceito:** Toda mudança deve ser rastreável via audit trail.

**Componentes:**

#### File List (Lista Cumulativa)
```markdown
| File | Action | Story | Description |
|------|--------|-------|-------------|
| path/file.ts | Created | US-001 | [Purpose] |
| path/file.ts | Modified | US-002 | [What changed] |
```

#### Session Log (Histórico)
```markdown
---
## [Date] - [Story ID]: [Title]

**Status:** ✅ Complete
**Thread:** [URL]

### What was implemented
- [Description]

### Files Changed
| File | Action | Description |

### Learnings
- **Pattern:** [If discovered]
- **Gotcha:** [If encountered]
---
```

**Benefício:** Rastreabilidade completa e histórico auditável.

---

### 5. 🔗 Handoff System (Contexto entre Stories)

**Conceito:** Contexto crítico é transmitido entre stories via `handoff.md`.

**Estrutura do Handoff:**

```markdown
# Handoff Context

**Estado Atual:** US-XXX completada

## Context Mínimo
- Top 3-5 learnings críticos da story anterior
- Padrões descobertos
- Arquivos chave modificados

## Erros a Evitar
- Mistakes que ocorreram
- Gotchas encontrados

## Arquivos Tocados
- Lista de arquivos modificados

## Próxima Story
- ID e título da próxima story pendente
```

**Atualização:** OBRIGATÓRIA após cada story (é um quality gate!)

**Benefício:** Zero perda de contexto entre iterações.

---

### 6. 🧠 Patterns Compound (Aprendizado Acumulativo)

**Conceito:** Learnings são documentados no topo de `progress.txt` e lidos primeiro por futuras iterações.

**Seções de Patterns:**

```markdown
## Codebase Patterns
### Architecture Patterns
- Como X funciona neste projeto
- Quando modificar Y, também atualizar Z

### Common Gotchas
- Erro X ocorre se não fazer Y
- Solução: fazer Z antes de X

### Performance Considerations
- Padrão X é mais rápido que Y para caso Z
```

**Posição:** No **topo** de progress.txt (lido primeiro)

**Benefício:** Erros não se repetem, padrões se consolidam.

---

### 7. 🎭 Agent Delegation (Delegação de Agentes)

**Conceito:** Ralph (orchestrator) assume personas especializadas conforme o tipo de story.

**Mapeamento de Personas:**

| Story Type | Keywords | Persona |
|------------|----------|---------|
| Architecture/Design | "arquitetura", "design", "API design" | `@architect` (Winston) |
| Implementation/Code | "implementar", "criar", "código" | `@dev` (James) |
| Testing/QA | "testar", "validar", "QA" | `@qa` |
| UX/UI | "UI", "interface", "layout" | `@ux-expert` |
| Setup/Docs | "setup", "README", "documentar" | `@ralph` (self) |

**Protocolo:**
1. Analyze story keywords
2. Match to specialist persona
3. **Announce:** "🎭 Assuming @dev persona for US-XXX"
4. **Transform:** Adopt specialist mindset
5. **Execute:** Complete story AS specialist
6. **Return:** Back to Ralph orchestrator

**Benefício:** Expertise especializada sem overhead de múltiplos agentes reais.

---

## Arquitetura do PRD (SAF-Enhanced)

### Estrutura Completa

```markdown
# PRD: [Feature Name]

> **SAF Integration:** Story-Driven Development

## 1. Introduction/Overview
## 2. Goals
## 3. User Stories
## 4. Functional Requirements
## 5. Non-Goals
## 6. Design Considerations
## 7. Technical Considerations
## 8. Dev Notes ⭐ (SAF - TODO CONTEXTO AQUI)
## 9. Success Metrics
## 10. Open Questions
## 11. Quality Gates ⭐ (SAF - Definition of Done)
## 12. Dev Agent Record ⭐ (SAF - Audit Trail)
```

### Seção 8: Dev Notes (CRÍTICA)

**Objetivo:** Concentrar TODO contexto necessário.

**Deve conter:**
- Padrões da codebase relevantes
- Dependências e versões
- Exemplos de código similar
- Arquivos chave para referência
- Constraints técnicos
- Sugestões de implementação

**Regra de Ouro:** Se o dev precisar buscar externamente, as Dev Notes estão incompletas.

---

## Arquitetura do Progress Log

### Estrutura

```markdown
# Progress Log

> **SAF Integration:** Dev Agent Record principles

---

## Codebase Patterns ⭐ (Topo - lido primeiro)
### Architecture Patterns
### Common Gotchas

---

## Key Files Reference
| Path | Purpose | Importance |

---

## Session Log
### [Date] - [Story ID]: [Title]
...

---

## File List (Cumulative) ⭐ (Audit Trail)
| File | Action | Story | Description |

---

## Quality Gates Status
- [x] All gates passed for US-XXX
- [ ] Pending for US-YYY

---

## Completion Summary
Total Stories: X
Completed: Y
```

---

## Workflow SAF-Compliant

### Sequência de Execução (Ralph)

```
0. 📖 Read handoff.md (se existe)
   ↓
1. 📋 Read prd.json
   ↓
2. 🎯 Select next pending story
   ↓
3. 📝 Check Dev Notes (seção 8)
   ↓
4. 🎭 Assume appropriate persona
   ↓
5. 💻 Implement story
   ↓
6. ✅ Validate Quality Gates (ALL must pass)
   ↓
7. 📂 Update File List
   ↓
8. 📝 Commit changes (if gitEnabled)
   ↓
9. 📊 Update prd.json (passes: true)
   ↓
10. 📜 Log to Session Log
   ↓
11. 🔗 Update handoff.md (OBRIGATÓRIO)
   ↓
12. 🔄 Next story or COMPLETE
```

### Stop Condition

```xml
<promise>COMPLETE</promise>
```

Emitido quando **todas** stories têm `passes: true`.

---

## Story Sizing (Crítico)

**Regra:** Stories devem ser completáveis em UMA context window.

### ✅ Right-Sized Stories

- Adicionar coluna no banco + migration
- Criar componente UI único
- Atualizar uma server action
- Adicionar validação em um form
- Escrever unit tests para um módulo

### ❌ Oversized Stories (DIVIDIR!)

- Construir dashboard inteiro
- Adicionar sistema de autenticação completo
- Refatorar API completa
- CRUD completo de uma entidade
- Implementar feature multi-página

**Razão:** Stories muito grandes esgotam contexto → código quebrado.

---

## Conceitos vs Implementação

### O que o SAF É

✅ Framework de **princípios** e **práticas**
✅ Metodologia para desenvolvimento autônomo
✅ Sistema de quality gates e audit trail
✅ Padrões de documentação (PRD, progress.txt, handoff.md)

### O que o SAF NÃO É

❌ Biblioteca de código
❌ Framework JavaScript/TypeScript
❌ Tool/CLI executável
❌ Dependência npm/pypi

---

## Comparação com Metodologias Tradicionais

| Aspecto | SAF | Agile/Scrum | Waterfall |
|---------|-----|-------------|-----------|
| **Documentação** | Story-driven, contexto completo | User stories mínimas | Specs extensas |
| **Quality** | Quality gates automáticos | Definition of Done | QA fase separada |
| **Rastreabilidade** | Dev Agent Record (audit trail) | Sprint backlog | Change log manual |
| **Aprendizado** | Patterns compound | Retrospectives | Lessons learned |
| **Iteração** | Autônoma (loop externo) | Sprints com humanos | Fases sequenciais |

**Diferencial do SAF:** Otimizado para **agentes de IA autônomos**, não humanos.

---

## Extensões do SAF

O SAF pode ser estendido com:

### Content Mode
Para produção de conteúdo (não código):
- `branchName: ""`  trabalha no main
- `gitEnabled: false` sem commits
- Validação simplificada (arquivo existe + conteúdo válido)
- Execução paralela por default

### Parallel Execution
Stories independentes executam simultaneamente:
- `parallelization.enabled: true`
- `parallelization.maxConcurrent: N`
- `story.dependencies: []` define ordem

---

## Benefícios do SAF

| Benefício | Como o SAF Entrega |
|-----------|-------------------|
| **Zero código quebrado** | Quality gates obrigatórios |
| **Rastreabilidade completa** | Dev Agent Record |
| **Sem perda de contexto** | Handoff System |
| **Aprendizado acumulativo** | Patterns Compound |
| **Sem scope creep** | Strict Sections |
| **Desenvolvimento autônomo** | Story-Driven + Agent Delegation |
| **Audit trail completo** | File List + Session Log |

---

## Implementação no Ralph

O Ralph é a implementação de referência do SAF Framework:

```
frameworks/ralph/
├── agents/ralph.md          # Agente SAF-compliant
├── templates/
│   ├── prd-template.md     # PRD SAF
│   ├── progress.txt        # Progress log SAF
│   ├── prompt.md           # Instruções SAF
│   └── handoff-template.md # Handoff SAF
├── checklists/
│   ├── quality-gates.md    # Quality gates SAF
│   └── pre-implementation.md
└── workflows/
    └── autonomous-loop.md  # Workflow SAF
```

---

## Glossário

| Termo | Definição |
|-------|-----------|
| **SAF** | Sleep Agent Framework - Framework proprietário do Sleep Agent |
| **Story-Driven** | Desenvolvimento onde PRD contém todo contexto necessário |
| **Quality Gates** | Checklist obrigatório antes de marcar story como completa |
| **Strict Sections** | Seções do PRD que o agente pode/não pode editar |
| **Dev Agent Record** | Audit trail (File List + Session Log) |
| **Handoff System** | Mecanismo de transmissão de contexto entre stories |
| **Patterns Compound** | Learnings acumulam e informam futuras iterações |
| **Agent Delegation** | Ralph assume personas especializadas por tipo de story |
| **PRD** | Product Requirements Document - especificação completa |
| **passes** | Flag boolean que indica story completa (true) ou pendente (false) |

---

## Changelog

### v1.0 (2026-02-01)
- Versão inicial do SAF Framework
- Documentação completa dos 7 princípios
- Estrutura de PRD, progress.txt, handoff.md
- Quality gates e workflow definidos
- Implementação de referência: Ralph

---

## Referências

- [Ralph README](../README.md) - Implementação SAF
- [Quality Gates Checklist](../checklists/quality-gates.md)
- [PRD Template](../templates/prd-template.md)
- [Handoff Template](../templates/handoff-template.md)
- [MIGRATION.md](/MIGRATION.md) - Migração AIOS → SAF

---

**Sleep Agent Framework (SAF)**
*Autonomous Development, Quality-First*

© 2026 Sleep Agent - Todos os direitos reservados
