# Tarefa: Executar Deploy

## Objetivo

Publicar página ou site em produção no provider configurado (Vercel, Netlify, etc).

---

## Pré-requisitos

- [ ] Git inicializado
- [ ] Remote configurado (GitHub, GitLab, etc)
- [ ] index.html ou entrada principal existe
- [ ] Provider instalado e autenticado (Vercel CLI, Netlify CLI)

---

## Inputs

```yaml
inputs:
  projeto_path: ./  # Path do projeto
  provider: vercel  # vercel, netlify, cloudflare-pages
  production: true  # true = produção, false = preview
  domain: null      # (opcional) Configurar domínio após deploy
  auto_commit: true # Fazer commit automático se houver mudanças
```

---

## Processo

### 1. Validação Inicial

```bash
# Verificar Git
if [ ! -d ".git" ]; then
    echo "Inicializando Git..."
    git init
    echo "✅ Git inicializado"
fi

# Verificar remote
if ! git remote get-url origin &> /dev/null; then
    echo "❌ Remote não configurado"
    echo "Configure: git remote add origin [URL]"
    exit 1
fi

# Verificar arquivos
if [ ! -f "index.html" ] && [ ! -f "index.js" ]; then
    echo "❌ Arquivo de entrada não encontrado"
    exit 1
fi
```

### 2. Git Operations

```bash
# Verificar se há mudanças
if [ -n "$(git status --porcelain)" ]; then
    if [ "$auto_commit" = true ]; then
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")

        git add .
        git commit -m "Deploy: $timestamp

Co-Authored-By: Sleep Agent <noreply@sleepagent.dev>"

        echo "✅ Commit criado"
    else
        echo "⚠️ Há mudanças não commitadas"
        echo "Deseja commitar agora? (y/n)"
        read answer
        if [ "$answer" = "y" ]; then
            git add .
            git commit -m "Deploy: $(date +%Y-%m-%d\ %H:%M:%S)"
        else
            exit 1
        fi
    fi
fi

# Push
git push origin main
echo "✅ Push concluído"
```

### 3. Deploy no Provider

**Vercel:**
```bash
# Verificar instalação
if ! command -v vercel &> /dev/null; then
    echo "Instalando Vercel CLI..."
    npm i -g vercel
fi

# Verificar autenticação
if ! vercel whoami &> /dev/null; then
    echo "Autenticando..."
    vercel login
fi

# Deploy
if [ "$production" = true ]; then
    vercel --prod --yes
else
    vercel --yes
fi

# Capturar URL
deploy_url=$(vercel ls --json | jq -r '.[0].url')
echo "✅ Deploy concluído: https://$deploy_url"
```

**Netlify:**
```bash
# Verificar instalação
if ! command -v netlify &> /dev/null; then
    echo "Instalando Netlify CLI..."
    npm i -g netlify-cli
fi

# Verificar autenticação
if ! netlify status &> /dev/null; then
    echo "Autenticando..."
    netlify login
fi

# Deploy
if [ "$production" = true ]; then
    netlify deploy --prod --dir .
else
    netlify deploy --dir .
fi

# Capturar URL
deploy_url=$(netlify status --json | jq -r '.siteUrl')
echo "✅ Deploy concluído: $deploy_url"
```

### 4. Monitorar Build

```bash
echo "⏱️ Aguardando build..."

max_wait=300  # 5 minutos
elapsed=0
interval=5

while [ $elapsed -lt $max_wait ]; do
    # Verificar status (específico do provider)
    status=$(vercel inspect "$deploy_url" --json 2>/dev/null | jq -r '.readyState')

    if [ "$status" = "READY" ]; then
        echo "✅ Build concluído!"
        break
    elif [ "$status" = "ERROR" ]; then
        echo "❌ Build falhou!"
        vercel logs "$deploy_url"
        exit 1
    fi

    echo "⏱️ Build em progresso... ($elapsed/$max_wait segundos)"
    sleep $interval
    elapsed=$((elapsed + interval))
done
```

### 5. Executar Validação

```bash
# Chamar QA Validator
./scripts/validate-deploy.sh "$deploy_url"
```

### 6. Configurar Domínio (se especificado)

