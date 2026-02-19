# SAF - Glossário Rápido

**Sleep Agent Framework (SAF)** - Quick Reference

---

## Termos-Chave

### SAF
**Sleep Agent Framework** - Framework proprietário para desenvolvimento autônomo.

### Story-Driven
PRD contém TODO contexto necessário. Zero documentação externa.

### Quality Gates
Checklist obrigatório. Story só completa quando TUDO passa.

### Strict Sections
Agente só edita seções autorizadas. Previne scope creep.

### Dev Agent Record
Audit trail completo: File List + Session Log.

### Handoff System
Contexto transmitido entre stories via `handoff.md`.

### Patterns Compound
Learnings acumulam no topo de `progress.txt`.

### Agent Delegation
Ralph assume personas (@dev, @architect, @qa) por tipo de story.

---

## Arquivos

| Arquivo | Propósito |
|---------|-----------|
| `prd.json` | Especificação completa (user stories + dev notes) |
| `progress.txt` | Audit trail (patterns + file list + session log) |
| `handoff.md` | Contexto crítico da última story |
| `prompt.md` | Instruções para o agente |

---

## Workflow

```
Read handoff → Read PRD → Select story → Assume persona →
Implement → Validate gates → Update file list → Commit →
Update progress → Update handoff → Next story
```

---

## Seções do PRD

1. Introduction
2. Goals
3. User Stories
4. Functional Requirements
5. Non-Goals
6. Design Considerations
7. Technical Considerations
8. **Dev Notes** ⭐ (contexto completo aqui)
9. Success Metrics
10. Open Questions
11. **Quality Gates** ⭐ (definition of done)
12. **Dev Agent Record** ⭐ (audit trail)

---

## Quality Gates

- [ ] typecheck passes
- [ ] lint passes
- [ ] tests pass
- [ ] file list updated
- [ ] learnings documented
- [ ] handoff.md updated

---

## Personas

| Story Type | Persona |
|------------|---------|
| Architecture | @architect (Winston) |
| Implementation | @dev (James) |
| Testing | @qa |
| UI/UX | @ux-expert |
| Setup/Docs | @ralph |

---

Para documentação completa, ver [SAF-FRAMEWORK.md](SAF-FRAMEWORK.md)
