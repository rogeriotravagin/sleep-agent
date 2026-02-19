# Como o Sleep Agent Funciona

## Visao Geral

O Sleep Agent e um framework que usa o Claude Code como motor para coordenar agentes especializados. Nao ha codigo para rodar - tudo funciona atraves de arquivos de configuracao que o Claude le e segue.

## Arquitetura Modular

O Sleep Agent funciona como um sistema de plugins:

- **Core**: Motor generico e agnostico
- **Extensoes**: Modulos independentes e autocontidos
- **Workspace**: Area de trabalho adaptativa do usuario

## Conceitos Principais

### 1. Extensoes

Extensoes sao modulos que adicionam capacidades ao Sleep Agent. Cada extensao contem:

- **Agentes**: Personas especializadas
- **Tarefas**: Fluxos predefinidos para resultados especificos
- **Workflows**: Sequencias de tarefas para projetos maiores
- **Conhecimento**: Base de conhecimento que fundamenta as respostas
- **Delegacao**: Regras proprias de delegacao

### 2. Agentes

Agentes sao personas que o Claude assume para executar tarefas especificas. Cada agente tem:

- Nome e especialidade
- Tom de voz proprio
- Conhecimentos especificos
- Formato de entrega

### 3. Tarefas

Tarefas sao fluxos estruturados que guiam o agente. Incluem:

- Perguntas a fazer ao usuario
- Passos a seguir
- Formato esperado de saida

### 4. Workflows

Workflows sao sequencias de tarefas que produzem um resultado maior.

### 5. Workspace

Area de trabalho do usuario que se adapta ao contexto:

- **Holding**: Para multiplas empresas
- **Empresa**: Para uma empresa com produtos
- **Produto**: Para um unico produto

## Fluxo de Uso

```
┌─────────────────┐
│  Usuario inicia │
│   Sleep Agent   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Setup verifica │
│    workspace    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Sistema escaneia│
│    extensoes    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Voce digita   │
│   um comando    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Orquestrador   │
│   identifica    │
│    extensao     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Carrega extensao│
│   e delega ao   │
│     agente      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Agente executa │
│  usando base de │
│  conhecimento   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Salva no      │
│   workspace     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Entrega o    │
│    resultado    │
└─────────────────┘
```

## Salvando Resultados

Todos os resultados sao salvos automaticamente no workspace, organizados por:

```
workspace/[estrutura]/[extensao]/[tipo]/
```

## Adicionando Extensoes

Para adicionar uma nova extensao:

1. Copie a pasta da extensao para `extensoes/`
2. O sistema detecta automaticamente na proxima execucao
3. Os comandos da extensao ficam disponiveis
