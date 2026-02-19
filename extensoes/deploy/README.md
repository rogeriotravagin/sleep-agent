# Extensão Deploy - Sleep Agent

Deploy automatizado de páginas e sites com configuração simplificada de domínios customizados.

## 🎯 Objetivo

Tornar o deploy de páginas e sites um processo simples onde usuários não-técnicos conseguem:
- Publicar páginas HTML em produção com um comando
- Configurar domínios customizados com orientação passo a passo
- Verificar automaticamente se tudo está funcionando
- Gerenciar múltiplos projetos e domínios

---

## ⚡ Início Rápido

### Primeira vez usando?

👉 **[SETUP COMPLETO](SETUP.md)** - Guia passo a passo para configurar tudo (10-15 min)

Inclui:
- ✅ Como criar conta Vercel (gratuita)
- ✅ Como obter token de API
- ✅ Como configurar o token no projeto
- ✅ Como instalar e testar tudo

### Já configurou tudo?

👉 **[QUICK START](QUICK-START.md)** - Faça seu primeiro deploy (5 min)

---

## 🚀 Comandos Disponíveis

### `/deploy`

Publica página ou site em produção.

```bash
# Deploy simples
/deploy

# Deploy com domínio
/deploy --domain meusite.com.br

# Preview apenas
/deploy --preview
```

### `/preview`

Gera URL temporária para cliente visualizar.

```bash
# Preview da branch atual
/preview

# Preview de branch específica
/preview --branch feature/nova-pagina
```

### `/domains`

Gerencia domínios customizados.

```bash
# Listar domínios
/domains list

# Adicionar domínio
/domains add meusite.com.br

# Verificar configuração
/domains verify meusite.com.br

# Remover domínio
/domains remove meusite.com.br
```

### `/deploy-status`

Verifica status do último deploy.

```bash
# Status básico
/deploy-status

# Com URL
/deploy-status --url
```

---

## 📦 Instalação

### 1. Instalar Provider

**Vercel (Recomendado):**
```bash
npm install -g vercel
vercel login
```

**Netlify:**
```bash
npm install -g netlify-cli
netlify login
```

### 2. Configurar Git

```bash
git init
git remote add origin https://github.com/usuario/projeto.git
```

### 3. Configurar Extensão

A extensão é detectada automaticamente pelo Sleep Agent. Basta usar os comandos!

---

## 🔧 Configuração Avançada

### Deploy Automático

Criar `.github/workflows/deploy.yml`:

```yaml
name: Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm install -g vercel
      - run: vercel --token ${{ secrets.VERCEL_TOKEN }} --prod
```

### Configuração de Domínio DNS Automática

Para automação 100%, configure credenciais da API:

**Cloudflare:**
```bash
export CLOUDFLARE_EMAIL="seu@email.com"
export CLOUDFLARE_API_KEY="sua-api-key"
```

**AWS Route 53:**
```bash
export AWS_ACCESS_KEY_ID="sua-key"
export AWS_SECRET_ACCESS_KEY="seu-secret"
```

---

## 🎯 Providers Suportados

| Provider | Deploy | DNS Manual | DNS API |
|----------|--------|------------|---------|
| **Vercel** | ✅ | ✅ | ❌ |
| **Netlify** | ✅ | ✅ | ❌ |
| **Cloudflare Pages** | ✅ | ✅ | ✅ |
| **GitHub Pages** | ✅ | ✅ | ❌ |

### Provedores DNS com API

Automação 100% disponível para:
- Cloudflare DNS
- AWS Route 53
- Google Cloud DNS
- Azure DNS

---

## 📖 Exemplos de Uso

### Exemplo 1: Primeiro Deploy

```bash
# Usuário
/deploy

# Sleep Agent
🔍 Verificando requisitos...
✅ Git: Configurado
✅ Remote: github.com/user/projeto
✅ Arquivos: index.html encontrado

🚀 Iniciando deploy...
✅ Commit criado
✅ Push para GitHub
✅ Build iniciado na Vercel

⏱️ Aguardando build... (15s)

🎉 Deploy concluído!
🔗 https://projeto-abc123.vercel.app

Deseja adicionar um domínio customizado?
```

### Exemplo 2: Deploy com Domínio

