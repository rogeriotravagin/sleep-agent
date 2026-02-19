#!/bin/bash

# Validate Deploy Script - Sleep Agent
# Valida deploy e gera relatório de qualidade

set -e

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Argumentos
URL="$1"

if [ -z "$URL" ]; then
    echo -e "${RED}❌ Uso: $0 <url>${NC}"
    echo "Exemplo: $0 https://meusite.com.br"
    exit 1
fi

# Remover protocolo se presente
URL_CLEAN=$(echo "$URL" | sed 's|https://||' | sed 's|http://||')

echo -e "${BLUE}🔍 Sleep Agent - Validação de Deploy${NC}"
echo "URL: $URL_CLEAN"
echo ""

SCORE=0
MAX_SCORE=100

# 1. HTTP Status
echo -e "${BLUE}📊 Testando HTTP...${NC}"

STATUS=$(curl -Is "https://$URL_CLEAN" 2>/dev/null | head -1 | awk '{print $2}' || echo "000")

if [ "$STATUS" = "200" ]; then
    echo -e "${GREEN}✅ Status: 200 OK${NC}"
    SCORE=$((SCORE + 15))
else
    echo -e "${RED}❌ Status: $STATUS${NC}"
fi

# 2. HTTPS
if curl -Is "https://$URL_CLEAN" 2>/dev/null | grep -q "200"; then
    echo -e "${GREEN}✅ HTTPS: Ativo${NC}"
    SCORE=$((SCORE + 15))
else
    echo -e "${RED}❌ HTTPS: Não ativo${NC}"
fi

# 3. Response Time
echo -e "${BLUE}⏱️ Testando Response Time...${NC}"

RESPONSE_TIME=$(curl -o /dev/null -s -w '%{time_total}' "https://$URL_CLEAN" 2>/dev/null || echo "99")

if (( $(echo "$RESPONSE_TIME < 1" | bc -l 2>/dev/null || echo "0") )); then
    echo -e "${GREEN}✅ Response Time: ${RESPONSE_TIME}s (Rápido)${NC}"
    SCORE=$((SCORE + 20))
elif (( $(echo "$RESPONSE_TIME < 3" | bc -l 2>/dev/null || echo "0") )); then
    echo -e "${YELLOW}⚠️ Response Time: ${RESPONSE_TIME}s (Aceitável)${NC}"
    SCORE=$((SCORE + 10))
else
    echo -e "${RED}❌ Response Time: ${RESPONSE_TIME}s (Lento)${NC}"
fi

# 4. Content Size
echo -e "${BLUE}📦 Verificando tamanho...${NC}"

CONTENT_LENGTH=$(curl -Is "https://$URL_CLEAN" 2>/dev/null | grep -i content-length | awk '{print $2}' | tr -d '\r' || echo "0")
CONTENT_KB=$((CONTENT_LENGTH / 1024))

if [ "$CONTENT_KB" -gt 0 ]; then
    echo -e "${GREEN}✅ Content Size: ${CONTENT_KB}KB${NC}"
    SCORE=$((SCORE + 10))
else
    echo -e "${YELLOW}⚠️ Content Size: Não detectado${NC}"
fi

# 5. Assets
echo -e "${BLUE}🖼️ Verificando assets...${NC}"

HTML=$(curl -s "https://$URL_CLEAN" 2>/dev/null || echo "")

if [ -n "$HTML" ]; then
    # CSS
    CSS_COUNT=$(echo "$HTML" | grep -o 'href="[^"]*\.css"' | wc -l || echo "0")
    # JS
    JS_COUNT=$(echo "$HTML" | grep -o 'src="[^"]*\.js"' | wc -l || echo "0")
    # Images
    IMG_COUNT=$(echo "$HTML" | grep -oE 'src="[^"]*\.(jpg|png|gif|svg|webp)"' | wc -l || echo "0")

    TOTAL_ASSETS=$((CSS_COUNT + JS_COUNT + IMG_COUNT))

    echo -e "${GREEN}✅ Assets encontrados:${NC}"
    echo "   CSS: $CSS_COUNT"
    echo "   JS: $JS_COUNT"
    echo "   Imagens: $IMG_COUNT"

    SCORE=$((SCORE + 10))
else
    echo -e "${RED}❌ Não foi possível carregar HTML${NC}"
fi

# 6. Responsive
echo -e "${BLUE}📱 Verificando responsividade...${NC}"

if echo "$HTML" | grep -q 'name="viewport"'; then
    echo -e "${GREEN}✅ Meta viewport: Presente${NC}"
    SCORE=$((SCORE + 10))
else
    echo -e "${YELLOW}⚠️ Meta viewport: Ausente${NC}"
fi

