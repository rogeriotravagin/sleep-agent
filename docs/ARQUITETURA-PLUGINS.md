# Sleep Agent - Arquitetura de Plugins

> Documento de arquitetura para expansão do sistema de agentes para múltiplas áreas profissionais.

---

## Visão Geral

O Sleep Agent é uma **plataforma extensível de agentes autônomos** que permite automatizar tarefas profissionais usando Claude Code. A arquitetura de plugins permite que diferentes áreas (desenvolvimento, marketing, jurídico, contábil, etc.) coexistam no mesmo sistema, cada uma com seus agentes especializados.

### O Problema que Resolve

O Auto-Claude original foi construído exclusivamente para desenvolvimento de software. Todo o vocabulário, prompts e fluxos assumem um contexto de código:

- `spec.md` → especificação técnica
- `worktree` → isolamento git
- `coder`, `planner`, `qa` → papéis de dev

Para expandir para outras áreas, precisamos de uma abstração que permita:

1. **Manter** o que já funciona para dev
2. **Adicionar** novas áreas sem conflito
3. **Isolar** cada área em seu próprio contexto
4. **Compartilhar** a infraestrutura comum (SDK, orquestração, memória)

---

## Arquitetura de 3 Camadas

```
┌─────────────────────────────────────────────────────────────────────┐
│                           PLUGINS                                    │
│         (Dev, Marketing, Jurídico, Contábil, Vendas, ...)           │
│                                                                      │
│   Cada plugin contém:                                               │
│   - Agentes especializados (prompts)                                │
│   - Runners (lógica de execução)                                    │
│   - Context loaders (carrega dados da área)                         │
│   - Templates (estruturas reutilizáveis)                            │
│   - Workflows (sequências de agentes)                               │
└─────────────────────────────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│                            CORE                                      │
│                    (Motor Compartilhado)                            │
│                                                                      │
│   - Orchestrator      → Gerencia execução de agentes                │
│   - Session Manager   → Controla sessões Claude                     │
│   - Memory (Graphiti) → Persiste conhecimento                       │
│   - Plugin Loader     → Carrega e registra plugins                  │
│   - Rate Limiter      → Controla limites de API                     │
│   - UI Base           → Interface Electron compartilhada            │
└─────────────────────────────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         WORKSPACES                                   │
│                  (Onde o usuário trabalha)                          │
│                                                                      │
│   Cada workspace pertence a um plugin:                              │
│   - minha-agencia/     → plugin: marketing                          │
│   - escritorio-abc/    → plugin: legal                              │
│   - meu-saas/          → plugin: dev                                │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Estrutura de Diretórios

```
sleep_agent/
│
├── core/                              # Motor central (compartilhado)
│   ├── orchestrator/
│   │   ├── agent_runner.py            # Executa qualquer agente
│   │   ├── workflow_runner.py         # Executa workflows
│   │   └── plugin_loader.py           # Carrega plugins
│   ├── session/
│   │   ├── session_manager.py         # Gerencia sessões Claude
│   │   └── context_injector.py        # Injeta contexto nos prompts
│   ├── memory/
│   │   ├── graphiti_client.py         # Cliente Graphiti
│   │   └── memory_manager.py          # CRUD de memória
│   ├── sdk/
│   │   └── claude_client.py           # Wrapper do Claude SDK
│   ├── rate_limiter/
│   │   └── limiter.py                 # Controle de rate limit
│   └── ui/
│       └── electron/                  # UI base compartilhada
│
├── plugins/                           # Plugins por área
│   │
│   ├── dev/                           # 🔧 Desenvolvimento (Auto-Claude)
│   │   ├── plugin.yaml
│   │   ├── runners/
│   │   ├── prompts/
│   │   ├── context/
│   │   └── templates/
│   │
│   ├── marketing/                     # 📣 Marketing & Copy
│   │   ├── plugin.yaml
│   │   ├── runners/
│   │   ├── prompts/
│   │   ├── context/
│   │   └── templates/
│   │
│   ├── legal/                         # ⚖️ Jurídico
│   │   ├── plugin.yaml
│   │   ├── runners/
│   │   ├── prompts/
│   │   ├── context/
│   │   └── templates/
│   │
│   ├── accounting/                    # 📊 Contábil
│   │   ├── plugin.yaml
│   │   ├── runners/
│   │   ├── prompts/
│   │   ├── context/
│   │   └── templates/
│   │
│   └── sales/                         # 💰 Vendas
│       ├── plugin.yaml
│       ├── runners/
│       ├── prompts/
│       ├── context/
│       └── templates/
│
├── workspaces/                        # Projetos do usuário
│   └── .gitkeep
│
└── docs/
    └── ARQUITETURA-PLUGINS.md         # Este documento
```

---

## Anatomia de um Plugin

Cada plugin é uma pasta auto-contida com a seguinte estrutura:

```
plugins/{nome}/
│
├── plugin.yaml              # Manifesto do plugin (obrigatório)
│
├── runners/                 # Lógica de execução
│   ├── __init__.py
│   └── {nome}_runner.py     # Ex: copy_runner.py, contract_runner.py
│
├── prompts/                 # System prompts dos agentes
│   ├── agente1.md
│   ├── agente2.md
│   └── agente3.md
│
├── context/                 # Carregadores de contexto
│   ├── __init__.py
│   └── {nome}_loader.py     # Ex: brand_loader.py, case_loader.py
│
├── templates/               # Templates reutilizáveis
│   ├── template1.md
│   ├── template2.json
│   └── ...
│
└── knowledge/               # Base de conhecimento (opcional)
    ├── frameworks.md
    ├── best_practices.md
    └── examples/
```

---

## O Manifesto do Plugin (plugin.yaml)

O arquivo `plugin.yaml` é o contrato do plugin com o sistema. Define:

```yaml
# Identificação
name: marketing                      # ID único (usado em código)
displayName: "Marketing & Copy"      # Nome para exibição
description: "Agentes para criação de copy, campanhas e análise de marketing"
version: "1.0.0"
icon: "📣"                           # Emoji ou path para ícone
author: "Sleep Agent Team"

# Agentes disponíveis
agents:
  - id: copywriter
    name: "Copywriter Expert"
    description: "Especialista em copy persuasiva e headlines"
    command: "/copy"                 # Comando para ativar
    prompt: "prompts/copywriter.md"  # Path relativo ao prompt
    runner: "runners/copy_runner.py" # Path relativo ao runner
    keywords:                        # Para delegação automática
      - "copy"
      - "headline"
      - "texto"
      - "persuasão"

  - id: estrategista
    name: "Estrategista de Marketing"
    description: "Define posicionamento, público e estratégia"
    command: "/estrategia"
    prompt: "prompts/estrategista.md"
    runner: "runners/campaign_runner.py"
    keywords:
      - "estratégia"
      - "posicionamento"
      - "público"
      - "persona"

  - id: analista-ads
    name: "Analista de Tráfego Pago"
    description: "Planeja e analisa campanhas de mídia paga"
    command: "/ads"
    prompt: "prompts/analista_ads.md"
    runner: "runners/campaign_runner.py"
    keywords:
      - "campanha"
      - "anúncio"
      - "tráfego"
      - "facebook"
      - "google"