```bash
if [ -n "$domain" ]; then
    echo "🔧 Configurando domínio: $domain"

    # Chamar DNS Specialist
    ./scripts/configure-domain.sh "$domain" "$deploy_url"
fi
```

---

## Outputs

```yaml
outputs:
  status: success | error
  deploy_url: https://projeto-abc123.vercel.app
  production_url: https://projeto-abc123.vercel.app
  build_time: 24s
  deploy_number: 47
  commit_hash: a1b2c3d
  timestamp: 2024-01-15 14:30:22
  logs_path: workspace/[projeto]/deploy/logs/deploy-[timestamp].log
  validation_report: workspace/[projeto]/deploy/reports/qa-report-[timestamp].md
```

---

## Tratamento de Erros

### Build Falha

```yaml
erro: Build failed
causa: [Erro específico do provider]
sugestoes:
  - Verificar logs completos
  - Validar HTML/CSS localmente
  - Testar build local
  - Verificar tamanho dos assets
acao_automatica:
  - Baixar logs completos
  - Identificar erro específico
  - Sugerir correção
```

### Push Falha

```yaml
erro: Push rejected
causa: Remote divergiu ou credenciais inválidas
sugestoes:
  - git pull origin main
  - Verificar autenticação SSH/HTTPS
  - Verificar permissões no repositório
```

### Provider Não Autenticado

```yaml
erro: Not authenticated
causa: Token inválido ou expirado
acao_automatica:
  - Executar: vercel login
  - Guiar processo de autenticação
```

---

## Logging

Salvar log completo em:
```
workspace/[projeto]/deploy/logs/deploy-YYYY-MM-DD-HHMMSS.log
```

Formato:
```
[2024-01-15 14:30:22] Iniciando deploy
[2024-01-15 14:30:23] ✅ Git: OK
[2024-01-15 14:30:24] ✅ Push: OK
[2024-01-15 14:30:25] ✅ Build: Iniciado
[2024-01-15 14:30:49] ✅ Build: Concluído (24s)
[2024-01-15 14:30:50] ✅ Deploy: Concluído
[2024-01-15 14:30:51] ✅ Validação: Aprovada
[2024-01-15 14:30:51] 🎉 URL: https://projeto.vercel.app
```

---

## Notificações

### Deploy Iniciado

```
🚀 Deploy iniciado...

Provider: Vercel
Ambiente: Produção
Commit: a1b2c3d - "Deploy: 2024-01-15 14:30:22"
```

### Deploy Concluído

```
🎉 Deploy concluído com sucesso!

🔗 URL de Produção:
https://projeto-abc123.vercel.app

📊 Métricas:
- Build: 24s
- Deploy #47
- Tamanho: 1.2MB

✅ Validação: Aprovada (Score: 95/100)

Próximos passos:
- Configurar domínio customizado (/domains add)
- Ver relatório completo (/deploy-status)
```

### Deploy Falhou

```
❌ Deploy falhou

Erro: Build failed - Syntax error in index.html

🔍 Logs salvos em:
workspace/projeto/deploy/logs/deploy-2024-01-15-143022.log

💡 Sugestão:
Linha 42 do index.html: Tag <div> não fechada

Deseja que eu corrija automaticamente?
```

---

## Rollback

Se deploy falhar em produção:

```bash
# Vercel
vercel rollback

# Netlify
netlify rollback
```

---

## Casos Especiais

### Primeiro Deploy (Novo Projeto)

1. Detectar que é primeiro deploy
2. Criar projeto no provider
3. Conectar repositório
4. Configurar build settings
5. Executar deploy

### Deploy com Cache

```bash
# Limpar cache (Vercel)
vercel build --force

# Limpar cache (Netlify)
netlify build --clear-cache
```

### Deploy de Branch Específica

```bash
# Checkout da branch
git checkout feature/nova-pagina

# Deploy sem produção
vercel --yes

# Retornar à main
git checkout main
```

---

## Métricas

Sempre coletar e reportar:
- Tempo de build
- Tamanho do bundle
- Número do deploy
- Hash do commit
- Status da validação
- Performance score

---

## Referências

- [deploy-engineer.md](../agentes/deploy-engineer.md)
- [qa-validator.md](../agentes/qa-validator.md)
- [dns-specialist.md](../agentes/dns-specialist.md)
