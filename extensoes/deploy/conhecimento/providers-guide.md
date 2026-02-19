# Guia Completo de Providers - Deploy Extension

## Vercel

### Características

- **Melhor para:** Sites estáticos, Next.js, React, Vue
- **Build time:** 20-60s
- **HTTPS:** Automático (Let's Encrypt)
- **Domínios customizados:** Suporte completo
- **Preço:** Gratuito para hobby, $20/mês Pro

### Instalação e Setup

```bash
# Instalar CLI
npm install -g vercel

# Login
vercel login

# Primeiro deploy
vercel

# Deploy para produção
vercel --prod
```

### Domínios

```bash
# Adicionar domínio
vercel domains add meusite.com.br

# Listar domínios
vercel domains ls

# Remover domínio
vercel domains rm meusite.com.br

# Verificar DNS
vercel domains inspect meusite.com.br
```

### DNS Configuration

**Root Domain:**
```
Type: A
Name: @
Value: 76.76.21.21
TTL: 3600
```

**Subdomain:**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
TTL: 3600
```

### Build Configuration

**vercel.json:**
```json
{
  "version": 2,
  "builds": [
    {
      "src": "index.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ]
}
```

### Troubleshooting

**Build falha:**
```bash
# Ver logs completos
vercel logs [deployment-url]

# Build local
vercel build

# Deploy forçando rebuild
vercel --force
```

**Domínio não funciona:**
```bash
# Verificar status
vercel domains inspect meusite.com.br

# Revalidar domínio
vercel domains verify meusite.com.br

# Regenerar certificado SSL
vercel certs issue meusite.com.br
```

---

## Netlify

### Características

- **Melhor para:** Sites estáticos, JAMstack
- **Build time:** 30-90s
- **HTTPS:** Automático (Let's Encrypt)
- **Formulários:** Built-in
- **Preço:** Gratuito para starter, $19/mês Pro

### Instalação e Setup

```bash
# Instalar CLI
npm install -g netlify-cli

# Login
netlify login

# Inicializar site
netlify init

# Deploy
netlify deploy --prod
```

### Domínios

```bash
# Adicionar domínio
netlify domains:add meusite.com.br

# Listar domínios
netlify domains:list

# Remover domínio
netlify domains:remove meusite.com.br
```

### DNS Configuration

**CNAME Record:**
```
Type: CNAME
Name: www
Value: [seu-site].netlify.app
TTL: 3600
```

**A Record (Netlify DNS):**
```
Type: A
Name: @
Value: 75.2.60.5
TTL: 3600
```

### Build Configuration

**netlify.toml:**
```toml
[build]
  publish = "."
  command = "echo 'Build complete'"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

### Recursos Extras

**Formulários:**
```html
<form name="contact" netlify>
  <input type="text" name="name" />
  <input type="email" name="email" />
  <button type="submit">Enviar</button>
</form>
```

**Functions:**
```javascript
// netlify/functions/hello.js
exports.handler = async function(event, context) {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello World" })
  };
}
```

### Troubleshooting

**Build falha:**
```bash
# Ver logs
netlify logs

# Build local
netlify build

# Deploy com debug
netlify deploy --debug
```

---

## Cloudflare Pages

### Características

- **Melhor para:** Sites estáticos, Workers
- **Build time:** 15-45s
- **HTTPS:** Automático
- **DNS:** Integração total via Cloudflare
- **Preço:** Gratuito (unlimited)

### Setup

1. Conectar repositório GitHub
2. Configurar build settings
3. Deploy automático em cada push

### DNS Configuration

Se usar Cloudflare DNS, configuração 100% automática via API.

**Cloudflare API:**
```bash
curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "X-Auth-Email: $EMAIL" \
  -H "X-Auth-Key: $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "CNAME",
    "name": "www",
    "content": "projeto.pages.dev",
    "ttl": 3600,
    "proxied": true
  }'
```

### Build Configuration

**wrangler.toml:**
```toml
name = "meu-site"
type = "webpack"
account_id = ""
workers_dev = true
route = ""
zone_id = ""

[site]
bucket = "."
```

### Vantagens

- CDN global automático
- DDoS protection
- Unlimited bandwidth
- Integração com Workers
- Analytics detalhado

---

## GitHub Pages

### Características

- **Melhor para:** Documentação, sites simples
- **Build time:** Variável (5-30s)
- **HTTPS:** Automático
- **Limitações:** Apenas sites estáticos
- **Preço:** Gratuito

### Setup

**Via Settings:**
1. Repository → Settings → Pages
2. Source: main branch
3. Folder: / (root)

**Via GitHub Actions:**
```yaml
# .github/workflows/deploy.yml
name: Deploy to GitHub Pages
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./
```

### Domínio Customizado

```bash
# Criar arquivo CNAME na raiz
echo "meusite.com.br" > CNAME

# DNS Configuration
Type: A
Name: @
Value: 185.199.108.153
       185.199.109.153
       185.199.110.153
       185.199.111.153

Type: CNAME
Name: www
Value: usuario.github.io
```

### Limitações

- Repositórios públicos apenas (free tier)
- Limite de 1GB
- 100GB bandwidth/mês
- Sem server-side processing

---

## Comparação de Providers

| Recurso | Vercel | Netlify | Cloudflare | GitHub |
|---------|--------|---------|------------|--------|
| **Deploy automático** | ✅ | ✅ | ✅ | ✅ |
| **HTTPS** | ✅ | ✅ | ✅ | ✅ |
| **Domínio customizado** | ✅ | ✅ | ✅ | ✅ |
| **Preview branches** | ✅ | ✅ | ✅ | ❌ |
| **Functions** | ✅ | ✅ | ✅ (Workers) | ❌ |
| **Forms** | ❌ | ✅ | ❌ | ❌ |
| **Analytics** | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ | ⭐ |
| **Performance** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Facilidade** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Preço Free** | Bom | Muito Bom | Excelente | Bom |

---

## Recomendações

### Para Landing Pages
**Vercel** - Melhor DX, deploy rápido, analytics embutido

### Para Sites com Formulários
**Netlify** - Forms built-in, fácil de configurar

### Para Performance Máxima
**Cloudflare Pages** - CDN global, unlimited bandwidth

### Para Documentação
**GitHub Pages** - Integração perfeita com repositório

### Para Projetos Grandes
**Vercel Pro** ou **Netlify Pro** - Mais recursos e suporte

---

## DNS Providers

### Com API (Automação 100%)

**Cloudflare:**
- API completa
- Proxy opcional
- Analytics
- DDoS protection

**AWS Route 53:**
- Alta disponibilidade
- Health checks
- Traffic policies

**Google Cloud DNS:**
- Integração GCP
- DNSSEC
- Anycast

### Sem API (Manual)

**Registro.br:**
- Domínios .br
- Interface simples
- Propagação: 5-30 min

**GoDaddy:**
- Popular
- Interface intuitiva
- Propagação: 10-60 min

**HostGator:**
- Comum no Brasil
- cPanel
- Propagação: 15-60 min

---

## Checklist de Deploy

- [ ] Git configurado
- [ ] Remote adicionado
- [ ] Provider escolhido e instalado
- [ ] CLI autenticado
- [ ] index.html existe
- [ ] Assets testados localmente
- [ ] Domínio registrado (se aplicável)
- [ ] DNS pronto para configurar

---

## Links Úteis

### Vercel
- Docs: https://vercel.com/docs
- CLI: https://vercel.com/docs/cli
- Domínios: https://vercel.com/docs/custom-domains

### Netlify
- Docs: https://docs.netlify.com
- CLI: https://docs.netlify.com/cli/get-started/
- Formulários: https://docs.netlify.com/forms/setup/

### Cloudflare
- Pages: https://pages.cloudflare.com
- API: https://api.cloudflare.com
- DNS: https://developers.cloudflare.com/dns/

### GitHub
- Pages: https://pages.github.com
- Actions: https://docs.github.com/actions

### Ferramentas
- DNS Checker: https://whatsmydns.net
- SSL Test: https://www.ssllabs.com/ssltest/
- PageSpeed: https://pagespeed.web.dev