```bash
# Usuário
/deploy --domain vendas.meusite.com.br

# Sleep Agent
🚀 Deploy + Configuração de domínio

✅ Deploy concluído
✅ Domínio adicionado na Vercel

📋 Configure o DNS no Registro.br:
[Instruções detalhadas]

⏱️ Aguardando propagação DNS...
[Monitoramento automático]

✅ DNS propagado! (14min 23s)
✅ HTTPS ativo

🎉 Site disponível: https://vendas.meusite.com.br
```

### Exemplo 3: Apenas Preview

```bash
# Usuário
/preview

# Sleep Agent
🔗 Gerando preview...

✅ Preview disponível:
https://projeto-abc123-git-feature-user.vercel.app

Compartilhe com seu cliente!
```

---

## 🛠️ Scripts de Automação

### Deploy via Script

```bash
cd extensoes/deploy/scripts
chmod +x deploy.sh
./deploy.sh
```

### Configurar Domínio via Script

```bash
cd extensoes/deploy/scripts
chmod +x configure-domain.sh
./configure-domain.sh meusite.com.br
```

### Validar Deploy via Script

```bash
cd extensoes/deploy/scripts
chmod +x validate.sh
./validate.sh https://meusite.com.br
```

---

## 📊 Relatórios

### Relatório de Deploy

Gerado automaticamente em:
```
workspace/[projeto]/deploy/logs/deploy-YYYYMMDD-HHMMSS.log
```

### Relatório de Validação

```
workspace/[projeto]/deploy/reports/qa-report-YYYYMMDD-HHMMSS.md
```

### Configuração de Domínio

```
workspace/[projeto]/deploy/domains/[domain].yaml
```

---

## 🔍 Troubleshooting

### Deploy Falha

1. Verificar logs de build
2. Validar HTML/CSS localmente
3. Testar com servidor local: `python3 -m http.server`
4. Verificar tamanho dos assets

### DNS Não Propaga

1. Verificar registros no painel DNS
2. Usar: `dig +trace meusite.com.br`
3. Limpar cache DNS: `ipconfig /flushdns` (Windows)
4. Aguardar TTL expirar (1 hora geralmente)

### HTTPS Não Ativa

1. Aguardar 5-10 minutos após DNS propagar
2. Verificar se domínio está validado no provider
3. Forçar renovação: `vercel certs issue meusite.com.br`

---

## 🎓 Agentes Especializados

Esta extensão utiliza 3 agentes especializados:

### Deploy Engineer
- Executa deploys
- Gerencia Git operations
- Monitora builds
- Gera URLs

Ver: [deploy-engineer.md](agentes/deploy-engineer.md)

### DNS Specialist
- Configura domínios
- Gera registros DNS
- Verifica propagação
- Troubleshooting DNS

Ver: [dns-specialist.md](agentes/dns-specialist.md)

### QA Validator
- Valida deploys
- Testa HTTPS
- Verifica performance
- Gera relatórios

Ver: [qa-validator.md](agentes/qa-validator.md)

---

## 📚 Documentação Completa

- [Instruções da Extensão](.claude/CLAUDE.md)
- [Regras de Delegação](core/orquestrador/delegacao.yaml)
- [Tarefa: Executar Deploy](tarefas/executar-deploy.md)
- [Tarefa: Configurar Domínio](tarefas/configurar-dominio.md)

---

## 🤝 Contribuindo

Esta extensão faz parte do Sleep Agent Framework. Para contribuir:

1. Entenda a arquitetura em `core/README.md`
2. Siga os padrões de agentes
3. Teste com múltiplos providers
4. Documente mudanças

---

## 📝 Changelog

### v1.0.0 (2024-01-15)

- ✅ Deploy automatizado (Vercel, Netlify)
- ✅ Configuração de domínios com instruções específicas
- ✅ Automação DNS via Cloudflare API
- ✅ Validação automática de deploys
- ✅ Geração de relatórios
- ✅ Preview URLs
- ✅ Scripts de automação

---

## 📞 Suporte

Extensão desenvolvida pelo Sleep Agent Framework.

Para questões sobre:
- **Deploy:** Use `/deploy-status` ou veja logs
- **Domínios:** Use `/domains verify [domain]`
- **Bugs:** Reporte no repositório principal

---

## 🎉 Próximas Funcionalidades

- [ ] Suporte para mais providers (Firebase, AWS S3)
- [ ] CI/CD automático
- [ ] Analytics integration
- [ ] A/B testing
- [ ] Rollback automático em caso de erro
- [ ] Notificações via Slack/Discord

---

**Desenvolvido com ❤️ pelo Sleep Agent Framework**
