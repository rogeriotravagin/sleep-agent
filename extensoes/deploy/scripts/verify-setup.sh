#!/bin/bash

# Script de Verificação de Setup - Extensão Deploy
# Verifica se tudo está configurado corretamente

echo "🔍 Verificando configuração da extensão Deploy..."
echo ""

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0

# 1. Verificar Node.js
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1️⃣  Verificando Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✅ Node.js instalado: $NODE_VERSION${NC}"
else
    echo -e "${RED}❌ Node.js não encontrado${NC}"
    echo "   Instale em: https://nodejs.org/"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# 2. Verificar NPM
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2️⃣  Verificando NPM..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✅ NPM instalado: $NPM_VERSION${NC}"
else
    echo -e "${RED}❌ NPM não encontrado${NC}"
    echo "   Vem junto com Node.js: https://nodejs.org/"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# 3. Verificar Vercel CLI
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3️⃣  Verificando Vercel CLI..."
if command -v vercel &> /dev/null; then
    VERCEL_VERSION=$(vercel --version)
    echo -e "${GREEN}✅ Vercel CLI instalado: $VERCEL_VERSION${NC}"
else
    echo -e "${YELLOW}⚠️  Vercel CLI não encontrado${NC}"
    echo "   Instalando automaticamente..."
    npm install -g vercel
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Vercel CLI instalado com sucesso!${NC}"
    else
        echo -e "${RED}❌ Falha ao instalar Vercel CLI${NC}"
        echo "   Execute manualmente: npm install -g vercel"
        ERRORS=$((ERRORS + 1))
    fi
fi
echo ""

# 4. Verificar arquivo .env
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4️⃣  Verificando Token da Vercel (.env)..."
if [ -f ".env" ]; then
    echo -e "${GREEN}✅ Arquivo .env encontrado${NC}"

    # Verificar se tem VERCEL_TOKEN
    if grep -q "VERCEL_TOKEN" .env; then
        echo -e "${GREEN}✅ VERCEL_TOKEN configurado${NC}"

        # Tentar validar token (sem expor o valor)
        TOKEN=$(grep VERCEL_TOKEN .env | cut -d '=' -f2)
        if [ ! -z "$TOKEN" ]; then
            echo "   Testando autenticação..."
            if vercel whoami --token="$TOKEN" &> /dev/null; then
                echo -e "${GREEN}✅ Token válido e funcionando!${NC}"
            else
                echo -e "${RED}❌ Token inválido ou expirado${NC}"
                echo "   Gere um novo em: https://vercel.com/account/tokens"
                ERRORS=$((ERRORS + 1))
            fi
        else
            echo -e "${RED}❌ VERCEL_TOKEN está vazio${NC}"
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo -e "${RED}❌ VERCEL_TOKEN não encontrado no .env${NC}"
        echo "   Adicione: VERCEL_TOKEN=seu-token-aqui"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "${RED}❌ Arquivo .env não encontrado${NC}"
    echo ""
    echo "   📋 Para criar o arquivo .env:"
    echo "   1. Obtenha seu token em: https://vercel.com/account/tokens"
    echo "   2. Crie arquivo .env com:"
    echo "      VERCEL_TOKEN=seu-token-aqui"
    echo ""
    ERRORS=$((ERRORS + 1))
fi
echo ""

# 5. Verificar .gitignore
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5️⃣  Verificando .gitignore (segurança)..."
if [ -f ".gitignore" ]; then
    if grep -q ".env" .gitignore; then
        echo -e "${GREEN}✅ .env protegido no .gitignore${NC}"
    else
        echo -e "${YELLOW}⚠️  .env não está no .gitignore${NC}"
        echo "   Adicionando automaticamente..."
        echo ".env" >> .gitignore
        echo -e "${GREEN}✅ .env adicionado ao .gitignore${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  .gitignore não encontrado${NC}"
    echo "   Criando .gitignore..."
    cat > .gitignore << EOF
.env
.vercel
*.log
node_modules/
EOF
    echo -e "${GREEN}✅ .gitignore criado${NC}"
fi
echo ""

# 6. Verificar arquivo HTML
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6️⃣  Verificando arquivo index.html..."
if [ -f "index.html" ]; then
    SIZE=$(wc -c < index.html)
    echo -e "${GREEN}✅ index.html encontrado (${SIZE} bytes)${NC}"
else
    echo -e "${YELLOW}⚠️  index.html não encontrado no diretório atual${NC}"
    echo "   Isso é normal se você ainda não criou seu site"
fi
echo ""

# Resultado Final
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}🎉 TUDO CONFIGURADO CORRETAMENTE!${NC}"
    echo ""
    echo "Você está pronto para fazer deploy!"
    echo ""
    echo "Próximos passos:"
    echo "  • /deploy        → Fazer deploy"
    echo "  • /preview       → Gerar preview"
    echo "  • /deploy-status → Ver status"
    echo ""
    exit 0
else
    echo -e "${RED}❌ $ERRORS erro(s) encontrado(s)${NC}"
    echo ""
    echo "Por favor, corrija os erros acima antes de fazer deploy."
    echo ""
    echo "Precisa de ajuda?"
    echo "  • Guia completo: extensoes/deploy/SETUP.md"
    echo "  • Quick start: extensoes/deploy/QUICK-START.md"
    echo ""
    exit 1
fi