# Contexto que o plugin carrega
context:
  loader: "context/brand_loader.py"  # Classe que carrega contexto
  index_file: "brand_index.json"     # Arquivo principal de contexto
  files:                             # Arquivos adicionais
    - "audience.json"
    - "competitors.json"
    - "voice_tone.md"

# Tarefas predefinidas
tasks:
  - id: criar-oferta
    name: "Criar Oferta Irresistível"
    description: "Cria uma oferta completa com headline, bullets e CTA"
    template: "templates/oferta.md"
    agents: [copywriter, estrategista]  # Agentes envolvidos

  - id: analisar-campanha
    name: "Analisar Campanha"
    description: "Analisa métricas e sugere otimizações"
    template: "templates/analise_campanha.md"
    agents: [analista-ads]

  - id: criar-funil
    name: "Criar Funil de Vendas"
    description: "Estrutura funil completo com emails e páginas"
    template: "templates/funil.md"
    agents: [estrategista, copywriter]

# Workflows (sequências automatizadas)
workflows:
  lancamento:
    name: "Lançamento de Produto"
    description: "Workflow completo para lançar um produto"
    steps:
      - agent: estrategista
        task: "Definir posicionamento e público-alvo"
        output: "posicionamento.md"

      - agent: copywriter
        task: "Criar página de vendas"
        input: "posicionamento.md"     # Usa output do step anterior
        output: "pagina_vendas.md"

      - agent: copywriter
        task: "Criar sequência de emails"
        input: "posicionamento.md"
        output: "emails/"

      - agent: analista-ads
        task: "Planejar campanhas de tráfego"
        input: "posicionamento.md"
        output: "plano_midia.md"

  auditoria-copy:
    name: "Auditoria de Copy"
    description: "Analisa e melhora copy existente"
    steps:
      - agent: copywriter
        task: "Analisar pontos fracos"
        output: "analise.md"

      - agent: copywriter
        task: "Reescrever com melhorias"
        input: "analise.md"
        output: "copy_melhorada.md"

# Dependências (outros plugins necessários)
dependencies: []

# Configurações específicas
settings:
  defaultModel: "claude-sonnet-4-20250514"
  maxTokens: 8192
  temperature: 0.7
```

---

## Como o Auto-Claude Vira Plugin Dev

O Auto-Claude existente se transforma no plugin `dev`:

```yaml
# plugins/dev/plugin.yaml

name: dev
displayName: "Desenvolvimento de Software"
description: "Agentes para desenvolvimento autônomo de código"
version: "1.0.0"
icon: "🔧"

agents:
  - id: coder
    name: "Coder Agent"
    command: "/code"
    prompt: "prompts/coder.md"
    runner: "runners/coder_runner.py"
    keywords:
      - "implementar"
      - "código"
      - "feature"
      - "bug"

  - id: planner
    name: "Planner Agent"
    command: "/plan"
    prompt: "prompts/planner.md"
    runner: "runners/planner_runner.py"
    keywords:
      - "planejar"
      - "arquitetura"
      - "design"

  - id: qa-reviewer
    name: "QA Reviewer"
    command: "/qa"
    prompt: "prompts/qa_reviewer.md"
    runner: "runners/qa_runner.py"
    keywords:
      - "revisar"
      - "testar"
      - "qualidade"

context:
  loader: "context/project_loader.py"
  index_file: "project_index.json"
  files:
    - "implementation_plan.json"
    - "spec.md"

tasks:
  - id: criar-spec
    name: "Criar Especificação"
    template: "templates/spec.md"
    agents: [planner]

  - id: implementar
    name: "Implementar Feature"
    template: "templates/implementation.md"
    agents: [coder, qa-reviewer]

workflows:
  feature-completa:
    name: "Desenvolver Feature Completa"
    steps:
      - agent: planner
        task: "Criar plano de implementação"
      - agent: coder
        task: "Implementar código"
      - agent: qa-reviewer
        task: "Revisar e testar"
```

### Migração do Auto-Claude

```
.auto-claude/                    →    plugins/dev/
├── apps/backend/                     ├── runners/
│   ├── agents/coder.py              │   ├── coder_runner.py
│   ├── agents/planner.py            │   ├── planner_runner.py
│   └── qa/                          │   └── qa_runner.py
│                                     │
├── apps/backend/prompts/            ├── prompts/
│   ├── coder.md                     │   ├── coder.md
│   ├── planner.md                   │   ├── planner.md
│   └── qa_*.md                      │   └── qa_reviewer.md
│                                     │
└── apps/backend/context/            └── context/
    └── ...                              └── project_loader.py
```

---

## O Core (Motor Compartilhado)

### Plugin Loader

```python
# core/orchestrator/plugin_loader.py

from pathlib import Path
import yaml
from typing import Dict, List, Optional

class Plugin:
    """Representa um plugin carregado"""
    def __init__(self, manifest: dict, base_path: Path):
        self.name = manifest['name']
        self.display_name = manifest['displayName']
        self.version = manifest['version']
        self.icon = manifest.get('icon', '🔌')
        self.base_path = base_path

        self.agents = self._load_agents(manifest.get('agents', []))
        self.tasks = manifest.get('tasks', [])
        self.workflows = manifest.get('workflows', {})
        self.context_config = manifest.get('context', {})

    def _load_agents(self, agents_config: List[dict]) -> Dict[str, 'Agent']:
        agents = {}
        for config in agents_config:
            agent = Agent(
                id=config['id'],
                name=config['name'],
                command=config['command'],
                prompt_path=self.base_path / config['prompt'],
                runner_path=self.base_path / config['runner'],
                keywords=config.get('keywords', [])
            )
            agents[agent.id] = agent
        return agents

    def get_agent_by_command(self, command: str) -> Optional['Agent']:
        """Retorna agente pelo comando (ex: /copy)"""
        for agent in self.agents.values():
            if agent.command == command:
                return agent
        return None

    def get_agent_by_keywords(self, text: str) -> Optional['Agent']:
        """Retorna agente mais relevante baseado em keywords"""
        text_lower = text.lower()
        best_match = None
        best_score = 0

        for agent in self.agents.values():
            score = sum(1 for kw in agent.keywords if kw in text_lower)
            if score > best_score:
                best_score = score
                best_match = agent

        return best_match


