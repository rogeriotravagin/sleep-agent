# Comando /ajuda

Quando o usuario digitar `/ajuda`, exibir:

---

## Sleep Agent - Ajuda

### O que e o Sleep Agent?

Um assistente inteligente com agentes especializados para ajudar profissionais nao-tecnicos a realizarem tarefas complexas de forma simples.

O Sleep Agent funciona com **extensoes** - modulos independentes que adicionam capacidades especificas.

### Comandos Globais

| Comando | O que faz |
|---------|-----------|
| `/ajuda` | Mostra esta mensagem |
| `/setup` | Configurar ou reconfigurar workspace |
| `/extensoes` | Lista extensoes instaladas |
| `/status` | Mostra extensao ativa e configuracao |
| `/salvar` | Salva o ultimo resultado |
| `/ralph` | Ativa modo autonomo Ralph |

### Como Descobrir Comandos de uma Extensao

1. Digite o comando da extensao (ex: `/marketing`)
2. O sistema mostrara todos os comandos disponiveis

### Como Usar

1. **Configure o workspace** (primeira vez): O sistema perguntara sobre sua estrutura
2. **Ative uma extensao**: Digite o comando da extensao desejada
3. **Faca seu pedido**: Descreva o que precisa
4. **Refine se necessario**: Peca ajustes ou variacoes
5. **Salve o resultado**: `/salvar`

### Estrutura do Workspace

O Sleep Agent organiza seus outputs automaticamente:

```
workspace/
└── [sua-empresa-ou-produto]/
    ├── referencias/           # Docs que voce ja tinha
    └── [extensao]/            # Outputs organizados por extensao
        └── [tipo]/            # Tipo de conteudo gerado
```

### Dicas

- Voce nao precisa usar comandos. Pode simplesmente descrever o que precisa.
- Quanto mais contexto voce der, melhor o resultado.
- Peca variacoes: "Me de 5 opcoes" ou "Tente de outro angulo"
- O sistema detecta automaticamente qual agente usar

### Modos Iniciante

Cada extensao tem um modo iniciante para comecar rapidamente:
- Responda 5 perguntas simples
- O sistema processa automaticamente
- Receba resultado completo via Ralph

### Precisa de Mais Ajuda?

- Leia o guia completo em `docs/PRIMEIROS-PASSOS.md`
- Veja exemplos dentro de cada extensao em `extensoes/[nome]/exemplos/`

---

**Versao:** Sleep Agent v2.0
