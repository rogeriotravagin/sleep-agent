# Extensão Educacional - Sleep Agent

Extensão especializada na criação de cursos, aulas, atividades e materiais educacionais de alto impacto.

## Visão Geral

A extensão Educacional oferece um time completo de especialistas para criar experiências de aprendizagem que geram resultados reais.

### Agentes Disponíveis

| Agente | Comando | Especialidade |
|--------|---------|---------------|
| Designer Instrucional | `/design-instrucional` | Arquitetura e estrutura de cursos |
| Conteudista | `/conteudo` | Criação de aulas e materiais |
| Especialista em Avaliação | `/avaliacao` | Atividades, provas e gamificação |

## Comandos Rápidos

```bash
# Criar curso rapidamente (5 perguntas)
/iniciante-curso

# Workflow completo de curso
/curso-completo

# Tarefas específicas
/estruturar-curso    # Estrutura completa
/criar-modulo        # Criar módulo
/criar-aula          # Criar aula
/criar-atividade     # Criar atividade
/criar-checklist     # Checklist de progresso
/gamificar           # Aplicar gamificação
```

## Workflows

### 1. Modo Iniciante (`/iniciante-curso`)

O caminho mais rápido para estruturar seu curso:

1. Responda 5 perguntas simples
2. Sistema processa automaticamente
3. Ralph gera a estrutura completa

**Ideal para:** Primeira versão do curso

### 2. Curso Completo (`/curso-completo`)

Processo profissional em 6 fases:

1. **DESCOBERTA** - Público, problema, transformação
2. **ARQUITETURA** - Estrutura, módulos, objetivos
3. **CONTEÚDO** - Aulas, roteiros, materiais
4. **ATIVIDADES** - Exercícios, projetos, avaliações
5. **GAMIFICAÇÃO** - Engajamento, badges, progressão
6. **ENTREGA** - Checklist final, certificação

**Ideal para:** Cursos profissionais completos

## Metodologias Utilizadas

### Design Instrucional
- **Taxonomia de Bloom** - Objetivos de aprendizagem
- **ADDIE** - Modelo de desenvolvimento
- **9 Eventos de Gagné** - Estrutura de aulas
- **Action Mapping** - Foco em resultados

### Metodologias Ativas
- Sala de Aula Invertida
- Aprendizagem Baseada em Problemas
- Aprendizagem Baseada em Projetos
- Peer Instruction

### Gamificação
- Framework Octalysis
- Pontos, Badges, Leaderboards
- Progressão e Níveis
- Narrativa e Storytelling

## Estrutura de Saída

```
projetos/curso-[nome]/
├── 01-planejamento/
│   ├── briefing.md
│   ├── publico-alvo.md
│   └── objetivos.md
├── 02-estrutura/
│   ├── grade-curricular.md
│   ├── modulos/
│   └── trilha-aprendizagem.md
├── 03-conteudo/
│   ├── aulas/
│   ├── roteiros/
│   └── materiais/
├── 04-atividades/
│   ├── exercicios/
│   ├── projetos/
│   └── avaliacoes/
├── 05-gamificacao/
│   ├── sistema-pontos.md
│   ├── badges.md
│   └── niveis.md
└── 06-entrega/
    ├── checklist-lancamento.md
    └── certificacao.md
```

## Integração com Ralph

A extensão utiliza o Ralph para geração autônoma:

```bash
# Gerar curso via Ralph
./frameworks/ralph/scripts/ralph.sh 30

# Templates disponíveis
frameworks/ralph/templates/prd-curso.json
frameworks/ralph/templates/prompt-curso.md
```

## Referências

### Design Instrucional
- Robert Gagné - 9 Events of Instruction
- Benjamin Bloom - Taxonomia de Bloom
- Cathy Moore - Action Mapping
- Julie Dirksen - Design for How People Learn

### Gamificação
- Yu-kai Chou - Octalysis Framework
- Karl Kapp - Gamification of Learning

## Uso com Outras Extensões

### Marketing
Após criar o curso, use a extensão Marketing para:
- Criar página de vendas (`/iniciante`)
- Desenvolver copy do curso (`/copy`)
- Criar funil de lançamento (`/lancamento`)

### Branding
Para identidade visual do curso:
- Criar marca do curso (`/brand-completo`)
- Design de materiais (`/designer`)