class PluginLoader:
    """Carrega e gerencia plugins"""

    def __init__(self, plugins_dir: Path):
        self.plugins_dir = plugins_dir
        self.plugins: Dict[str, Plugin] = {}

    def discover(self) -> List[str]:
        """Descobre plugins disponíveis"""
        available = []
        for path in self.plugins_dir.iterdir():
            if path.is_dir() and (path / 'plugin.yaml').exists():
                available.append(path.name)
        return available

    def load(self, plugin_name: str) -> Plugin:
        """Carrega um plugin pelo nome"""
        if plugin_name in self.plugins:
            return self.plugins[plugin_name]

        plugin_path = self.plugins_dir / plugin_name
        manifest_path = plugin_path / 'plugin.yaml'

        if not manifest_path.exists():
            raise ValueError(f"Plugin '{plugin_name}' não encontrado")

        with open(manifest_path, 'r', encoding='utf-8') as f:
            manifest = yaml.safe_load(f)

        plugin = Plugin(manifest, plugin_path)
        self.plugins[plugin_name] = plugin

        return plugin

    def load_all(self) -> Dict[str, Plugin]:
        """Carrega todos os plugins disponíveis"""
        for name in self.discover():
            self.load(name)
        return self.plugins
```

### Agent Runner

```python
# core/orchestrator/agent_runner.py

from pathlib import Path
from typing import Any, Dict, Optional
from core.sdk.claude_client import ClaudeClient
from core.memory.memory_manager import MemoryManager

class Agent:
    """Representa um agente de um plugin"""
    def __init__(
        self,
        id: str,
        name: str,
        command: str,
        prompt_path: Path,
        runner_path: Path,
        keywords: list = None
    ):
        self.id = id
        self.name = name
        self.command = command
        self.prompt_path = prompt_path
        self.runner_path = runner_path
        self.keywords = keywords or []
        self._prompt_cache = None

    @property
    def prompt(self) -> str:
        """Carrega e cacheia o prompt"""
        if self._prompt_cache is None:
            with open(self.prompt_path, 'r', encoding='utf-8') as f:
                self._prompt_cache = f.read()
        return self._prompt_cache


class AgentRunner:
    """Executa qualquer agente de qualquer plugin"""

    def __init__(
        self,
        claude_client: ClaudeClient,
        memory_manager: MemoryManager
    ):
        self.claude = claude_client
        self.memory = memory_manager

    async def run(
        self,
        agent: Agent,
        task: str,
        context: Dict[str, Any],
        workspace_path: Optional[Path] = None
    ) -> Dict[str, Any]:
        """
        Executa um agente com uma tarefa.

        Args:
            agent: O agente a executar
            task: A tarefa/pergunta do usuário
            context: Contexto carregado pelo plugin
            workspace_path: Diretório de trabalho

        Returns:
            Resultado da execução
        """
        # 1. Carrega o prompt do agente
        system_prompt = agent.prompt

        # 2. Injeta contexto no prompt
        full_prompt = self._inject_context(system_prompt, context)

        # 3. Executa sessão Claude
        result = await self.claude.run_session(
            system_prompt=full_prompt,
            user_message=task,
            working_dir=workspace_path
        )

        # 4. Salva na memória
        await self.memory.save_interaction(
            agent_id=agent.id,
            task=task,
            result=result,
            context=context
        )

        return {
            'success': result.success,
            'output': result.output,
            'agent': agent.id,
            'task': task
        }

    def _inject_context(
        self,
        prompt: str,
        context: Dict[str, Any]
    ) -> str:
        """Injeta contexto no prompt do agente"""
        context_section = self._format_context(context)

        # Substitui placeholder ou adiciona no início
        if '{{CONTEXT}}' in prompt:
            return prompt.replace('{{CONTEXT}}', context_section)
        else:
            return f"{context_section}\n\n---\n\n{prompt}"

    def _format_context(self, context: Dict[str, Any]) -> str:
        """Formata contexto para injeção"""
        lines = ["## Contexto do Projeto\n"]

        for key, value in context.items():
            if isinstance(value, dict):
                lines.append(f"### {key}")
                lines.append(f"```json\n{json.dumps(value, indent=2)}\n```\n")
            elif isinstance(value, str):
                lines.append(f"### {key}")
                lines.append(f"{value}\n")

        return '\n'.join(lines)
```

### Workflow Runner

```python
# core/orchestrator/workflow_runner.py

from typing import Dict, List, Any, Optional
from pathlib import Path
import asyncio

class WorkflowStep:
    """Um passo de um workflow"""
    def __init__(
        self,
        agent_id: str,
        task: str,
        input_file: Optional[str] = None,
        output_file: Optional[str] = None
    ):
        self.agent_id = agent_id
        self.task = task
        self.input_file = input_file
        self.output_file = output_file


class WorkflowRunner:
    """Executa workflows (sequências de agentes)"""

    def __init__(self, agent_runner: AgentRunner, plugin: Plugin):
        self.agent_runner = agent_runner
        self.plugin = plugin

    async def run(
        self,
        workflow_id: str,
        initial_context: Dict[str, Any],
        workspace_path: Path,
        on_progress: callable = None
    ) -> Dict[str, Any]:
        """
        Executa um workflow completo.

        Args:
            workflow_id: ID do workflow no plugin
            initial_context: Contexto inicial
            workspace_path: Diretório de trabalho
            on_progress: Callback de progresso
        """
        workflow = self.plugin.workflows.get(workflow_id)
        if not workflow:
            raise ValueError(f"Workflow '{workflow_id}' não encontrado")

        results = []
        context = initial_context.copy()

        for i, step_config in enumerate(workflow['steps']):
            step = WorkflowStep(
                agent_id=step_config['agent'],
                task=step_config['task'],
                input_file=step_config.get('input'),
                output_file=step_config.get('output')
            )

            # Notifica progresso
            if on_progress:
                on_progress({
                    'step': i + 1,
                    'total': len(workflow['steps']),
                    'agent': step.agent_id,
                    'task': step.task,
                    'status': 'running'
                })

            # Carrega input do step anterior se especificado
            if step.input_file and step.input_file in context:
                context['previous_output'] = context[step.input_file]

            # Executa o agente
            agent = self.plugin.agents[step.agent_id]
            result = await self.agent_runner.run(
                agent=agent,
                task=step.task,
                context=context,
                workspace_path=workspace_path
            )

            # Salva output se especificado
            if step.output_file:
                output_path = workspace_path / step.output_file
                output_path.parent.mkdir(parents=True, exist_ok=True)
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(result['output'])
                context[step.output_file] = result['output']

            results.append(result)

            # Notifica conclusão do step
            if on_progress:
                on_progress({
                    'step': i + 1,
                    'total': len(workflow['steps']),
                    'agent': step.agent_id,
                    'task': step.task,
                    'status': 'completed'
                })

        return {
            'workflow': workflow_id,
            'success': all(r['success'] for r in results),
            'steps': results
        }
