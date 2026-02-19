# 🧭 Navegação - Extensão Deploy

Guia rápido para encontrar o que você precisa.

---

## 📚 Documentação Principal

| Documento | Quando Usar | Tempo |
|-----------|-------------|-------|
| **[SETUP.md](SETUP.md)** | Primeira vez - configurar conta e token | 10-15 min |
| **[QUICK-START.md](QUICK-START.md)** | Fazer primeiro deploy | 5 min |
| **[README.md](README.md)** | Referência completa de comandos | Consulta |

---

## 🎯 Começando do Zero

### Você é novo aqui? Siga esta ordem:

```
1️⃣  SETUP.md
    └─→ Criar conta Vercel
    └─→ Obter token de API
    └─→ Instalar ferramentas
    └─→ Testar configuração

2️⃣  QUICK-START.md
    └─→ Fazer primeiro deploy
    └─→ Ver site no ar
    └─→ Adicionar domínio (opcional)

3️⃣  README.md
    └─→ Explorar comandos avançados
    └─→ Configurar automação
    └─→ Troubleshooting
```

---

## 🚀 Já Configurado?

### Ações Rápidas

| Quero... | Comando |
|----------|---------|
| Fazer deploy | `/deploy` |
| Gerar preview | `/preview` |
| Adicionar domínio | `/domains add meudominio.com` |
| Ver status | `/deploy-status` |
| Listar domínios | `/domains list` |

