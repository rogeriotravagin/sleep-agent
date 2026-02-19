#!/bin/bash

# Deploy Script - Sleep Agent
# Executa deploy completo para produção

set -e

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configurações
PROVIDER="${PROVIDER:-vercel}"
AUTO_COMMIT="${AUTO_COMMIT:-true}"
PRODUCTION="${PRODUCTION:-true}"

echo -e "${BLUE}🚀 Sleep Agent Deploy${NC}"
echo "Provider: $PROVIDER"
echo ""

# 1. Validar Git
echo -e "${BLUE}📋 Validando Git...${NC}"

if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Git não inicializado. Inicializando...${NC}"
    git init
    echo -e "${GREEN}✅ Git inicializado${NC}"
fi

if ! git remote get-url origin &> /dev/null; then
    echo -e "${RED}❌ Remote não configurado${NC}"
    echo "Configure: git remote add origin [URL]"
    exit 1
fi

echo -e "${GREEN}✅ Git configurado${NC}"

# 2. Verificar arquivos
echo -e "${BLUE}📁 Verificando arquivos...${NC}"

if [ ! -f "index.html" ] && [ ! -f "index.js" ] && [ ! -f "package.json" ]; then
    echo -e "${RED}❌ Arquivo de entrada não encontrado${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Arquivos encontrados${NC}"

# 3. Git Operations
echo -e "${BLUE}📤 Git Operations...${NC}"

if [ -n "$(git status --porcelain)" ]; then
    if [ "$AUTO_COMMIT" = "true" ]; then
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")

        git add .
        git commit -m "Deploy: $timestamp

Co-Authored-By: Sleep Agent <noreply@sleepagent.dev>"

        echo -e "${GREEN}✅ Commit criado${NC}"
    else
        echo -e "${YELLOW}⚠️ Há mudanças não commitadas${NC}"
        read -p "Deseja commitar agora? (y/n) " answer
        if [ "$answer" = "y" ]; then
            git add .
            git commit -m "Deploy: $(date +%Y-%m-%d\ %H:%M:%S)"
        else
            exit 1
        fi
    fi
fi

git push origin main
echo -e "${GREEN}✅ Push concluído${NC}"

# 4. Deploy no Provider
echo -e "${BLUE}🚀 Executando deploy...${NC}"

case "$PROVIDER" in
    "vercel")
        # Verificar instalação
        if ! command -v vercel &> /dev/null; then
            echo -e "${YELLOW}Instalando Vercel CLI...${NC}"
            npm i -g vercel
        fi

        # Deploy
        if [ "$PRODUCTION" = "true" ]; then
            vercel --prod --yes
        else
            vercel --yes
        fi

        # Capturar URL
        DEPLOY_URL=$(vercel ls --json | jq -r '.[0].url' 2>/dev/null || echo "")

        if [ -n "$DEPLOY_URL" ]; then
            echo -e "${GREEN}✅ Deploy concluído!${NC}"
            echo -e "${GREEN}🔗 https://$DEPLOY_URL${NC}"
        fi
        ;;

    "netlify")
        # Verificar instalação
        if ! command -v netlify &> /dev/null; then
            echo -e "${YELLOW}Instalando Netlify CLI...${NC}"
            npm i -g netlify-cli
        fi

        # Deploy
        if [ "$PRODUCTION" = "true" ]; then
            netlify deploy --prod --dir .
        else
            netlify deploy --dir .
        fi

        DEPLOY_URL=$(netlify status --json 2>/dev/null | jq -r '.siteUrl' || echo "")

        if [ -n "$DEPLOY_URL" ]; then
            echo -e "${GREEN}✅ Deploy concluído!${NC}"
            echo -e "${GREEN}🔗 $DEPLOY_URL${NC}"
        fi
        ;;

    *)
        echo -e "${RED}❌ Provider não suportado: $PROVIDER${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}🎉 Deploy concluído com sucesso!${NC}"
echo ""
echo "Próximos passos:"
echo "  - Configurar domínio: ./scripts/configure-domain.sh [domain]"
echo "  - Validar deploy: ./scripts/validate.sh [url]"