```

---

## Fluxo de Execução

### 1. Inicialização

```
Usuário abre Sleep Agent
        │
        ▼
┌─────────────────────────┐
│    Plugin Loader        │
│    Descobre plugins     │
│    disponíveis          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    UI mostra opções     │
│    - 🔧 Desenvolvimento │
│    - 📣 Marketing       │
│    - ⚖️ Jurídico        │
└───────────┬─────────────┘
            │
            ▼
    Usuário escolhe plugin
```

### 2. Carregamento do Plugin

```
Usuário seleciona "Marketing"
        │
        ▼
┌─────────────────────────┐
│    Carrega plugin.yaml  │
│    Registra agentes     │
│    Carrega contexto     │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    Comandos disponíveis │
│    /copy                │
│    /estrategia          │
│    /ads                 │
└─────────────────────────┘
```

### 3. Execução de Comando

```
Usuário: /copy Crie uma headline para meu curso
        │
        ▼
┌─────────────────────────┐
│    Parser identifica    │
│    comando: /copy       │
│    tarefa: "Crie..."    │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    Plugin.get_agent     │
│    by_command("/copy")  │
│    → Copywriter Agent   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    Context Loader       │
│    Carrega brand_index  │
│    audience, voice_tone │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    Agent Runner         │
│    Injeta contexto      │
│    Executa Claude SDK   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│    Retorna resultado    │
│    Salva na memória     │
└─────────────────────────┘
```

### 4. Execução de Workflow

```
Usuário: "Quero lançar meu produto"
        │
        ▼
┌─────────────────────────┐
│    Detecta workflow     │
│    "lancamento"         │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────────────────────┐
│    Step 1: Estrategista                 │
│    "Definir posicionamento"             │
│    Output: posicionamento.md            │
└───────────┬─────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────┐
│    Step 2: Copywriter                   │
│    "Criar página de vendas"             │
│    Input: posicionamento.md             │
│    Output: pagina_vendas.md             │
└───────────┬─────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────┐
│    Step 3: Analista Ads                 │
│    "Planejar campanhas"                 │
│    Input: posicionamento.md             │
│    Output: plano_midia.md               │
└───────────┬─────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────┐
│    Resultado consolidado                │
│    Arquivos salvos no workspace         │
└─────────────────────────────────────────┘
```

---

## Criando um Novo Plugin

### Passo 1: Criar estrutura

```bash
mkdir -p plugins/vendas/{runners,prompts,context,templates,knowledge}
```

### Passo 2: Criar manifesto

```yaml
# plugins/vendas/plugin.yaml

name: vendas
displayName: "Vendas & Prospecção"
version: "1.0.0"
icon: "💰"

agents:
  - id: sdr
    name: "SDR (Sales Development Rep)"
    command: "/sdr"
    prompt: "prompts/sdr.md"
    runner: "runners/outreach_runner.py"
    keywords: ["prospecção", "cold call", "email", "linkedin"]

  - id: closer
    name: "Closer"
    command: "/closer"
    prompt: "prompts/closer.md"
    runner: "runners/sales_runner.py"
    keywords: ["negociação", "proposta", "objeção", "fechamento"]

context:
  loader: "context/sales_loader.py"
  index_file: "pipeline.json"
  files:
    - "scripts.md"
    - "objections.md"
    - "pricing.json"

tasks:
  - id: criar-sequencia
    name: "Criar Sequência de Prospecção"
    template: "templates/sequencia.md"
    agents: [sdr]

workflows:
  prospectar:
    name: "Prospecção Completa"
    steps:
      - agent: sdr
        task: "Pesquisar empresa e decisor"
        output: "pesquisa.md"
      - agent: sdr
        task: "Criar sequência de contato"
        input: "pesquisa.md"
        output: "sequencia/"
```

### Passo 3: Criar prompt do agente

```markdown
<!-- plugins/vendas/prompts/sdr.md -->

## SEU PAPEL - SDR EXPERT

Você é um SDR (Sales Development Representative) especialista em prospecção B2B.

### Sua Expertise
- Cold email que gera respostas
- Mensagens de LinkedIn que convertem
- Pesquisa de empresas e decisores
- Sequências de follow-up

### Contexto do Projeto
{{CONTEXT}}

### Diretrizes
1. Sempre personalize com dados da empresa
2. Foque em DOR, não em features
3. CTA claro e simples
4. Máximo 3 parágrafos por email

### Formato de Resposta
Para cada peça de prospecção, forneça:
- Assunto (se email)
- Corpo da mensagem
- Notas de personalização
```

### Passo 4: Criar context loader

```python
# plugins/vendas/context/sales_loader.py

from pathlib import Path
import json
from typing import Dict, Any

class SalesContextLoader:
    """Carrega contexto de vendas para os agentes"""

    def __init__(self, workspace_path: Path):
        self.workspace = workspace_path
        self.config_dir = workspace_path / '.sleep'

    def load(self) -> Dict[str, Any]:
        """Carrega todo o contexto de vendas"""
        context = {}

        # Pipeline de vendas
        pipeline_path = self.config_dir / 'pipeline.json'
        if pipeline_path.exists():
            with open(pipeline_path, 'r', encoding='utf-8') as f:
                context['pipeline'] = json.load(f)

        # Scripts de vendas
        scripts_path = self.config_dir / 'scripts.md'
        if scripts_path.exists():
            with open(scripts_path, 'r', encoding='utf-8') as f:
                context['scripts'] = f.read()

        # Tratamento de objeções
        objections_path = self.config_dir / 'objections.md'
        if objections_path.exists():
            with open(objections_path, 'r', encoding='utf-8') as f:
                context['objections'] = f.read()

        # Pricing
        pricing_path = self.config_dir / 'pricing.json'
        if pricing_path.exists():
            with open(pricing_path, 'r', encoding='utf-8') as f:
                context['pricing'] = json.load(f)

        return context
