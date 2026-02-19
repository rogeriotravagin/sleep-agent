# Extensão TI - Time de Integrações e Automações

## Visão Geral

A **Extensão TI** é um time especializado em criar integrações com APIs e automações com ferramentas como Playwright. Nossa missão é **traduzir necessidades de profissionais não-técnicos em soluções técnicas claras**, focando em automatizar processos manuais do dia a dia.

## Para Quem É

- Profissionais não-técnicos com processos manuais repetitivos
- Pessoas que precisam integrar sistemas diferentes
- Equipes que perdem tempo com tarefas que poderiam ser automatizadas
- Quem tem processos manuais mas nem sabe que tecnologia pode ajudar

## O Que Fazemos

### 🔍 Entendemos Seu Processo
- Conversamos em linguagem clara, sem jargões técnicos
- Fazemos as perguntas certas para entender seu cenário
- Identificamos onde tecnologia pode ajudar

### 💡 Propomos Soluções
- Explicamos a solução de forma simples
- Mostramos benefícios e esforço necessário
- Validamos com você antes de começar

### 🔧 Desenvolvemos
- **Integrações com APIs**: Conectamos sistemas diferentes automaticamente
- **Automações Web**: Criamos robôs que fazem tarefas repetitivas no navegador
- **Scripts Personalizados**: Desenvolvemos soluções específicas para seu caso

### 📚 Documentamos Tudo
- Manuais em linguagem não-técnica
- Explicação clara de como usar
- Documentação do que foi feito

## Problemas Que Resolvemos

✅ Processos manuais repetitivos e demorados
✅ Falta de integração entre sistemas diferentes
✅ Dificuldade em buscar informações de APIs
✅ Barreira técnica para implementar automações simples
✅ Perda de tempo com tarefas que poderiam ser automatizadas

## Como Funciona

### 1️⃣ Você Nos Conta Seu Processo
Não precisa saber termos técnicos. Apenas descreva o que você faz manualmente hoje.

### 2️⃣ Fazemos Perguntas Claras
Perguntamos o que precisamos saber de forma que você consiga responder facilmente.

### 3️⃣ Propomos Solução em Linguagem Simples
Explicamos o que faremos, como funcionará e quais os benefícios.

### 4️⃣ Criamos a Automação/Integração
Desenvolvemos a solução técnica.

### 5️⃣ Validamos Juntos
Testamos e garantimos que atende sua necessidade.

### 6️⃣ Entregamos Documentado
Você recebe tudo funcionando + manual em linguagem clara.

## Comandos Disponíveis

### Principais
- `/ti` - Carregar extensão TI
- `/automacao-completa` - Criar automação do zero
- `/api-rapida` - Integrar com API rapidamente
- `/automacao-rapida` - Criar automação web rapidamente

### Por Fase
#### Descoberta
- `/analisar-processo` - Analisar processo manual atual
- `/questionar-cliente` - Fazer perguntas para entender cenário

#### Proposta
- `/propor-solucao` - Apresentar solução em linguagem clara
- `/analisar-viabilidade` - Avaliar viabilidade técnica

#### Desenvolvimento
- `/integrar-api` - Criar integração com API
- `/criar-automacao` - Desenvolver script Playwright

#### Entrega
- `/documentar` - Criar documentação não-técnica
- `/validar` - Validar solução com cliente

## Agentes do Time

### 👤 Analista de Processos (`/analista-processos`)
**O que faz:** Conversa com você, entende seu processo atual, identifica onde tecnologia pode ajudar

**Especialidades:**
- Análise de processos manuais
- Tradução de necessidades em requisitos técnicos
- Comunicação clara com não-técnicos
- Levantamento de requisitos

### 🔌 Especialista em Integrações (`/especialista-integracoes`)
**O que faz:** Cria integrações com APIs, conecta sistemas diferentes

**Especialidades:**
- APIs REST e GraphQL
- Autenticação (OAuth, API Keys, JWT)
- Webhooks
- Mapeamento de dados entre sistemas

### 🤖 Engenheiro de Automação (`/engenheiro-automacao`)
**O que faz:** Cria robôs que automatizam tarefas no navegador

**Especialidades:**
- Playwright e automação web
- Web scraping
- Manipulação de formulários
- Scripts Python e JavaScript

## Exemplos de Uso

### Exemplo 1: Automatizar Preenchimento de Formulários
**Cenário:** "Todo dia preciso copiar dados de uma planilha e colar em 50 formulários web"

