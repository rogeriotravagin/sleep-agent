# Quick Start - Deploy Extension

Guia de 5 minutos para fazer seu primeiro deploy com o Sleep Agent.

---

## ⚠️ Pré-requisitos

**Primeira vez usando?**

👉 Complete o **[SETUP](SETUP.md)** primeiro (10-15 min)
- Criar conta Vercel
- Obter token de API
- Configurar ambiente

**Já configurou?** Continue abaixo! ⬇️

---

## 1️⃣ Preparar Projeto (2 min)

### Verificar Estrutura

Seu projeto precisa de pelo menos um `index.html`:

```
projeto/
├── index.html
├── styles.css (opcional)
├── script.js (opcional)
└── images/ (opcional)
```

### Inicializar Git (se necessário)

```bash
git init
git add .
git commit -m "Initial commit"
```

### Conectar GitHub

```bash
# Criar repositório no GitHub primeiro, depois:
git remote add origin https://github.com/seu-usuario/seu-projeto.git
git push -u origin main
```

---

## 2️⃣ Instalar Provider (1 min)

Escolha um provider e instale:

### Vercel (Recomendado)

```bash
npm install -g vercel
vercel login
```

### Ou Netlify

```bash
npm install -g netlify-cli
netlify login
```

---

## 3️⃣ Primeiro Deploy (1 min)

No Sleep Agent, simplesmente digite:

```
/deploy
```

O Sleep Agent vai:
1. ✅ Verificar Git e arquivos
2. ✅ Fazer commit das mudanças
3. ✅ Push para GitHub
4. ✅ Executar deploy
5. ✅ Retornar URL do site

**Pronto! Seu site está no ar!** 🎉

---

## 4️⃣ Adicionar Domínio Customizado (Opcional)

### Passo 1: Comprar Domínio

Registre seu domínio em:
- Registro.br (domínios .br)
- GoDaddy
- Namecheap
- Etc.

### Passo 2: Configurar no Sleep Agent

```
/domains add meusite.com.br
```

### Passo 3: Seguir Instruções

O Sleep Agent vai:
1. Detectar seu provedor DNS
2. Gerar instruções específicas
3. Mostrar exatamente o que configurar
4. Monitorar a propagação automaticamente
5. Notificar quando estiver pronto

**Tempo total:** 5-30 minutos (maioria é aguardar DNS)

---

## 📝 Exemplo Completo

```
Você: Oi! Preciso publicar minha landing page

Sleep Agent: Vou ajudar você! Vamos fazer o deploy.

Você: /deploy

Sleep Agent:
🔍 Verificando requisitos...
✅ Git: Configurado
✅ Remote: github.com/voce/projeto
✅ index.html: Encontrado

🚀 Iniciando deploy...
✅ Commit criado
✅ Push para GitHub
✅ Build iniciado na Vercel
⏱️ Aguardando build... (18s)

🎉 Deploy concluído com sucesso!

🔗 Seu site está no ar:
https://projeto-abc123.vercel.app

📊 Métricas:
- Build: 18s
- Tamanho: 842KB
- Performance: 94/100

Deseja configurar um domínio customizado?

Você: Sim, meusite.com.br

Sleep Agent:
🔧 Configurando domínio: meusite.com.br

✅ Domínio adicionado na Vercel
📍 DNS Provider: Registro.br

📋 Configure no painel do Registro.br:

[Instruções detalhadas com valores exatos]

⏱️ Aguardando propagação DNS...
[Vou te avisar quando estiver pronto]

[14 minutos depois]

✅ DNS propagado!
✅ HTTPS ativo
🔒 SSL: Let's Encrypt

🎉 Seu site está disponível em:
https://meusite.com.br
```

---

## 🚀 Fluxo de Trabalho Diário

### Deploy de Atualização

```
Você: /deploy
```

Pronto! Sleep Agent detecta mudanças e faz deploy automaticamente.

### Preview para Cliente

```
Você: /preview
```

Gera URL temporária para cliente aprovar antes de ir pra produção.

### Verificar Status

```
Você: /deploy-status
```

Mostra status do último deploy, URL, métricas, etc.

---

## ⚡ Atalhos e Dicas

### Deploy Rápido

Se você tem mudanças e quer deploy imediato:
```
/deploy
```

Sleep Agent faz commit, push e deploy tudo automaticamente.

### Preview de Branch

Trabalhando em feature branch?
```
/preview --branch feature/nova-funcionalidade
```

### Múltiplos Domínios

Quer adicionar subdomínio?
```
/domains add vendas.meusite.com.br
/domains add blog.meusite.com.br
```

---

## 🎯 Checklist Pré-Deploy

- [ ] index.html existe
- [ ] Git inicializado
- [ ] Remote do GitHub configurado
- [ ] Provider instalado (Vercel/Netlify)
- [ ] Provider autenticado (login feito)

---

## 🆘 Problemas Comuns

### "Remote não configurado"

```bash
git remote add origin https://github.com/usuario/projeto.git
```

### "Vercel não encontrado"

```bash
npm install -g vercel
vercel login
```

### "Build falhou"

Verifique se HTML está válido:
```bash
# Testar localmente
python3 -m http.server 8000
# Abrir: http://localhost:8000
```

### "DNS não propaga"

Aguarde 30 minutos e use:
```
/domains verify meusite.com.br
```

---

## 📚 Próximos Passos

Depois do primeiro deploy:

1. **Configure analytics** - Google Analytics, Plausible, etc.
2. **Otimize imagens** - Comprimir para carregar mais rápido
3. **Adicione SEO** - Meta tags, Open Graph
4. **Configure CI/CD** - Deploy automático a cada push

---

## 🎓 Aprender Mais

- [README Completo](README.md) - Todos os comandos e opções
- [Guia de Providers](conhecimento/providers-guide.md) - Comparação detalhada
- [Agentes Especializados](agentes/) - Como funcionam por trás

---

## 💡 Dicas Pro

### Deploy Automático

Configure GitHub Actions para deploy a cada push:

```yaml
# .github/workflows/deploy.yml
name: Auto Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm i -g vercel
      - run: vercel --token ${{ secrets.VERCEL_TOKEN }} --prod
```

### Domínio com Cloudflare

Use Cloudflare para DNS automático 100%:

1. Transferir domínio para Cloudflare
2. Configurar API keys
3. Sleep Agent configura tudo automaticamente

### Performance

Comprimir assets antes de deploy:

```bash
# Imagens
jpegoptim --max=85 *.jpg
optipng *.png

# CSS/JS
npm i -g csso-cli uglify-js
csso styles.css -o styles.min.css
uglifyjs script.js -o script.min.js
```

---

**Pronto para começar?** Digite `/deploy` e veja a mágica acontecer! ✨