**Referência Completa:** [README.md](README.md#-comandos-disponíveis)

---

## 📖 Por Tipo de Conteúdo

### Guias Passo a Passo

- **[SETUP.md](SETUP.md)** - Setup inicial completo
- **[QUICK-START.md](QUICK-START.md)** - Primeiro deploy
- **[conhecimento/providers-guide.md](conhecimento/providers-guide.md)** - Comparação de providers

### Referência Técnica

- **[.claude/CLAUDE.md](.claude/CLAUDE.md)** - Instruções para o agente
- **[core/orquestrador/delegacao.yaml](core/orquestrador/delegacao.yaml)** - Regras de delegação
- **[extensao.yaml](extensao.yaml)** - Manifesto da extensão

### Agentes

- **[agentes/deploy-engineer.md](agentes/deploy-engineer.md)** - Executar deploys
- **[agentes/dns-specialist.md](agentes/dns-specialist.md)** - Configurar domínios
- **[agentes/qa-validator.md](agentes/qa-validator.md)** - Validar deploys

### Tarefas

- **[tarefas/executar-deploy.md](tarefas/executar-deploy.md)** - Task de deploy
- **[tarefas/configurar-dominio.md](tarefas/configurar-dominio.md)** - Task de domínio

### Scripts

- **[scripts/verify-setup.sh](scripts/verify-setup.sh)** - Verificar configuração
- **[scripts/deploy.sh](scripts/deploy.sh)** - Deploy via script
- **[scripts/configure-domain.sh](scripts/configure-domain.sh)** - Domínio via script
- **[scripts/validate.sh](scripts/validate.sh)** - Validar deploy

---

## 🔍 Por Problema

### "Não sei por onde começar"
→ **[SETUP.md](SETUP.md)** - Começa do zero, explica tudo

### "Não tenho conta Vercel"
→ **[SETUP.md](SETUP.md#1%EF%B8%8F⃣-criar-conta-na-vercel)** - Seção 1

### "Não sei como pegar token"
→ **[SETUP.md](SETUP.md#2%EF%B8%8F⃣-obter-token-de-api-da-vercel)** - Seção 2

### "Token não funciona"
→ **[SETUP.md](SETUP.md#-troubleshooting)** - Troubleshooting

### "Deploy falhou"
→ **[README.md](README.md#-troubleshooting)** - Troubleshooting técnico

### "DNS não propaga"
→ **[README.md](README.md#dns-não-propaga)** - Solução DNS

### "Quero comparar providers"
→ **[conhecimento/providers-guide.md](conhecimento/providers-guide.md)** - Comparação

### "Como funciona por trás?"
→ **[.claude/CLAUDE.md](.claude/CLAUDE.md)** - Arquitetura interna

---

## 🎓 Por Nível de Experiência

### Iniciante (Nunca fez deploy)
1. **[SETUP.md](SETUP.md)** - Setup completo
2. **[QUICK-START.md](QUICK-START.md)** - Primeiro deploy
3. Prática: Fazer 2-3 deploys de teste

### Intermediário (Já fez alguns deploys)
1. **[README.md](README.md)** - Explorar comandos avançados
2. **[conhecimento/providers-guide.md](conhecimento/providers-guide.md)** - Otimizar provider
3. Configurar domínio customizado
4. Setup de CI/CD

### Avançado (Quer customizar/automatizar)
1. **[agentes/](agentes/)** - Entender agentes
2. **[core/orquestrador/delegacao.yaml](core/orquestrador/delegacao.yaml)** - Regras de delegação
3. **[scripts/](scripts/)** - Scripts de automação
4. Criar workflows customizados

---

## 🎯 Checklists

### Checklist: Setup Inicial

- [ ] Conta Vercel criada
- [ ] Token de API gerado
- [ ] Token salvo em `.env`
- [ ] `.gitignore` configurado
- [ ] Node.js instalado
- [ ] Vercel CLI instalado
- [ ] Teste de autenticação passou
- [ ] Deploy de teste funcionou

**Ver:** [SETUP.md](SETUP.md#-checklist-final)

### Checklist: Pré-Deploy

- [ ] `index.html` existe
- [ ] HTML válido
- [ ] Imagens/assets existem
- [ ] Token configurado
- [ ] Vercel CLI instalado

**Ver:** [QUICK-START.md](QUICK-START.md#-checklist-pré-deploy)

### Checklist: Deploy com Domínio

- [ ] Domínio comprado
- [ ] Acesso ao painel DNS
- [ ] Registros DNS configurados
- [ ] DNS propagou (usar whatsmydns.net)
- [ ] HTTPS ativo
- [ ] Site acessível pelo domínio

---

## 🆘 Ajuda Rápida

### Comando deu erro?

1. Execute o script de verificação:
   ```bash
   cd extensoes/deploy/scripts
   chmod +x verify-setup.sh
   ./verify-setup.sh
   ```

2. Se persistir, consulte:
   - **[SETUP.md - Troubleshooting](SETUP.md#-troubleshooting)**
   - **[README.md - Troubleshooting](README.md#-troubleshooting)**

### Precisa de ajuda humana?

- **GitHub Issues:** (link do repositório)
- **Documentação Vercel:** https://vercel.com/docs
- **Suporte Vercel:** https://vercel.com/support

---

## 📊 Estrutura da Extensão

```
extensoes/deploy/
├── 📄 NAVEGACAO.md          ← Você está aqui!
├── 📘 SETUP.md              ← Setup inicial (primeira vez)
├── 🚀 QUICK-START.md        ← Primeiro deploy
├── 📖 README.md             ← Referência completa
├── 📋 extensao.yaml         ← Manifesto
│
├── .claude/
│   └── CLAUDE.md            ← Instruções para o agente
│
├── agentes/                 ← Agentes especializados
│   ├── deploy-engineer.md
│   ├── dns-specialist.md
│   └── qa-validator.md
│
├── core/
│   ├── orquestrador/
│   │   └── delegacao.yaml   ← Regras de delegação
│   └── templates/
│       └── deploy-config-template.yaml
│
├── tarefas/                 ← Definições de tarefas
│   ├── executar-deploy.md
│   └── configurar-dominio.md
│
├── scripts/                 ← Scripts de automação
│   ├── verify-setup.sh      ← Verificar configuração
│   ├── deploy.sh
│   ├── configure-domain.sh
│   └── validate.sh
│
└── conhecimento/            ← Base de conhecimento
    └── providers-guide.md
```

---

## 🎯 Fluxo de Uso Típico

```
📍 VOCÊ ESTÁ AQUI
    │
    ├─→ Primeira Vez?
    │   └─→ [SETUP.md] → [QUICK-START.md] → [README.md]
    │
    ├─→ Já Configurado?
    │   └─→ [QUICK-START.md] → Usar comandos diretamente
    │
    ├─→ Precisa de Ajuda?
    │   └─→ [README.md - Troubleshooting]
    │
    └─→ Quer Customizar?
        └─→ [agentes/] + [core/] + [scripts/]
```

---

**💡 Dica:** Salve este arquivo nos favoritos para acesso rápido!