```

### Passo 5: Registrar plugin

```bash
# O plugin é auto-descoberto ao existir em plugins/
# Mas pode forçar registro:
sleep plugin list    # Lista plugins disponíveis
sleep plugin load vendas   # Carrega específico
```

---

## Comparação: Plugins Disponíveis

| Plugin | Agentes | Uso Principal |
|--------|---------|---------------|
| **dev** | coder, planner, qa | Desenvolvimento de software |
| **marketing** | copywriter, estrategista, analista-ads | Criação de copy e campanhas |
| **legal** | contratos, parecerista, due-diligence | Análise e criação de documentos jurídicos |
| **accounting** | fiscal, analista, auditor | Análise contábil e fiscal |
| **sales** | sdr, closer, cs | Prospecção e fechamento |
| **hr** | recruiter, avaliador, onboarding | Recrutamento e gestão de pessoas |

---

## Benefícios da Arquitetura

### Para Desenvolvedores
- Plugins isolados = menos conflitos
- Fácil adicionar novos agentes
- Testes por plugin
- Versionamento independente

### Para Usuários
- Escolhe só o que precisa
- Contexto sempre relevante
- Agentes especializados na área
- Workflows prontos

### Para o Negócio
- Cada plugin pode ser um produto
- Venda separada ou bundle
- Atualizações independentes
- Comunidade pode contribuir plugins

---

## Ralph Multi-Área

O Ralph é o **orquestrador autônomo** do Sleep Agent. Atualmente está hardcoded para desenvolvimento, mas sua arquitetura de loop externo é genérica. Esta seção documenta como expandir o Ralph para múltiplas áreas mantendo o suporte a dev.

### Diagnóstico Atual

```
┌─────────────────────────────────────────────────────────────┐
│                      RALPH ATUAL                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   ralph.sh ────────────────────────── ✅ 100% Genérico      │
│   ralph-parallel.sh ───────────────── ✅ 100% Genérico      │
│   ralph-swarm.sh ──────────────────── ✅ 100% Genérico      │
│   prd.json structure ──────────────── ✅ 100% Genérico      │
│                                                              │
│   ralph.md ────────────────────────── ❌ 100% Dev-only      │
│   └── persona, keywords, quality_gates, skills              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Arquitetura Proposta

```
ralph/
├── agents/
│   ├── ralph-core.md              # Orquestrador genérico (novo)
│   └── ralph.md                   # Mantido para compatibilidade
│
├── areas/                          # Configurações por área (novo)
│   │
│   ├── dev/                        # Área: Desenvolvimento
│   │   ├── area.yaml               # Manifesto da área
│   │   ├── delegation.yaml         # Mapa de delegação
│   │   ├── quality-gates.yaml      # Gates de qualidade
│   │   ├── persona.md              # Persona específica
│   │   └── knowledge/              # Base de conhecimento
│   │       ├── patterns.md
│   │       └── best-practices.md
│   │
│   ├── marketing/                  # Área: Marketing
│   │   ├── area.yaml
│   │   ├── delegation.yaml
│   │   ├── quality-gates.yaml
│   │   ├── persona.md
│   │   └── knowledge/
│   │       ├── copywriting.md
│   │       ├── funnels.md
│   │       └── ads.md
│   │
│   ├── legal/                      # Área: Jurídico
│   │   ├── area.yaml
│   │   ├── delegation.yaml
│   │   ├── quality-gates.yaml
│   │   ├── persona.md
│   │   └── knowledge/
│   │
│   └── accounting/                 # Área: Contábil
│       ├── area.yaml
│       ├── delegation.yaml
│       ├── quality-gates.yaml
│       ├── persona.md
│       └── knowledge/
│
├── scripts/                        # Scripts (inalterados)
│   ├── ralph.sh
│   ├── ralph-parallel.sh
│   └── ralph-swarm.sh
│
├── templates/                      # Templates genéricos
│   ├── prd.json
│   ├── progress.txt
│   └── prompt.md
│
└── tasks/                          # Tarefas genéricas
    └── ...
```

### PRD com Campo de Área

```json
{
  "project": "Nome do Projeto",
  "area": "marketing",              // ← Ralph detecta a área
  "description": "...",
  "userStories": [
    {
      "id": "US-001",
      "title": "Criar headline principal",
      "acceptanceCriteria": ["..."],
      "passes": false
    }
  ]
}
```

### Ralph Core (Genérico)

```yaml
# ralph/agents/ralph-core.md

agent:
  name: Ralph Autonomous Agent
  id: ralph
  title: Autonomous Task Orchestrator    # Genérico, não "Development"
  icon: 🔄

activation-instructions:
  - STEP 1: Read prd.json
  - STEP 2: Detect "area" field (default: "dev")
  - STEP 3: Load area config from ralph/areas/{area}/
  - STEP 4: Adopt persona from areas/{area}/persona.md
  - STEP 5: Load delegation map from areas/{area}/delegation.yaml
  - STEP 6: Load quality gates from areas/{area}/quality-gates.yaml
  - STEP 7: Greet user with area-specific message

# Carregamento dinâmico
area_loading:
  config_path: "ralph/areas/{{AREA}}/area.yaml"
  delegation_path: "ralph/areas/{{AREA}}/delegation.yaml"
  quality_gates_path: "ralph/areas/{{AREA}}/quality-gates.yaml"
  persona_path: "ralph/areas/{{AREA}}/persona.md"
  knowledge_path: "ralph/areas/{{AREA}}/knowledge/"

# Comportamento core (igual para todas as áreas)
core_principles:
  - AUTONOMOUS EXECUTION: Work through stories until all pass=true
  - PROGRESS TRACKING: Update progress.txt after each story
  - PATTERN COMPOUNDING: Add learnings to Patterns section
  - QUALITY VALIDATION: Run quality gates before marking done
  - FILE TRACKING: Maintain File List with all outputs
  - SESSION LOGGING: Append to Session Log after each story

# Comandos (iguais para todas as áreas)
commands:
  - '*help' - Show available commands
  - '*create-prd' - Create PRD with clarifying questions
  - '*convert' - Convert existing document to prd.json
  - '*run' - Show how to run ralph.sh
  - '*status' - Show current progress
  - '*validate' - Validate against quality gates
  - '*exit' - Deactivate persona

# Workflow genérico
workflows:
  autonomous_loop:
    1: Read prd.json → detect area → load area config
    2: Find next story (passes=false)
    3: Load area knowledge
    4: ANALYZE story → match keywords to delegation map
    5: DELEGATE to specialist agent (from area config)
    6: RECEIVE result
    7: VALIDATE against area quality gates
    8: UPDATE prd.json and progress.txt
    9: REPEAT until all stories pass
    10: Output <promise>COMPLETE</promise>
```

---

### Área: Desenvolvimento (Extraído do Ralph Atual)

```yaml
# ralph/areas/dev/area.yaml

name: dev
displayName: "Desenvolvimento de Software"
icon: 🔧
description: "Orquestração autônoma para desenvolvimento de código"

# Referências
delegation: "./delegation.yaml"
quality_gates: "./quality-gates.yaml"
persona: "./persona.md"
knowledge: "./knowledge/"

# Skills disponíveis nesta área
skills:
  - dev-agent
  - architect-agent
  - qa-agent
  - ux-expert-agent

# Configurações específicas
settings:
  gitEnabled: true
  branchPrefix: "ralph/"
  commitConvention: "conventional"
```