# 7. SEO Básico
echo -e "${BLUE}🎯 Verificando SEO básico...${NC}"

# Title
TITLE=$(echo "$HTML" | grep -oP '<title>\K[^<]*' || echo "")
if [ -n "$TITLE" ]; then
    echo -e "${GREEN}✅ Title: $TITLE${NC}"
    SCORE=$((SCORE + 10))
else
    echo -e "${YELLOW}⚠️ Title: Ausente${NC}"
fi

# Meta description
if echo "$HTML" | grep -q 'name="description"'; then
    echo -e "${GREEN}✅ Meta Description: Presente${NC}"
    SCORE=$((SCORE + 5))
else
    echo -e "${YELLOW}⚠️ Meta Description: Ausente${NC}"
fi

# H1
H1_COUNT=$(echo "$HTML" | grep -c "<h1" || echo "0")
if [ "$H1_COUNT" -eq 1 ]; then
    echo -e "${GREEN}✅ H1: 1 encontrado (ideal)${NC}"
    SCORE=$((SCORE + 5))
elif [ "$H1_COUNT" -gt 1 ]; then
    echo -e "${YELLOW}⚠️ H1: $H1_COUNT encontrados (múltiplos)${NC}"
    SCORE=$((SCORE + 2))
else
    echo -e "${YELLOW}⚠️ H1: Nenhum encontrado${NC}"
fi

# 8. Resultado Final
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}📊 SCORE GERAL: $SCORE/$MAX_SCORE${NC}"

if [ $SCORE -ge 90 ]; then
    echo -e "${GREEN}🎉 Status: EXCELENTE${NC}"
    STATUS_TEXT="EXCELENTE"
elif [ $SCORE -ge 70 ]; then
    echo -e "${YELLOW}👍 Status: BOM${NC}"
    STATUS_TEXT="BOM"
elif [ $SCORE -ge 50 ]; then
    echo -e "${YELLOW}⚠️ Status: ACEITÁVEL${NC}"
    STATUS_TEXT="ACEITÁVEL"
else
    echo -e "${RED}❌ Status: NECESSITA MELHORIAS${NC}"
    STATUS_TEXT="NECESSITA MELHORIAS"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 9. Gerar relatório
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
REPORT_FILE="validation-report-$(date +%Y%m%d-%H%M%S).md"

cat > "$REPORT_FILE" <<EOF
# Relatório de Validação - Deploy

## 🎯 Resumo

**URL:** https://$URL_CLEAN
**Data:** $TIMESTAMP
**Score Geral:** $SCORE/$MAX_SCORE
**Status:** $STATUS_TEXT

---

## 📊 Métricas HTTP

| Métrica | Valor | Status |
|---------|-------|--------|
| HTTP Status | $STATUS | $([ "$STATUS" = "200" ] && echo "✅" || echo "❌") |
| HTTPS | $(curl -Is "https://$URL_CLEAN" 2>/dev/null | grep -q "200" && echo "Ativo" || echo "Inativo") | $(curl -Is "https://$URL_CLEAN" 2>/dev/null | grep -q "200" && echo "✅" || echo "❌") |
| Response Time | ${RESPONSE_TIME}s | $(($(echo "$RESPONSE_TIME < 3" | bc -l 2>/dev/null || echo "0") && echo "✅" || echo "⚠️")) |
| Content Size | ${CONTENT_KB}KB | ✅ |

---

## 🖼️ Assets

- CSS: $CSS_COUNT arquivos
- JavaScript: $JS_COUNT arquivos
- Imagens: $IMG_COUNT arquivos
- **Total:** $TOTAL_ASSETS assets

---

## 📱 Responsividade

- Meta viewport: $(echo "$HTML" | grep -q 'name="viewport"' && echo "✅ Presente" || echo "⚠️ Ausente")

---

## 🎯 SEO Básico

- Title: $([ -n "$TITLE" ] && echo "✅ $TITLE" || echo "⚠️ Ausente")
- Meta Description: $(echo "$HTML" | grep -q 'name="description"' && echo "✅ Presente" || echo "⚠️ Ausente")
- H1: $H1_COUNT encontrado$([ $H1_COUNT -eq 1 ] && echo " ✅" || echo " ⚠️")

---

## 🎉 Conclusão

$(if [ $SCORE -ge 80 ]; then
    echo "Deploy aprovado! O site está funcionando bem."
else
    echo "Deploy necessita melhorias."
fi)

**Gerado por:** Sleep Agent
**Timestamp:** $TIMESTAMP
EOF

echo ""
echo -e "${GREEN}📄 Relatório salvo: $REPORT_FILE${NC}"

# Retornar código de saída baseado no score
if [ $SCORE -ge 70 ]; then
    exit 0
else
    exit 1
fi
