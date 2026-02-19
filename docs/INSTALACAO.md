# Instalação

## Pré-requisitos

1. **Claude Code** instalado no seu computador
   - Se não tem, siga as instruções em: https://claude.ai/code

2. **Git** instalado (para clonar o repositório)
   - Windows: https://git-scm.com/download/win
   - Mac: Já vem instalado ou `brew install git`

## Passo a Passo

### 1. Clone o repositório

Abra o terminal e execute:

```bash
git clone https://github.com/seu-usuario/sleep_agent.git
```

### 2. Entre na pasta

```bash
cd sleep_agent
```

### 3. Inicie o Claude Code

```bash
claude
```

Pronto! O Claude vai se apresentar como Sleep Agent.

## Verificando a Instalação

Após iniciar, você deve ver algo como:

```
Olá! Eu sou o Sleep Agent.

Seu assistente com agentes especializados para marketing, jurídico e contábil.

Comandos disponíveis:
- /marketing  - Ativar extensão de Marketing
- /extensoes  - Ver todas as extensões
- /ajuda      - Menu de ajuda completo

Como posso ajudar hoje?
```

Se viu isso, está tudo funcionando!

## Atualizando

Para atualizar para a versão mais recente:

```bash
cd sleep_agent
git pull
```

## Problemas Comuns

### "Claude não encontrado"

O Claude Code não está instalado. Siga as instruções em https://claude.ai/code

### "Permissão negada"

No Mac/Linux, pode ser necessário dar permissão:

```bash
chmod +x claude
```

### Claude não se comporta como Sleep Agent

Verifique se o arquivo `.claude/CLAUDE.md` existe na pasta do projeto.

## Estrutura Após Instalação

```
sleep_agent/
├── .claude/
│   └── CLAUDE.md          ← Configuração principal
├── core/                  ← Motor do sistema
├── extensoes/
│   └── marketing/         ← Extensão de Marketing
├── projetos/              ← Seus trabalhos
├── docs/                  ← Documentação
└── README.md
```

## Próximos Passos

Agora que instalou, vá para [Primeiros Passos](PRIMEIROS-PASSOS.md) para aprender a usar.