**Solução:** Criamos automação Playwright que:
1. Lê a planilha
2. Abre os formulários automaticamente
3. Preenche todos os campos
4. Envia os formulários
5. Gera relatório do que foi feito

### Exemplo 2: Integrar Sistema de Vendas com CRM
**Cenário:** "Quando vendo no site, preciso copiar manualmente para o CRM"

**Solução:** Criamos integração via API que:
1. Detecta venda no sistema
2. Cria automaticamente registro no CRM
3. Sincroniza informações do cliente
4. Notifica equipe

### Exemplo 3: Buscar Dados de API Periodicamente
**Cenário:** "Preciso consultar preços de produtos na API do fornecedor todo dia"

**Solução:** Criamos script que:
1. Consulta API automaticamente
2. Atualiza planilha com preços
3. Alerta se houver mudanças significativas
4. Gera relatório comparativo

## Base de Conhecimento

Nossa equipe tem conhecimento documentado sobre:
- APIs REST (como funcionam, como usar)
- Playwright (automação de navegador)
- Análise de processos (como mapear e otimizar)
- Comunicação com não-técnicos (como explicar tecnologia de forma simples)
- Boas práticas de automação (como criar soluções robustas)
- Autenticação em APIs (OAuth, tokens, etc)
- Tratamento de erros (como lidar com problemas)

## Nossos Princípios

### 📢 Comunicação Clara
- Sempre usamos linguagem não-técnica
- Explicamos conceitos através de analogias do dia a dia
- Validamos se você entendeu antes de continuar

### ❓ Perguntas Inteligentes
- Fazemos perguntas que você consegue responder
- Explicamos POR QUE precisamos de cada informação
- Orientamos COMO você pode obter dados que não tem

### ✅ Validação Constante
- Não assumimos nada
- Validamos entendimento em cada etapa
- Você aprova antes de começarmos a desenvolver

### 📝 Documentação Acessível
- Tudo é documentado em linguagem simples
- Criamos manuais que você consegue usar sozinho
- Explicamos o que foi feito e por quê

## Estrutura da Extensão

```
extensoes/ti/
├── extensao.yaml              # Configuração da extensão
├── README.md                  # Este arquivo
├── .claude/
│   └── CLAUDE.md              # Instruções específicas
├── core/
│   ├── orquestrador/
│   │   └── delegacao.yaml     # Regras de delegação
│   └── templates/             # Templates reutilizáveis
├── agentes/
│   ├── ANALISTA-PROCESSOS.md
│   ├── ESPECIALISTA-INTEGRACOES.md
│   └── ENGENHEIRO-AUTOMACAO.md
├── conhecimento/              # Base de conhecimento
│   ├── apis-rest.md
│   ├── playwright-basico.md
│   ├── analise-processos.md
│   ├── comunicacao-nao-tecnicos.md
│   └── boas-praticas-automacao.md
├── tarefas/                   # Definições de tarefas
│   ├── analisar-processo.yaml
│   ├── propor-solucao.yaml
│   ├── integrar-api.yaml
│   └── criar-automacao.yaml
├── workflows/                 # Fluxos de trabalho
│   ├── automacao-completa.yaml
│   ├── integracao-api-rapida.yaml
│   └── automacao-web-rapida.yaml
└── exemplos/                  # Exemplos práticos
    ├── exemplo-api.py
    └── exemplo-playwright.js
```

## Saídas

As entregas são organizadas no seu workspace:

```
workspace/[sua-empresa]/ti/
├── scripts/       # Scripts criados
├── docs/          # Documentação
├── analises/      # Análises de processos
└── propostas/     # Propostas de solução
```

## Começar a Usar

1. **Carregar extensão:** `/ti`
2. **Descrever seu processo manual** em suas palavras
3. **Responder nossas perguntas** (sempre claras e simples)
4. **Aprovar proposta** que apresentaremos
5. **Receber solução** funcionando + documentação

## Importante Lembrar

- ✅ Você NÃO precisa saber termos técnicos
- ✅ Nossas perguntas sempre terão contexto claro
- ✅ Validamos tudo com você antes de fazer
- ✅ Tudo é documentado de forma que você entenda
- ✅ Focamos em resolver SEU problema específico

## Contato

Para começar, basta digitar `/ti` e nos contar o que você precisa automatizar!

---

**Versão:** 1.0
**Status:** Ativo
**Última atualização:** 2026-02-02
