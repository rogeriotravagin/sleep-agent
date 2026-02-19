# FAQ - Perguntas Frequentes

## Geral

### O que é o Sleep Agent?

É um framework que transforma o Claude Code em um assistente com agentes especializados. Pense nele como um "prompt system" avançado que organiza conhecimento e processos para diferentes áreas profissionais.

### Preciso saber programar?

Não. O Sleep Agent foi feito para profissionais não-técnicos. Você só precisa saber digitar comandos e descrever o que precisa.

### O que preciso ter instalado?

Apenas o Claude Code. O Sleep Agent não tem dependências adicionais.

### É gratuito?

O Sleep Agent é gratuito. Você só precisa de acesso ao Claude Code (que pode ter custos dependendo do seu plano).

---

## Uso

### Como ativo uma extensão?

Digite o comando da extensão:
```
/marketing
```

### Preciso usar comandos ou posso escrever livremente?

As duas formas funcionam. Comandos são atalhos para tarefas específicas, mas você pode simplesmente descrever o que precisa em linguagem natural.

### Como sei qual agente está ativo?

Use `/status` para ver qual extensão e agente estão ativos no momento.

### Posso usar mais de uma extensão ao mesmo tempo?

Por enquanto, apenas uma extensão fica ativa por vez. Para trocar, ative outra extensão.

### Onde ficam salvos meus trabalhos?

Na pasta `projetos/`. Cada arquivo tem um nome descritivo baseado no que foi criado.

---

## Marketing

### Quais agentes estão disponíveis?

- **Copywriter** (`/copy`): Headlines, emails, textos de venda
- **Estrategista** (`/estrategia`): Ofertas, posicionamento, análise
- **Tráfego** (`/ads`): Anúncios, campanhas, segmentação

### O que é uma tarefa?

Tarefa é um fluxo estruturado para produzir um resultado específico. Por exemplo, `/criar-headline` é uma tarefa que guia você por perguntas e entrega headlines prontas.

### O que é um workflow?

Workflow é uma sequência de tarefas para um projeto maior. Por exemplo, `/lancamento` executa várias tarefas em ordem para preparar um lançamento completo.

### Posso adicionar meu próprio conhecimento?

Sim! Você pode:
- Adicionar arquivos em `extensoes/marketing/conhecimento/`
- Criar novos exemplos em `extensoes/marketing/exemplos/`
- Modificar os arquivos existentes

---

## Problemas

### O Claude não está se comportando como Sleep Agent

Verifique se:
1. Você está na pasta correta (`sleep_agent/`)
2. O arquivo `.claude/CLAUDE.md` existe
3. O Claude Code está atualizado

### O resultado não ficou bom

Tente:
1. Dar mais contexto
2. Ser mais específico no pedido
3. Pedir variações: "Me dê mais 3 opções"
4. Pedir ajustes: "Faça mais curta" ou "Com mais urgência"

### Comando não reconhecido

Verifique se:
1. A extensão está ativada (`/marketing`)
2. O comando está correto (veja `/ajuda`)

### Quero recomeçar a conversa

Feche o Claude Code e abra novamente. Cada sessão começa limpa.

---

## Avançado

### Posso criar minha própria extensão?

Sim! Siga a estrutura da extensão de marketing como modelo:
1. Crie pasta em `extensoes/sua-extensao/`
2. Crie `extensao.yaml` com configuração
3. Adicione agentes, tarefas, conhecimento

### Posso modificar os agentes existentes?

Sim. Os arquivos de agentes são Markdown simples. Edite conforme necessário.

### Como adiciono uma nova tarefa?

1. Copie um arquivo de tarefa existente em `extensoes/marketing/tarefas/`
2. Modifique conforme sua necessidade
3. Adicione a referência no `extensao.yaml`

### O conhecimento é usado automaticamente?

Sim. Os agentes são instruídos a consultar os arquivos de conhecimento relevantes ao executar tarefas.

---

## Não encontrou sua resposta?

Abra uma issue no repositório ou descreva seu problema para o Sleep Agent - ele pode ajudar!
