# Permissions - Modos de Permissao de Agentes

O sistema de permissoes permite controle granular de autonomia por agente ou extensao. Voce decide o quanto cada agente pode fazer sozinho.

---

## Por que Modos de Permissao?

No v4, todos os agentes tinham o mesmo nivel de autonomia. Nao era possivel dizer "quero que o copywriter crie sem perguntar, mas o estrategista sempre confirme comigo". Resultado: ou tudo era interativo (lento) ou tudo era autonomo (arriscado).

Com 3 modos, voce controla exatamente o nivel de liberdade de cada agente.

---

## Os 3 Modos

### Explorar

O agente so pode ler e analisar. Nao produz entregas nem faz alteracoes.

**Quando usar:**
- Quer que o agente estude algo antes de agir
- Esta investigando um problema e quer analises
- Nao quer nenhuma mudanca no workspace

**O que pode fazer:**
- Ler arquivos do workspace
- Consultar memoria e blackboard
- Analisar dados e apresentar conclusoes

**O que NAO pode fazer:**
- Salvar entregas
- Atualizar memoria
- Chamar APIs externas
- Executar scripts

**Exemplo:** "Quero que o Estrategista analise meu mercado, mas nao defina nada ainda"

---

### Confirmar (Padrao)

O agente produz mas pede confirmacao antes de salvar ou executar. Este e o modo padrao do sistema.

**Quando usar:**
- Uso normal do dia a dia
- Quando quer revisar antes de aprovar
- Para tarefas que envolvem decisoes importantes

**O que pode fazer (com confirmacao):**
- Criar entregas e pedir aprovacao
- Sugerir atualizacoes na memoria
- Propor chamadas a APIs externas
- Sugerir execucao de scripts

**Fluxo:**
1. Agente cria a entrega
2. Apresenta ao usuario
3. Usuario aprova, pede ajustes ou rejeita
4. Se aprovado, salva e continua

**Exemplo:** "Crie a headline e me mostre antes de salvar"

---

### Autonomo

O agente opera livremente. Produz, salva e segue para a proxima tarefa sem perguntar.

**Quando usar:**
- Para tarefas repetitivas onde voce ja confia no agente
- Para workflows em lote (criar 10 emails de uma vez)
- Quando a velocidade e mais importante que a revisao

**O que pode fazer:**
- Tudo do modo Confirmar, sem pedir aprovacao
- Salvar entregas automaticamente
- Atualizar memoria automaticamente
- Chamar APIs e executar scripts

**Restricoes que SEMPRE se aplicam (mesmo no modo autonomo):**
- Constituicao: artigos NON_NEGOTIABLE nunca sao violados
- Blackboard: sempre atualizado apos cada entrega
- Log de compliance: toda acao registrada
- Quality Gates nivel 1: verificacoes automaticas sempre rodam

**Exemplo:** "O Copywriter ja acertou 10 headlines seguidas, pode operar livre"

---

## Configuracao

### Padrao Global

Todo o sistema comeca no modo **Confirmar**. Voce muda por extensao ou agente.

### Por Extensao

Mudar o modo de todos os agentes de uma extensao:

```
/modo explorar marketing    → Toda extensao em modo explorar
/modo autonomo marketing    → Toda extensao em modo autonomo
/modo confirmar marketing   → Reset para confirmar
```

### Por Agente

Mudar o modo de um agente especifico (sobrescreve configuracao da extensao):

```
/modo autonomo copywriter   → Copywriter em modo autonomo
/modo explorar estrategista → Estrategista em modo explorar
```

### Reset Global

```
/modo confirmar             → Reset de TUDO para confirmar
```

---

## Integracao com o Sistema

### Com o Orquestrador
- Ao delegar tarefa, o orquestrador verifica o modo do agente
- Se modo Explorar: passa apenas capacidade de leitura
- Se modo Confirmar: apresenta resultado antes de salvar
- Se modo Autonomo: salva e segue automaticamente

### Com a Constituicao
- Modo Autonomo NAO sobrescreve artigos NON_NEGOTIABLE
- Se uma acao autonoma violar a constituicao, e bloqueada (enforcement BLOCK)
- Modo Autonomo + constituicao = "liberdade com limites"

### Com Quality Gates
- Modo Explorar: nao ha entregas, nao ha gates
- Modo Confirmar: todos os 3 niveis de gates
- Modo Autonomo: nivel 1 (automatico) sempre roda, niveis 2 e 3 opcionais

### Com a Configuracao em Camadas
- Permissoes sao configuradas na camada L2 (workspace) ou L3 (usuario)
- Overrides de sessao (L4) podem mudar temporariamente
- L0 (constituicao) nunca e afetada

---

## Seguranca

### Acoes que SEMPRE requerem confirmacao (independente do modo)

Mesmo no modo Autonomo, estas acoes SEMPRE pedem confirmacao:

1. **Deletar arquivos** do workspace
2. **Chamar APIs destrutivas** (cancelar assinatura, revogar acesso)
3. **Enviar mensagens** para clientes (email, WhatsApp)
4. **Alterar configuracoes** do sistema
5. **Executar scripts** que modificam dados externos

Estas acoes estao protegidas pela Constituicao (Artigo III - Privacidade e Seguranca).

---

## Persistencia

A configuracao de modos e persistida em:

| Local | Escopo | Duracao |
|-------|--------|---------|
| `workspace/.config/user-preferences.yaml` | Permanente | Persiste entre sessoes |
| `workspace/.state/session-overrides.yaml` | Temporario | Apenas esta sessao |
| `kernel/permissions/modes.yaml` | Definicao | Referencia dos modos |

---

## Arquivos

| Arquivo | Funcao |
|---------|--------|
| `kernel/permissions/PERMISSIONS.md` | Este documento |
| `kernel/permissions/modes.yaml` | Definicao dos 3 modos e configuracao |

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/modo` | Ver modo atual de todos os agentes |
| `/modo explorar {extensao\|agente}` | Mudar para modo explorar |
| `/modo confirmar {extensao\|agente}` | Mudar para modo confirmar |
| `/modo autonomo {extensao\|agente}` | Mudar para modo autonomo |
| `/modo confirmar` | Reset global para confirmar |
