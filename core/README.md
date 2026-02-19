# Core do Sleep Agent

O Core e o motor generico do Sleep Agent, responsavel por:

- **Setup**: Configurar workspace do usuario
- **Orquestracao**: Coordenar extensoes e delegar tarefas
- **Templates**: Padronizar formatos de saida
- **Comandos**: Disponibilizar comandos globais

## Estrutura

```
core/
├── setup/
│   └── SETUP.md              # Agente de configuracao adaptativo
├── orquestrador/
│   └── ORQUESTRADOR.md       # Regras genericas de orquestracao
├── templates/
│   ├── tarefa.yaml           # Template base de tarefa
│   └── progresso.md          # Template de progresso
└── comandos/
    └── AJUDA.md              # Comando /ajuda
```

## Como Funciona

1. Usuario inicia o Sleep Agent
2. Setup verifica/configura workspace
3. Sistema escaneia extensoes disponiveis
4. Usuario faz um pedido
5. Orquestrador identifica extensao e agente
6. Carrega extensao e delega para agente
7. Agente executa usando conhecimento da extensao
8. Resultado e salvo no workspace
9. Entrega ao usuario

## Principios

- **Generico**: O core nao conhece extensoes especificas
- **Agnostico**: Funciona com qualquer extensao instalada
- **Adaptativo**: Estrutura do workspace se adapta ao usuario
- **Extensivel**: Novas extensoes sao adicionadas sem modificar o core

## Extensoes

Cada extensao e autocontida e inclui:
- Seu proprio `.claude/CLAUDE.md` (instrucoes especificas)
- Seu proprio `core/orquestrador/delegacao.yaml` (regras de delegacao)
- Seus proprios agentes, tarefas, workflows e conhecimento
