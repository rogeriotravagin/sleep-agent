#!/bin/bash

# Configure Domain Script - Sleep Agent
# Configura domínio customizado com máxima automação

set -e

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Argumentos
DOMAIN="$1"
PROVIDER="${PROVIDER:-vercel}"

if [ -z "$DOMAIN" ]; then
    echo -e "${RED}❌ Uso: $0 <domain>${NC}"
    echo "Exemplo: $0 meusite.com.br"
    exit 1
fi

echo -e "${BLUE}🔧 Sleep Agent - Configuração de Domínio${NC}"
echo "Domínio: $DOMAIN"
echo "Provider: $PROVIDER"
echo ""

# 1. Validar domínio
echo -e "${BLUE}🔍 Validando domínio...${NC}"

if ! [[ "$DOMAIN" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$ ]]; then
    echo -e "${RED}❌ Formato de domínio inválido${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Domínio válido${NC}"

# 2. Detectar provedor DNS
echo -e "${BLUE}📍 Detectando provedor DNS...${NC}"

NAMESERVERS=$(dig +short NS "$DOMAIN" 2>/dev/null | sed 's/\.$//' || echo "")

if [ -z "$NAMESERVERS" ]; then
    echo -e "${YELLOW}⚠️ Não foi possível detectar nameservers${NC}"
    DNS_PROVIDER="unknown"
else
    if echo "$NAMESERVERS" | grep -qi "registro.br"; then
        DNS_PROVIDER="registro.br"
    elif echo "$NAMESERVERS" | grep -qi "godaddy"; then
        DNS_PROVIDER="godaddy"
    elif echo "$NAMESERVERS" | grep -qi "cloudflare"; then
        DNS_PROVIDER="cloudflare"
    elif echo "$NAMESERVERS" | grep -qi "hostgater"; then
        DNS_PROVIDER="hostgator"
    elif echo "$NAMESERVERS" | grep -qi "awsdns"; then
        DNS_PROVIDER="route53"
    else
        DNS_PROVIDER="unknown"
    fi

    echo -e "${GREEN}📍 Provedor DNS: $DNS_PROVIDER${NC}"
fi

# 3. Adicionar domínio no provider
echo -e "${BLUE}➕ Adicionando domínio no $PROVIDER...${NC}"

case "$PROVIDER" in
    "vercel")
        vercel domains add "$DOMAIN" --yes 2>/dev/null || {
            if vercel domains ls 2>/dev/null | grep -q "$DOMAIN"; then
                echo -e "${YELLOW}ℹ️ Domínio já adicionado${NC}"
            else
                echo -e "${RED}❌ Erro ao adicionar domínio${NC}"
                exit 1
            fi
        }

        RECORD_TYPE="A"
        RECORD_NAME="@"
        RECORD_VALUE="76.76.21.21"
        ;;

    "netlify")
        netlify domains:add "$DOMAIN" 2>/dev/null || {
            echo -e "${YELLOW}ℹ️ Domínio pode já estar adicionado${NC}"
        }

        RECORD_TYPE="CNAME"
        RECORD_NAME="www"
        # Obter domínio Netlify
        NETLIFY_DOMAIN=$(netlify status --json 2>/dev/null | jq -r '.siteUrl' | sed 's|https://||' || echo "")
        RECORD_VALUE="${NETLIFY_DOMAIN:-seu-site.netlify.app}"
        ;;
esac

echo -e "${GREEN}✅ Domínio adicionado${NC}"

# 4. Tentar configuração automática (Cloudflare)
if [ "$DNS_PROVIDER" = "cloudflare" ] && [ -n "$CLOUDFLARE_EMAIL" ] && [ -n "$CLOUDFLARE_API_KEY" ]; then
    echo -e "${BLUE}✨ Configuração automática via Cloudflare API...${NC}"

    # Obter Zone ID
    ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN" \
        -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
        -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
        | jq -r '.result[0].id' 2>/dev/null || echo "")

    if [ -n "$ZONE_ID" ] && [ "$ZONE_ID" != "null" ]; then
        # Adicionar registro DNS
        curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
            -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
            -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
            -H "Content-Type: application/json" \
            -d "{
                \"type\": \"$RECORD_TYPE\",
                \"name\": \"$RECORD_NAME\",
                \"content\": \"$RECORD_VALUE\",
                \"ttl\": 3600,
                \"proxied\": false
            }" > /dev/null

        echo -e "${GREEN}✅ DNS configurado automaticamente!${NC}"
        AUTO_CONFIGURED=true
    else
        echo -e "${YELLOW}⚠️ Não foi possível usar API${NC}"
        AUTO_CONFIGURED=false
    fi