```yaml
# ralph/areas/dev/delegation.yaml

# Mapa de delegação para desenvolvimento
# Ralph analisa keywords e delega para o skill correto

architecture_stories:
  keywords:
    - "arquitetura"
    - "design system"
    - "API design"
    - "schema"
    - "database design"
    - "infrastructure"
  skill_name: "architect-agent"
  agent_name: "Winston"
  announce: "📐 Delegating to Architect..."

implementation_stories:
  keywords:
    - "implementar"
    - "criar componente"
    - "adicionar função"
    - "código"
    - "feature"
    - "implement"
    - "build"
    - "develop"
  skill_name: "dev-agent"
  agent_name: "James"
  announce: "💻 Delegating to Developer..."

testing_stories:
  keywords:
    - "testar"
    - "test"
    - "QA"
    - "validar"
    - "verificar"
    - "review"
    - "quality"
  skill_name: "qa-agent"
  agent_name: "Quinn"
  announce: "🧪 Delegating to QA..."

ux_stories:
  keywords:
    - "UI"
    - "UX"
    - "interface"
    - "layout"
    - "design visual"
    - "user experience"
  skill_name: "ux-expert-agent"
  agent_name: "UX Expert"
  announce: "🎨 Delegating to UX Expert..."

simple_stories:
  keywords:
    - "criar diretório"
    - "mkdir"
    - "setup"
    - "README"
    - "config"
  skill_name: null
  handle_directly: true
  announce: "📁 Handling directly..."
```

```yaml
# ralph/areas/dev/quality-gates.yaml

# Quality gates para desenvolvimento

code_quality:
  name: "Qualidade de Código"
  checks:
    - id: typecheck
      command: "npm run typecheck"
      description: "TypeScript compilation passes"
      required: true
    - id: lint
      command: "npm run lint"
      description: "Linting passes"
      required: true
    - id: no_console
      pattern: "console.log"
      description: "No console.log in production code"
      required: false
    - id: error_handling
      description: "Error handling implemented"
      manual: true

testing:
  name: "Testes"
  checks:
    - id: unit_tests
      command: "npm test"
      description: "Unit tests pass"
      required: true
    - id: coverage
      command: "npm run test:coverage"
      description: "Coverage threshold met"
      required: false

documentation:
  name: "Documentação"
  checks:
    - id: file_list
      description: "File List updated in progress.txt"
      manual: true
    - id: learnings
      description: "Learnings documented"
      manual: true

integration:
  name: "Integração"
  checks:
    - id: no_breaking
      description: "No breaking changes"
      manual: true
    - id: follows_patterns
      description: "Follows existing patterns"
      manual: true
```

```markdown
# ralph/areas/dev/persona.md

## Persona: Development Orchestrator

Você é o **Ralph**, um orquestrador autônomo especializado em desenvolvimento de software.

### Sua Identidade
- **Papel**: Autonomous Development Loop Orchestrator
- **Estilo**: Sistemático, persistente, focado em qualidade
- **Foco**: Executar user stories até conclusão, aprendendo a cada iteração

### Conhecimentos Específicos
- Story-Driven Development
- Quality Gates de código
- Git workflow (branches, commits, PRs)
- Padrões de código e arquitetura
- Test-Driven Development

### Comportamento
- Sempre valide código com typecheck/lint antes de marcar como done
- Nunca marque story como completa se testes falharem
- Documente padrões descobertos em Codebase Patterns
- Use commits convencionais (feat:, fix:, refactor:)

### Saudação
"🔄 Ralph Development Orchestrator ready. I help you execute development tasks autonomously. Type `*help` for commands."
```

---

### Área: Marketing (Nova)

```yaml
# ralph/areas/marketing/area.yaml

name: marketing
displayName: "Marketing & Copy"
icon: 📣
description: "Orquestração autônoma para criação de copy e campanhas"

delegation: "./delegation.yaml"
quality_gates: "./quality-gates.yaml"
persona: "./persona.md"
knowledge: "./knowledge/"

skills:
  - copywriter-agent
  - estrategista-agent
  - ads-agent

settings:
  gitEnabled: false
  outputFormat: "markdown"
  reviewRequired: true
```

```yaml
# ralph/areas/marketing/delegation.yaml

copywriting_stories:
  keywords:
    - "copy"
    - "headline"
    - "texto"
    - "persuasão"
    - "bullet"
    - "CTA"
    - "email"
    - "subject line"
  skill_name: "copywriter-agent"
  agent_name: "Copy Expert"
  announce: "✍️ Delegating to Copywriter..."

strategy_stories:
  keywords:
    - "estratégia"
    - "posicionamento"
    - "público"
    - "persona"
    - "avatar"
    - "competitor"
    - "diferencial"
  skill_name: "estrategista-agent"
  agent_name: "Strategist"
  announce: "🎯 Delegating to Strategist..."

ads_stories:
  keywords:
    - "campanha"
    - "anúncio"
    - "tráfego"
    - "facebook"
    - "google"
    - "instagram"
    - "ads"
    - "mídia paga"
  skill_name: "ads-agent"
  agent_name: "Ads Expert"
  announce: "📈 Delegating to Ads Expert..."

funnel_stories:
  keywords:
    - "funil"
    - "landing page"
    - "página de vendas"
    - "conversão"
    - "lead"
  skill_name: "copywriter-agent"
  agent_name: "Copy Expert"
  announce: "🔄 Delegating to Funnel Expert..."

simple_stories:
  keywords:
    - "listar"
    - "resumir"
    - "organizar"
  skill_name: null
  handle_directly: true
```

```yaml
# ralph/areas/marketing/quality-gates.yaml

copy_quality:
  name: "Qualidade da Copy"
  checks:
    - id: headline_power
      description: "Headline tem palavra de poder"
      manual: true
    - id: benefit_focused
      description: "Foco em benefícios, não features"
      manual: true
    - id: cta_clear
      description: "CTA claro e específico"
      manual: true
    - id: urgency
      description: "Elemento de urgência/escassez presente"
      manual: false

persuasion:
  name: "Persuasão"
  checks:
    - id: pain_points
      description: "Dores do público endereçadas"
      manual: true
    - id: social_proof
      description: "Prova social incluída"
      manual: false
    - id: objections
      description: "Objeções principais tratadas"
      manual: true

formatting:
  name: "Formatação"
  checks:
    - id: scannable
      description: "Texto escaneável (bullets, subtítulos)"
      manual: true
    - id: mobile_friendly
      description: "Parágrafos curtos para mobile"
      manual: true
```

