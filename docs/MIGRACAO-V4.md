# Guia de Migracao: Sleep Agent v3 para v4

Este guia ajuda usuarios existentes a migrarem para a versao 4.0 do Sleep Agent.

---

## Resumo das Mudancas

### O que mudou

| Area | Antes (v3) | Agora (v4) |
|------|------------|------------|
| Memoria | Nenhuma | Sistema persistente |
| Quality Gates | Lista simples | 3 niveis estruturados |
| Health Check | Verificacao basica | Auto-correcao em 3 tiers |
| Matching | Gatilhos exatos | Matching inteligente |
| Agentes | Sem classificacao | Niveis de maturidade |
| Status | Comando simples | Observabilidade completa |
| Workflows | Sequenciais | Suporte a paralelo |

### O que NAO mudou

- Estrutura de extensoes continua a mesma
- Comandos existentes funcionam igual
- Arquivos do workspace sao preservados
- Tom de voz e comportamento
- Processo de setup

---

## Passo a Passo da Migracao

### Passo 1: Fazer Backup

Antes de qualquer coisa, faca backup do seu workspace:

```
Copie a pasta workspace/ para um local seguro
```

### Passo 2: Atualizar Arquivos do Core

Os novos arquivos ja estao no repositorio. Basta fazer pull:

```bash
cd sleep-agent
git pull origin main
```

### Passo 3: Criar Pastas de Memoria e Status

O sistema cria automaticamente, mas voce pode criar manualmente:

```bash
# Pasta de memoria
mkdir -p workspace/.memoria

# Pasta de status
mkdir -p workspace/.status
```

### Passo 4: Verificar Configuracao

Execute o setup para atualizar a configuracao:

```
/setup
```

Ou deixe o Sleep Agent fazer automaticamente na proxima sessao.

### Passo 5: Verificar Extensoes

Se voce tem extensoes customizadas, atualize o `extensao.yaml` para incluir maturidade:

```yaml
agentes:
  - id: meu-agente
    arquivo: agentes/MEU-AGENTE.md
    maturidade: 2  # Adicione esta linha
    checklist:     # Adicione este bloco
      persona: true
      processo: true
      tarefas: true
      conhecimento: true
      workflows: false
      templates: false
      exemplos: false
      gates: false
```

---

## Compatibilidade

### 100% Compativel

- Estrutura de extensoes
- Comandos de extensoes (/marketing, /branding, etc)
- Arquivos do workspace
- Tarefas existentes
- Workflows existentes

### Requer Atualizacao Manual

- extensao.yaml (adicionar maturidade)
- Tarefas customizadas (adicionar gates em 3 niveis)

### Novo (Opcional)

- Sistema de memoria
- Quality Gates estruturados
- Workflows paralelos

---

## FAQ - Perguntas Frequentes

### Vou perder meus arquivos?

**Nao.** A migracao nao altera arquivos existentes no workspace.

### Preciso atualizar minhas extensoes?

**Recomendado, mas nao obrigatorio.** Extensoes v3 continuam funcionando. Atualizar adiciona recursos de maturidade.

### O que acontece se eu nao migrar?

**Funciona normal.** O Sleep Agent detecta a versao e opera no modo compativel. Voce so nao tem acesso aos novos recursos.

### Como uso a memoria?

**Automaticamente.** O Sleep Agent captura e consulta memoria sem voce precisar fazer nada. Use `/memoria` para ver o que foi capturado.

### Como funcionam os Quality Gates?

**Nivel 1 e automatico.** O Sleep Agent valida formato e completude. Nivel 2 e 3 sao acionados conforme a tarefa.

### E se algo der errado?

1. Restaure o backup do workspace
2. Delete as pastas `.memoria/` e `.status/`
3. Execute `/setup` novamente

---

## Checklist de Migracao

```
[ ] Backup do workspace feito
[ ] Pull do repositorio atualizado
[ ] Pasta .memoria/ criada
[ ] Pasta .status/ criada
[ ] /setup executado
[ ] Extensoes customizadas atualizadas (opcional)
[ ] Testar comandos principais
```

---

## Arquivos Novos na v4

```
core/
├── memoria/
│   └── MEMORIA.md           # Documentacao do sistema de memoria
├── qualidade/
│   ├── QUALITY-GATES.md     # Documentacao de quality gates
│   └── gates-padrao.yaml    # Gates reutilizaveis
├── saude/
│   ├── HEALTH-CHECK.md      # Documentacao de health check
│   └── verificacoes.yaml    # Lista de verificacoes
├── status/
│   └── STATUS.md            # Documentacao de status
├── agentes/
│   ├── MATURIDADE.md        # Sistema de maturidade
│   └── checklist-maturidade.yaml
├── workflows/
│   └── PARALELO.md          # Workflows paralelos
└── templates/
    ├── contexto-completo.yaml  # Template rico
    └── README.md

workspace/
├── .memoria/
│   ├── insights.yaml
│   ├── decisoes.yaml
│   ├── padroes.yaml
│   └── alertas.yaml
├── .status/
│   ├── atual.yaml
│   ├── historico.yaml
│   └── metricas.yaml
└── .config/
    └── registry.yaml        # Novo: cache de extensoes
```

---

## Suporte

Se encontrar problemas:

1. Verifique este guia novamente
2. Execute `/saude` para diagnostico
3. Consulte a documentacao em `docs/`

---

## Historico de Versoes

### v4.0 (2026-02-06)
- Sistema de memoria persistente
- Quality Gates em 3 niveis
- Health Check com auto-correcao
- Matching inteligente de comandos
- Maturidade de agentes
- Status e observabilidade
- Workflows paralelos
- Registry centralizado

### v3.0
- Framework Ralph
- Sistema de extensoes
- Setup adaptativo
- Orquestracao de agentes