else
    AUTO_CONFIGURED=false
fi

# 5. Mostrar instruções manuais
if [ "$AUTO_CONFIGURED" != "true" ]; then
    echo ""
    echo -e "${BLUE}📋 Configure o DNS manualmente:${NC}"
    echo ""

    case "$DNS_PROVIDER" in
        "registro.br")
            cat <<EOF
╔════════════════════════════════════════════╗
║  Configuração no Registro.br               ║
╚════════════════════════════════════════════╝

1. Acesse: https://registro.br
2. Login com CPF/CNPJ
3. Meus Domínios → $DOMAIN → DNS
4. Clique em "Adicionar Entrada DNS"
5. Preencha:
   ┌────────────────────────────────┐
   │ Tipo:  $RECORD_TYPE            │
   │ Nome:  $RECORD_NAME            │
   │ Dados: $RECORD_VALUE           │
   │ TTL:   3600                    │
   └────────────────────────────────┘
6. Salvar

⏱️ Propagação: 5-30 minutos
EOF
            ;;

        "godaddy")
            cat <<EOF
╔════════════════════════════════════════════╗
║  Configuração no GoDaddy                   ║
╚════════════════════════════════════════════╝

1. Acesse: https://godaddy.com
2. Login → Meus Produtos → DNS
3. Clique em "Adicionar" na seção Registros
4. Preencha:
   ┌────────────────────────────────┐
   │ Tipo:  $RECORD_TYPE            │
   │ Nome:  $RECORD_NAME            │
   │ Valor: $RECORD_VALUE           │
   │ TTL:   1 hora                  │
   └────────────────────────────────┘
5. Salvar

⏱️ Propagação: 10-60 minutos
EOF
            ;;

        *)
            cat <<EOF
╔════════════════════════════════════════════╗
║  Configuração DNS                          ║
╚════════════════════════════════════════════╝

No painel do seu provedor DNS, adicione:

   ┌────────────────────────────────┐
   │ Tipo:  $RECORD_TYPE            │
   │ Nome:  $RECORD_NAME            │
   │ Valor: $RECORD_VALUE           │
   │ TTL:   3600                    │
   └────────────────────────────────┘

⏱️ Propagação: 5-60 minutos
EOF
            ;;
    esac

    echo ""
    echo -e "${YELLOW}⏱️ Após configurar, aguarde a propagação DNS${NC}"
    echo ""
    read -p "Pressione ENTER quando tiver configurado..."
fi

# 6. Verificar propagação
echo ""
echo -e "${BLUE}⏱️ Verificando propagação DNS...${NC}"

MAX_WAIT=1800  # 30 minutos
INTERVAL=30
ELAPSED=0

while [ $ELAPSED -lt $MAX_WAIT ]; do
    CURRENT_VALUE=$(dig +short "$DOMAIN" @8.8.8.8 | head -1 2>/dev/null || echo "")

    if [ "$CURRENT_VALUE" = "$RECORD_VALUE" ]; then
        echo -e "${GREEN}✅ DNS propagado! (${ELAPSED}s)${NC}"
        break
    fi

    if [ $((ELAPSED % 60)) -eq 0 ]; then
        MINUTES=$((ELAPSED / 60))
        echo -e "${YELLOW}⏱️ Aguardando... (${MINUTES}min)${NC}"
    fi

    sleep $INTERVAL
    ELAPSED=$((ELAPSED + INTERVAL))
done

if [ $ELAPSED -ge $MAX_WAIT ]; then
    echo -e "${RED}⚠️ Timeout após 30 minutos${NC}"
    echo "Verifique a configuração DNS manualmente"
    exit 1
fi

# 7. Validar HTTPS
echo -e "${BLUE}🔒 Verificando HTTPS...${NC}"

sleep 15  # Aguardar SSL provisionar

RESPONSE=$(curl -Is "https://$DOMAIN" 2>/dev/null | head -1 || echo "")

if echo "$RESPONSE" | grep -q "200"; then
    echo -e "${GREEN}✅ HTTPS ativo!${NC}"

    # Verificar certificado
    CERT_INFO=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN":443 2>/dev/null | openssl x509 -noout -issuer -dates 2>/dev/null || echo "")

    if [ -n "$CERT_INFO" ]; then
        echo -e "${GREEN}🔒 Certificado SSL válido${NC}"
    fi
else
    echo -e "${YELLOW}⚠️ HTTPS ainda não está ativo${NC}"
    echo "Aguarde 5-10 minutos e verifique novamente"
fi

echo ""
echo -e "${GREEN}🎉 Domínio configurado!${NC}"
echo -e "${GREEN}🌐 https://$DOMAIN${NC}"