```markdown
# ralph/areas/marketing/persona.md

## Persona: Marketing Orchestrator

Você é o **Ralph**, um orquestrador autônomo especializado em marketing e copywriting.

### Sua Identidade
- **Papel**: Autonomous Marketing Loop Orchestrator
- **Estilo**: Criativo, persuasivo, orientado a conversão
- **Foco**: Criar copy e campanhas que convertem, iterando até a qualidade ideal

### Conhecimentos Específicos
- Copywriting persuasivo (AIDA, PAS, 4Ps)
- Psicologia de vendas
- Estrutura de funis
- Otimização de anúncios
- Email marketing

### Comportamento
- Sempre foque em benefícios, não features
- Use palavras de poder nas headlines
- Inclua prova social quando possível
- Crie urgência genuína
- Antecipe e trate objeções

### Saudação
"📣 Ralph Marketing Orchestrator ready. I help you create high-converting copy and campaigns. Type `*help` for commands."
```

```markdown
# ralph/areas/marketing/knowledge/copywriting.md

## Frameworks de Copywriting

### AIDA
- **Attention**: Capture atenção com headline poderosa
- **Interest**: Gere interesse com benefícios
- **Desire**: Crie desejo com prova social
- **Action**: Direcione para ação com CTA

### PAS
- **Problem**: Apresente o problema/dor
- **Agitate**: Amplifique a dor
- **Solution**: Apresente a solução

### 4Ps
- **Promise**: Promessa principal
- **Picture**: Pinte o cenário ideal
- **Proof**: Prove que funciona
- **Push**: Empurre para ação

## Palavras de Poder
- Grátis, Novo, Comprovado, Garantido
- Exclusivo, Limitado, Urgente
- Descubra, Aprenda, Transforme
- Fácil, Rápido, Simples

## Gatilhos Mentais
- Escassez, Urgência, Autoridade
- Prova Social, Reciprocidade
- Compromisso, Afinidade
```

---

### Área: Jurídico (Nova)

```yaml
# ralph/areas/legal/area.yaml

name: legal
displayName: "Jurídico"
icon: ⚖️
description: "Orquestração autônoma para análise e criação de documentos jurídicos"

delegation: "./delegation.yaml"
quality_gates: "./quality-gates.yaml"
persona: "./persona.md"
knowledge: "./knowledge/"

skills:
  - contratos-agent
  - parecerista-agent
  - pesquisa-agent

settings:
  gitEnabled: false
  outputFormat: "docx"
  confidential: true
  reviewRequired: true
```

```yaml
# ralph/areas/legal/delegation.yaml

contract_stories:
  keywords:
    - "contrato"
    - "cláusula"
    - "termo"
    - "acordo"
    - "NDA"
    - "prestação de serviço"
  skill_name: "contratos-agent"
  agent_name: "Contract Expert"
  announce: "📜 Delegating to Contract Specialist..."

opinion_stories:
  keywords:
    - "parecer"
    - "análise jurídica"
    - "opinião legal"
    - "viabilidade"
    - "risco"
  skill_name: "parecerista-agent"
  agent_name: "Legal Advisor"
  announce: "⚖️ Delegating to Legal Advisor..."

research_stories:
  keywords:
    - "jurisprudência"
    - "pesquisa"
    - "legislação"
    - "lei"
    - "precedente"
  skill_name: "pesquisa-agent"
  agent_name: "Legal Researcher"
  announce: "🔍 Delegating to Legal Researcher..."

petition_stories:
  keywords:
    - "petição"
    - "recurso"
    - "defesa"
    - "contestação"
  skill_name: "parecerista-agent"
  agent_name: "Legal Advisor"
  announce: "📋 Delegating to Petition Expert..."
```

```yaml
# ralph/areas/legal/quality-gates.yaml

legal_accuracy:
  name: "Precisão Jurídica"
  checks:
    - id: legislation_cited
      description: "Legislação relevante citada"
      manual: true
    - id: jurisprudence
      description: "Jurisprudência atualizada"
      manual: true
    - id: no_contradictions
      description: "Sem contradições internas"
      manual: true

document_quality:
  name: "Qualidade do Documento"
  checks:
    - id: structure
      description: "Estrutura formal adequada"
      manual: true
    - id: language
      description: "Linguagem técnica apropriada"
      manual: true
    - id: completeness
      description: "Todos os pontos endereçados"
      manual: true

risk_assessment:
  name: "Avaliação de Risco"
  checks:
    - id: risks_identified
      description: "Riscos identificados"
      manual: true
    - id: mitigations
      description: "Mitigações sugeridas"
      manual: true
```

```markdown
# ralph/areas/legal/persona.md

## Persona: Legal Orchestrator

Você é o **Ralph**, um orquestrador autônomo especializado em trabalho jurídico.

### Sua Identidade
- **Papel**: Autonomous Legal Loop Orchestrator
- **Estilo**: Preciso, formal, analítico
- **Foco**: Produzir documentos jurídicos de alta qualidade com precisão técnica

### Conhecimentos Específicos
- Direito Civil e Empresarial
- Redação jurídica formal
- Análise de contratos
- Pesquisa de jurisprudência
- Gestão de riscos legais

### Comportamento
- Sempre cite legislação e jurisprudência relevantes
- Use linguagem técnica apropriada
- Identifique e documente riscos
- Sugira mitigações para cada risco
- Mantenha confidencialidade absoluta

### Saudação
"⚖️ Ralph Legal Orchestrator ready. I help you analyze and create legal documents with precision. Type `*help` for commands."

### Disclaimer
"AVISO: Este sistema auxilia na elaboração de documentos jurídicos, mas não substitui a análise de um advogado habilitado. Todos os documentos devem ser revisados por profissional competente antes do uso."
```

---

### Área: Contábil (Nova)

```yaml
# ralph/areas/accounting/area.yaml

name: accounting
displayName: "Contábil & Fiscal"
icon: 📊
description: "Orquestração autônoma para análises contábeis e fiscais"

delegation: "./delegation.yaml"
quality_gates: "./quality-gates.yaml"
persona: "./persona.md"
knowledge: "./knowledge/"

skills:
  - fiscal-agent
  - analista-agent
  - auditor-agent

settings:
  gitEnabled: false
  outputFormat: "xlsx"
  confidential: true
  reviewRequired: true
```

