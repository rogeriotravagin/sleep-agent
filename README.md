# Sleep Agent v5 - Framework de Agentes para Claude Code

Framework inteligente que coordena agentes especializados para ajudar profissionais nao-tecnicos a realizarem tarefas complexas de forma simples.

O Sleep Agent transforma o Claude Code em um sistema operacional de agentes com memoria persistente, quality gates, reuso inteligente de ativos e orquestracao automatica.

## Requisitos

- [Claude Code](https://claude.ai/claude-code) instalado e configurado
- Conta no Claude com acesso ao Claude Code CLI

## Instalacao

1. Clone o repositorio:

```bash
git clone https://github.com/rogeriotravagin/sleep-agent.git
cd sleep-agent
```

2. Configure o workspace:

```bash
# O Sleep Agent cria a estrutura automaticamente no primeiro uso
# Basta abrir o Claude Code no diretorio do projeto
```

3. Inicie o Claude Code no diretorio:

```
/ajuda
```

O Sleep Agent detecta automaticamente as extensoes instaladas e apresenta os comandos disponiveis.

## Arquitetura

```
sleep-agent/
├── .claude/CLAUDE.md      # Identidade e instrucoes do sistema
├── kernel/                # Nucleo do sistema (v5)
│   ├── constitution/      # Regras imutaveis
│   ├── memory-bus/        # Comunicacao entre agentes
│   ├── context-manager/   # Carregamento progressivo
│   ├── tool-registry/     # Inventario de ferramentas
│   ├── permissions/       # Modos de permissao
│   ├── config/            # Configuracao em camadas
│   ├── scheduler/         # Escalonador de tarefas
│   ├── lifecycle/         # Ciclo de vida de agentes
│   ├── event-bus/         # Sistema reativo
│   └── asset-engine/      # Reuso inteligente
├── core/                  # Motor central
│   ├── orquestrador/      # Delegacao + matching
│   ├── memoria/           # Memoria hierarquica (3 camadas)
│   ├── qualidade/         # Quality Gates + auto-calibracao
│   ├── saude/             # Health Check + auto-correcao
│   ├── status/            # Dashboard + observabilidade
│   ├── workflows/         # DAG Engine + paralelo
│   └── agentes/           # Sistema de maturidade
├── frameworks/            # Engines de execucao
│   └── ralph/             # Loop autonomo
├── extensoes/             # Extensoes instaladas
└── workspace/             # Area de trabalho (criado automaticamente)
```

## Extensoes Incluidas

| Extensao | Comando | O que faz |
|----------|---------|-----------|
| **Branding** | `/branding` | Identidade visual, design systems, logos, paletas |
| **Customer Success** | `/customer-success` | Onboarding, retencao, health score, casos criticos (CDC) |
| **Dados** | `/dados` | Analise de dados, relatorios, dashboards |
| **Deploy** | `/deploy` | Deploy de sites na Vercel, dominios customizados |
| **DevOps** | `/devops` | Infraestrutura cloud, Hetzner, Portainer, seguranca |
| **Educacional** | `/educacional` | Cursos, aulas, materiais didaticos, avaliacoes |
| **Marketing** | `/marketing` | Copy, landing pages, emails, anuncios, VSLs |
| **Produtos** | `/produtos` | PRDs, roadmaps, discovery, OKRs |
| **TI** | `/ti` | Suporte tecnico, desenvolvimento, infraestrutura |

## Comandos Principais

| Comando | Acao |
|---------|------|
| `/ajuda` | Menu de ajuda completo |
| `/setup` | Configurar workspace |
| `/extensoes` | Listar extensoes instaladas |
| `/status` | Tarefa atual e historico |
| `/dashboard` | Metricas e observabilidade |
| `/memoria` | Ver memoria do sistema |
| `/saude` | Health check do sistema |
| `/ralph` | Modo autonomo para tarefas complexas |

## Recursos do v5

### Blackboard (Estado Compartilhado)
Agentes compartilham estado automaticamente. O Estrategista define o ICP, o Copywriter usa sem perguntar de novo.

### Memoria Hierarquica (3 Camadas)
- **Trabalho:** Sessao atual (volatil)
- **Episodica:** Ultimos 30 dias (decai)
- **Semantica:** Permanente (regras, padroes, decisoes)

### Asset Engine (Reuso Inteligente)
Antes de criar qualquer entrega, verifica se ja existe algo similar:
- **REUSAR** (>= 90%): Usa direto
- **ADAPTAR** (60-89%): Usa como base
- **CRIAR** (< 60%): Cria do zero

### Quality Gates (3 Niveis)
1. **Automatico:** Formato, completude, regras
2. **Outro Agente:** Consistencia, qualidade tecnica
3. **Usuario:** Satisfacao, alinhamento

### Event Bus (Sistema Reativo)
Triggers automaticos: quality check ao concluir tarefa, circuit breaker ao falhar 3x, memoria ao capturar insight.

### DAG Workflows
Grafos de dependencia com paralelismo automatico, retry com fallback e circuit breaker.

## Personalizacao

### Adicionar Extensao

Crie uma pasta em `extensoes/` com a estrutura:

```
extensoes/minha-extensao/
├── .claude/CLAUDE.md       # Instrucoes da extensao
├── extensao.yaml           # Configuracao e agentes
├── core/orquestrador/
│   └── delegacao.yaml      # Regras de delegacao
├── agentes/                # Agentes especializados
├── tarefas/                # Definicoes de tarefas
├── conhecimento/           # Base de conhecimento
├── templates/              # Templates reusaveis
└── workflows/              # Workflows multi-fase
```

### Configurar Ferramentas

Registre APIs e integracoes em `kernel/tool-registry/registry.yaml` usando variaveis de ambiente:

```yaml
- id: minha-api
  tipo: api
  auth:
    env_var: "MINHA_API_KEY"
```

Credenciais ficam no `.env` do workspace (nunca no repositorio).

## Documentacao

| Documento | Conteudo |
|-----------|----------|
| [CLAUDE.md](.claude/CLAUDE.md) | Identidade e instrucoes completas |
| [ARQUITETURA-PLUGINS.md](docs/ARQUITETURA-PLUGINS.md) | Como criar extensoes |
| [INSTALACAO.md](docs/INSTALACAO.md) | Guia de instalacao |
| [PRIMEIROS-PASSOS.md](docs/PRIMEIROS-PASSOS.md) | Tutorial inicial |
| [FAQ.md](docs/FAQ.md) | Perguntas frequentes |

## Licenca

MIT
