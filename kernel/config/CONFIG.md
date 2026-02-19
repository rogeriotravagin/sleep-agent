# Config - Sistema de Configuracao em Camadas

O Sleep Agent usa um sistema de configuracao em 5 camadas com precedencia clara. Camadas superiores sobrescrevem inferiores, exceto L0 (constituicao) que nunca e sobrescrita.

---

## Por que 5 Camadas?

No v4, havia um unico arquivo de configuracao (`sleep-agent.yaml`). Se o usuario queria algo temporario (desabilitar um gate para teste rapido), precisava editar o arquivo e lembrar de reverter depois. Nao havia conceito de "preferencia pessoal" separada de "configuracao do projeto".

Com 5 camadas, cada tipo de configuracao tem seu lugar e sua duracao.

---

## As 5 Camadas

```
L0: Constituicao (IMUTAVEL)
    ↑ nunca sobrescrita
L1: Framework (padroes do sistema)
    ↑ sobrescrita por L2
L2: Workspace (configuracao do projeto)
    ↑ sobrescrita por L3
L3: Usuario (preferencias pessoais)
    ↑ sobrescrita por L4
L4: Sessao (overrides temporarios)
```

---

### L0: Constituicao

**Descricao:** Regras imutaveis do sistema
**Arquivo:** `kernel/constitution/constitution.yaml`
**Editavel:** NAO
**Duracao:** Permanente, nunca alterada por outras camadas

Artigos NON_NEGOTIABLE com enforcement BLOCK. Nenhuma outra camada pode sobrescrever.

**Exemplos:**
- Privacidade e seguranca de dados
- Autoridade de dominio dos agentes
- Transparencia operacional

---

### L1: Framework

**Descricao:** Configuracoes padrao do Sleep Agent
**Arquivo:** `kernel/config/framework-defaults.yaml` (implicito no sistema)
**Editavel:** NAO (e o padrao do sistema)
**Duracao:** Permanente

Sao os valores "de fabrica". Se nada for configurado, estes sao os valores usados.

**Valores padrao:**
- Quality Gates: todos os 3 niveis habilitados
- Memoria: hierarquica com decaimento exponencial
- Matching: confianca minima de 60%
- Context Brackets: habilitados
- Modo de permissao: Confirmar
- Tool Registry: descoberta automatica habilitada

---

### L2: Workspace

**Descricao:** Configuracao do projeto atual
**Arquivo:** `workspace/.config/sleep-agent.yaml`
**Editavel:** SIM (via `/setup` ou manual)
**Duracao:** Persiste enquanto o workspace existir

Configuracoes especificas deste projeto. Compartilhadas entre todos os usuarios do workspace.

**Exemplos:**
- Extensoes ativas e seus agentes
- Estrutura do workspace (holding/empresa/produto)
- Ferramentas configuradas e credenciais disponiveis
- Quality Gates customizados por tipo de tarefa

---

### L3: Usuario

**Descricao:** Preferencias pessoais do usuario
**Arquivo:** `workspace/.config/user-preferences.yaml`
**Editavel:** SIM (via `/preferencias` ou manual)
**Duracao:** Persiste entre sessoes

Preferencias que variam por pessoa, nao por projeto.

**Exemplos:**
- Tom de interacao preferido (direto, detalhado, etc.)
- Modos de permissao por agente
- Emojis habilitados ou nao
- Nivel de detalhe nas respostas
- Idioma de interface

---

### L4: Sessao

**Descricao:** Overrides temporarios para esta sessao
**Arquivo:** `workspace/.state/session-overrides.yaml`
**Editavel:** SIM (via `/override` ou automatico)
**Duracao:** Apenas esta sessao. Removido ao encerrar.

Para mudancas rapidas que nao devem persistir.

**Exemplos:**
- Desabilitar gates para teste rapido
- Mudar modo de um agente temporariamente
- Ativar modo debug
- Forcar extensao especifica

---

## Resolucao de Configuracao

Quando o sistema precisa de um valor, busca na ordem L4 -> L3 -> L2 -> L1 -> L0:

```
Exemplo: quality_gates.nivel_2

L0: (nao define quality gates)
L1: quality_gates.nivel_2 = true     ← padrao
L2: quality_gates.nivel_2 = false    ← workspace desabilitou
L3: (nao define)
L4: (nao define)

Resultado: false (L2 sobrescreve L1)
```

```
Exemplo: privacidade

L0: privacidade = NON_NEGOTIABLE     ← constituicao
L4: privacidade = false              ← tentativa de override

Resultado: NON_NEGOTIABLE (L0 NUNCA sobrescrita)
```

**Metodo:** Deep merge com precedencia crescente (L4 > L3 > L2 > L1), exceto L0.

---

## Integracao com o Sistema

### Com o Orquestrador
- Ao iniciar sessao, resolve configuracao completa (merge das 5 camadas)
- Valor resolvido e usado em todas as decisoes

### Com os Modos de Permissao
- Modos podem ser definidos em L2 (workspace) ou L3 (usuario)
- L4 permite override temporario

### Com os Quality Gates
- Niveis de gate podem ser habilitados/desabilitados por camada
- Auto-calibracao respeita configuracao resolvida

### Com o Context Manager
- Brackets podem ser ajustados por camada
- Limites de carregamento configuraveis

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/config` | Ver configuracao resolvida (merge das 5 camadas) |
| `/config workspace` | Ver/editar configuracao L2 |
| `/preferencias` | Ver/editar preferencias L3 |
| `/override {chave} {valor}` | Criar override L4 para esta sessao |
| `/override limpar` | Remover todos os overrides L4 |

---

## Arquivos

| Arquivo | Camada | Funcao |
|---------|--------|--------|
| `kernel/constitution/constitution.yaml` | L0 | Regras imutaveis |
| `kernel/config/hierarchy.yaml` | - | Definicao da hierarquia |
| `kernel/config/CONFIG.md` | - | Este documento |
| `workspace/.config/sleep-agent.yaml` | L2 | Configuracao do projeto |
| `workspace/.config/user-preferences.yaml` | L3 | Preferencias pessoais |
| `workspace/.state/session-overrides.yaml` | L4 | Overrides temporarios |