```yaml
# ralph/areas/accounting/delegation.yaml

tax_stories:
  keywords:
    - "imposto"
    - "fiscal"
    - "tributo"
    - "IRPJ"
    - "ICMS"
    - "ISS"
    - "simples"
    - "lucro presumido"
  skill_name: "fiscal-agent"
  agent_name: "Tax Expert"
  announce: "💰 Delegating to Tax Expert..."

analysis_stories:
  keywords:
    - "balanço"
    - "DRE"
    - "fluxo de caixa"
    - "análise financeira"
    - "indicadores"
    - "relatório"
  skill_name: "analista-agent"
  agent_name: "Financial Analyst"
  announce: "📈 Delegating to Financial Analyst..."

audit_stories:
  keywords:
    - "auditoria"
    - "compliance"
    - "conformidade"
    - "revisão"
    - "verificação"
  skill_name: "auditor-agent"
  agent_name: "Auditor"
  announce: "🔍 Delegating to Auditor..."

planning_stories:
  keywords:
    - "planejamento tributário"
    - "elisão"
    - "economia fiscal"
    - "regime tributário"
  skill_name: "fiscal-agent"
  agent_name: "Tax Expert"
  announce: "📋 Delegating to Tax Planner..."
```

```yaml
# ralph/areas/accounting/quality-gates.yaml

accuracy:
  name: "Precisão Numérica"
  checks:
    - id: calculations
      description: "Cálculos conferidos"
      manual: true
    - id: reconciliation
      description: "Valores reconciliados"
      manual: true
    - id: no_rounding_errors
      description: "Sem erros de arredondamento"
      manual: true

compliance:
  name: "Conformidade"
  checks:
    - id: legislation
      description: "Conforme legislação vigente"
      manual: true
    - id: standards
      description: "Conforme normas contábeis (CPC/IFRS)"
      manual: true
    - id: deadlines
      description: "Prazos fiscais considerados"
      manual: true

documentation:
  name: "Documentação"
  checks:
    - id: sources
      description: "Fontes documentadas"
      manual: true
    - id: audit_trail
      description: "Trilha de auditoria mantida"
      manual: true
```

```markdown
# ralph/areas/accounting/persona.md

## Persona: Accounting Orchestrator

Você é o **Ralph**, um orquestrador autônomo especializado em contabilidade e análise fiscal.

### Sua Identidade
- **Papel**: Autonomous Accounting Loop Orchestrator
- **Estilo**: Preciso, metódico, orientado a compliance
- **Foco**: Produzir análises contábeis precisas e em conformidade

### Conhecimentos Específicos
- Contabilidade Geral e Societária
- Legislação Tributária Brasileira
- Normas CPC/IFRS
- Análise de Demonstrações Financeiras
- Planejamento Tributário

### Comportamento
- Sempre confira cálculos duas vezes
- Cite legislação e normas aplicáveis
- Mantenha trilha de auditoria
- Considere prazos fiscais
- Documente premissas utilizadas

### Saudação
"📊 Ralph Accounting Orchestrator ready. I help you with accounting analysis and tax planning. Type `*help` for commands."

### Disclaimer
"AVISO: Este sistema auxilia em análises contábeis e fiscais, mas não substitui o trabalho de um contador habilitado. Todas as análises devem ser validadas por profissional competente."
```

---

### Fluxo de Carregamento

```
┌─────────────────────────────────────────────────────────────┐
│                    RALPH STARTUP                            │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
                ┌─────────────────┐
                │  Lê prd.json    │
                │  Detecta "area" │
                └────────┬────────┘
                         │
            ┌────────────┼────────────┐
            │            │            │
            ▼            ▼            ▼
      area: "dev"  area: "marketing"  area: "legal"
            │            │            │
            ▼            ▼            ▼
    ┌───────────┐  ┌───────────┐  ┌───────────┐
    │ Load      │  │ Load      │  │ Load      │
    │ areas/dev │  │ areas/    │  │ areas/    │
    │           │  │ marketing │  │ legal     │
    └─────┬─────┘  └─────┬─────┘  └─────┬─────┘
          │              │              │
          ▼              ▼              ▼
    ┌───────────────────────────────────────┐
    │          Ralph Core Loop              │
    │                                        │
    │  1. Load area config                  │
    │  2. Adopt area persona                │
    │  3. Find next story                   │
    │  4. Match keywords → delegation       │
    │  5. Invoke specialist skill           │
    │  6. Validate against quality gates    │
    │  7. Update progress                   │
    │  8. Repeat until COMPLETE             │
    │                                        │
    └───────────────────────────────────────┘
```

### Exemplo de Uso

```bash
# Projeto de desenvolvimento
cat > meu-saas/prd.json << 'EOF'
{
  "project": "Feature Login",
  "area": "dev",
  "userStories": [...]
}
EOF
./ralph.sh meu-saas/
# → Carrega areas/dev/
# → Delega para dev-agent, qa-agent...

# Projeto de marketing
cat > campanha-bf/prd.json << 'EOF'
{
  "project": "Black Friday Campaign",
  "area": "marketing",
  "userStories": [...]
}
EOF
./ralph.sh campanha-bf/
# → Carrega areas/marketing/
# → Delega para copywriter-agent, ads-agent...

# Projeto jurídico
cat > contrato-cliente/prd.json << 'EOF'
{
  "project": "Contrato de Prestação de Serviços",
  "area": "legal",
  "userStories": [...]
}
EOF
./ralph.sh contrato-cliente/
# → Carrega areas/legal/
# → Delega para contratos-agent...
```

### Compatibilidade com Ralph Atual

Para manter compatibilidade com projetos existentes que não têm campo `area`:

```yaml
# ralph-core.md
area_detection:
  # Se prd.json não tem "area", assume "dev"
  default: "dev"

  # Fallback: detecta pelo conteúdo
  auto_detect:
    dev:
      - presence_of: ["package.json", "tsconfig.json", ".git"]
      - keywords: ["implement", "code", "API"]
    marketing:
      - presence_of: ["brand.json", "audience.json"]
      - keywords: ["copy", "campaign", "headline"]
    legal:
      - presence_of: ["case.json", "client.json"]
      - keywords: ["contract", "clause", "legal"]
```

---

## Próximos Passos

1. **Refatorar Core** - Extrair motor compartilhado do Auto-Claude
2. **Criar plugin dev** - Migrar Auto-Claude para formato plugin
3. **Criar plugin marketing** - Primeiro plugin não-dev
4. **Documentar SDK** - API para criação de plugins
5. **UI de seleção** - Interface para escolher/trocar plugins

---

## Referências

- **Auto-Claude**: `.auto-claude/` - Código original de desenvolvimento
- **Ralph**: `ralph/` - Sistema de orquestração autônoma
- **.stack**: `.stack/` - Infraestrutura de pipeline
- **AIOS Core**: `aios-core/` - Framework de referência (pode remover)

---

*Sleep Agent - Arquitetura de Plugins v1.0*
*Documento criado para planejamento e referência futura*
