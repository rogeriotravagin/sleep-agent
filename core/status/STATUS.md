# Sistema de Status do Sleep Agent

O Sleep Agent mantem um registro do que esta acontecendo, permitindo que voce acompanhe o progresso das tarefas.

---

## O que o Status Mostra

### Tarefa Atual

O que esta sendo feito agora:
- Qual tarefa esta em andamento
- Qual agente esta executando
- Em qual passo esta
- Quanto tempo ja passou

### Historico

O que foi feito recentemente:
- Tarefas completadas
- Resultados gerados
- Tempo de execucao

### Metricas

Estatisticas agregadas:
- Total de tarefas por extensao
- Taxa de aprovacao (nivel 3)
- Tempo medio por tipo de tarefa

---

## Onde Fica o Status

```
workspace/.status/
├── atual.yaml       # Tarefa em andamento
├── historico.yaml   # Ultimas 50 execucoes
└── metricas.yaml    # Estatisticas agregadas
```

---

## Comando /status

```
/status
```

### Saida Exemplo

```
Status do Sleep Agent
=====================

Tarefa Atual:
  Nome: Criar headline para curso de ingles
  Agente: Copywriter
  Extensao: Marketing
  Progresso: 3/5 passos
  Tempo: 2 min

Ultimas Tarefas:
  [OK] Definir ICP - 5 min atras
  [OK] Pesquisa de mercado - 15 min atras
  [OK] Criar paleta de cores - 1h atras

Sessao:
  Inicio: 14:30
  Tarefas completadas: 3
  Tempo total: 25 min
```

---

## Formato dos Arquivos

### atual.yaml

```yaml
tarefa:
  id: criar-headline-12345
  nome: "Criar headline para curso de ingles"
  extensao: marketing
  agente: copywriter
  inicio: "2026-02-06T14:30:00"

progresso:
  passo_atual: 3
  total_passos: 5
  descricao_passo: "Gerando variações usando gatilhos mentais"

contexto:
  produto: "Curso de Ingles Fluente"
  empresa: "Acme Digital"
```

### historico.yaml

```yaml
execucoes:
  - id: criar-headline-12345
    nome: "Criar headline"
    extensao: marketing
    agente: copywriter
    inicio: "2026-02-06T14:30:00"
    fim: "2026-02-06T14:35:00"
    duracao_segundos: 300
    resultado: sucesso
    arquivo_gerado: "workspace/acme/marketing/headlines/headline-curso.md"
    aprovado_usuario: true

  - id: definir-icp-12344
    nome: "Definir ICP"
    extensao: marketing
    agente: estrategista
    inicio: "2026-02-06T14:20:00"
    fim: "2026-02-06T14:28:00"
    duracao_segundos: 480
    resultado: sucesso
    arquivo_gerado: "workspace/acme/marketing/icp.md"
    aprovado_usuario: true
```

### metricas.yaml

```yaml
periodo: "2026-02"
total_tarefas: 45
por_extensao:
  marketing: 25
  branding: 15
  dados: 5

por_resultado:
  sucesso: 42
  ajuste_necessario: 2
  cancelado: 1

taxa_aprovacao: 93.3

tempo_medio_segundos:
  headline: 180
  email: 420
  landing: 1200
  logo: 600

agentes_mais_usados:
  - copywriter: 20
  - estrategista: 12
  - designer: 8
```

---

## Comandos Relacionados

| Comando | O que mostra |
|---------|-------------|
| `/status` | Status atual completo |
| `/historico` | Ultimas 10 tarefas |
| `/metricas` | Estatisticas do mes |

---

## Uso Automatico

O Sleep Agent atualiza o status automaticamente:

1. **Ao iniciar tarefa** - Cria entrada em atual.yaml
2. **Durante execucao** - Atualiza progresso
3. **Ao finalizar** - Move para historico.yaml
4. **Periodicamente** - Atualiza metricas.yaml

Voce nao precisa fazer nada - so consultar quando quiser.
