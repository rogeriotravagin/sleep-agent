# Tarefa: Configurar Domínio

## Objetivo

Configurar domínio customizado para um site já deployado, com máxima automação possível.

---

## Pré-requisitos

- [ ] Deploy já realizado com URL de produção
- [ ] Domínio registrado e acessível
- [ ] Provider conectado (Vercel, Netlify, etc)
- [ ] Acesso ao painel DNS (ou API configurada)

---

## Inputs

```yaml
inputs:
  domain: meusite.com.br
  deploy_url: https://projeto-abc123.vercel.app
  provider: vercel
  dns_provider: auto  # auto-detectar ou especificar
  subdomain: false    # true para www.meusite.com.br
  force_https: true
  www_redirect: true  # Redirecionar www → não-www
```

---

## Processo

### 1. Validar Domínio

```bash
#!/bin/bash

domain="$1"

echo "🔍 Validando domínio: $domain"

# Verificar formato
if ! [[ "$domain" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$ ]]; then
    echo "❌ Formato de domínio inválido"
    exit 1
fi

# Verificar se domínio existe
if ! dig +short "$domain" &> /dev/null; then
    echo "⚠️ Domínio não resolve. Verifique se está registrado."
fi

echo "✅ Domínio válido"
```

### 2. Detectar Provedor DNS

```bash
#!/bin/bash

domain="$1"

echo "🔍 Detectando provedor DNS..."

# Obter nameservers
nameservers=$(dig +short NS "$domain" | sed 's/\.$//')

# Identificar provedor
if echo "$nameservers" | grep -qi "registro.br"; then
    dns_provider="registro.br"
elif echo "$nameservers" | grep -qi "godaddy"; then
    dns_provider="godaddy"
elif echo "$nameservers" | grep -qi "cloudflare"; then
    dns_provider="cloudflare"
elif echo "$nameservers" | grep -qi "hostgator"; then
    dns_provider="hostgator"
elif echo "$nameservers" | grep -qi "awsdns"; then
    dns_provider="route53"
else
    dns_provider="unknown"
fi

echo "📍 Provedor DNS: $dns_provider"
```

### 3. Adicionar Domínio no Provider

**Vercel:**
```bash
#!/bin/bash

domain="$1"

echo "➕ Adicionando domínio na Vercel..."

# Via CLI
vercel domains add "$domain" --yes

if [ $? -eq 0 ]; then
    echo "✅ Domínio adicionado"
else
    echo "❌ Erro ao adicionar domínio"

    # Verificar se já existe
    if vercel domains ls | grep -q "$domain"; then
        echo "ℹ️ Domínio já está adicionado"
    else
        exit 1
    fi
fi
```

**Netlify:**
```bash
#!/bin/bash

domain="$1"

echo "➕ Adicionando domínio na Netlify..."

# Via CLI
netlify domains:add "$domain"

if [ $? -eq 0 ]; then
    echo "✅ Domínio adicionado"
else
    echo "❌ Erro ao adicionar domínio"
    exit 1
fi
```

### 4. Gerar Registros DNS

```bash
#!/bin/bash

domain="$1"
provider="$2"
subdomain="$3"

echo "📋 Gerando registros DNS..."

if [ "$provider" = "vercel" ]; then
    if [ "$subdomain" = true ]; then
        # CNAME para subdomínio
        record_type="CNAME"
        record_name="www"
        record_value="cname.vercel-dns.com"
    else
        # A record para root domain
        record_type="A"
        record_name="@"
        record_value="76.76.21.21"
    fi
elif [ "$provider" = "netlify" ]; then
    record_type="CNAME"
    record_name="www"
    record_value="[seu-site].netlify.app"
fi

cat > dns-records.yaml <<EOF
dns_records:
  - type: $record_type
    name: $record_name
    value: $record_value
    ttl: 3600
EOF

echo "✅ Registros gerados: dns-records.yaml"
```

### 5. Tentar Configuração Automática (Se API Disponível)

**Cloudflare DNS:**
```bash
#!/bin/bash

domain="$1"
record_type="$2"
record_name="$3"
record_value="$4"

# Verificar se credenciais estão configuradas
if [ -z "$CLOUDFLARE_EMAIL" ] || [ -z "$CLOUDFLARE_API_KEY" ]; then
    echo "⚠️ Credenciais Cloudflare não configuradas"
    return 1
fi

# Obter Zone ID
zone_id=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$domain" \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
    | jq -r '.result[0].id')

# Adicionar registro DNS
curl -X POST "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
        \"type\": \"$record_type\",
        \"name\": \"$record_name\",
        \"content\": \"$record_value\",
        \"ttl\": 3600,
        \"proxied\": false
    }"

if [ $? -eq 0 ]; then
    echo "✅ DNS configurado automaticamente via Cloudflare API"
    return 0
else
    echo "❌ Falha na configuração automática"
    return 1
fi
```

### 6. Gerar Instruções Manuais

```bash
#!/bin/bash

domain="$1"
dns_provider="$2"
record_type="$3"
record_name="$4"
record_value="$5"

echo "📋 Instruções para $dns_provider:"

case "$dns_provider" in
    "registro.br")
        cat <<EOF

╔════════════════════════════════════════════╗
║  Configuração no Registro.br               ║
╚════════════════════════════════════════════╝

1. Acesse: https://registro.br
2. Login com CPF/CNPJ
3. Meus Domínios → $domain → DNS
4. Clique em "Adicionar Entrada DNS"
5. Preencha:
   ┌────────────────────────────────┐
   │ Tipo:  $record_type            │
   │ Nome:  $record_name            │
   │ Dados: $record_value           │
   │ TTL:   3600                    │
   └────────────────────────────────┘
6. Salvar

⏱️ Tempo de propagação: 5-30 minutos
EOF
        ;;

    "godaddy")
        cat <<EOF

╔════════════════════════════════════════════╗
║  Configuração no GoDaddy                   ║
╚════════════════════════════════════════════╝

1. Acesse: https://godaddy.com
2. Login → Meus Produtos
3. Clique em DNS ao lado do domínio
4. Clique em "Adicionar" na seção Registros
5. Preencha:
   ┌────────────────────────────────┐
   │ Tipo:  $record_type            │
   │ Nome:  $record_name            │
   │ Valor: $record_value           │
   │ TTL:   1 hora                  │
   └────────────────────────────────┘
6. Salvar

⏱️ Tempo de propagação: 10-60 minutos
EOF
        ;;

    "cloudflare")
        cat <<EOF

╔════════════════════════════════════════════╗
║  Configuração no Cloudflare                ║
╚════════════════════════════════════════════╝

1. Acesse: https://dash.cloudflare.com
2. Selecione o domínio: $domain
3. Vá em DNS
4. Clique em "Adicionar registro"
5. Preencha:
   ┌────────────────────────────────┐
   │ Tipo:  $record_type            │
   │ Nome:  $record_name            │
   │ Alvo:  $record_value           │
   │ TTL:   Auto                    │
   │ Proxy: Desabilitado            │
   └────────────────────────────────┘
6. Salvar

⏱️ Tempo de propagação: 2-10 minutos
EOF
        ;;

    *)
        cat <<EOF

╔════════════════════════════════════════════╗
║  Configuração DNS Manual                   ║
╚════════════════════════════════════════════╝

No painel do seu provedor DNS, adicione:

   ┌────────────────────────────────┐
   │ Tipo:  $record_type            │
   │ Nome:  $record_name            │
   │ Valor: $record_value           │
   │ TTL:   3600                    │
   └────────────────────────────────┘

⏱️ Tempo de propagação: 5-60 minutos
EOF
        ;;
esac

echo ""
echo "💡 Após configurar, use: /domains verify $domain"
```

### 7. Verificar Propagação

```bash
#!/bin/bash

domain="$1"
expected_value="$2"
max_wait=1800  # 30 minutos
interval=30

echo "⏱️ Verificando propagação DNS..."

elapsed=0
while [ $elapsed -lt $max_wait ]; do
    # Verificar DNS
    current_value=$(dig +short "$domain" @8.8.8.8 | head -1)

    if [ "$current_value" = "$expected_value" ]; then
        echo "✅ DNS propagado! ($elapsed segundos)"
        return 0
    fi

    # Atualizar status a cada minuto
    if [ $((elapsed % 60)) -eq 0 ]; then
        minutes=$((elapsed / 60))
        echo "⏱️ Aguardando propagação... (${minutes}min)"
    fi

    sleep $interval
    elapsed=$((elapsed + interval))
done

echo "⚠️ Timeout após 30 minutos"
echo "💡 Verifique a configuração DNS e tente novamente"
return 1
```

### 8. Validar HTTPS

```bash
#!/bin/bash

domain="$1"

echo "🔒 Verificando HTTPS..."

# Aguardar SSL provisionar
sleep 15

# Testar HTTPS
response=$(curl -Is "https://$domain" 2>/dev/null | head -1)

if echo "$response" | grep -q "200"; then
    echo "✅ HTTPS ativo!"

    # Verificar certificado
    cert_issuer=$(echo | openssl s_client -servername "$domain" -connect "$domain":443 2>/dev/null | openssl x509 -noout -issuer | sed 's/issuer=//')

    cert_expiry=$(echo | openssl s_client -servername "$domain" -connect "$domain":443 2>/dev/null | openssl x509 -noout -enddate | sed 's/notAfter=//')

    echo "📜 Certificado:"
    echo "   Emissor: $cert_issuer"
    echo "   Validade: $cert_expiry"
else
    echo "⚠️ HTTPS ainda não está ativo"
    echo "💡 Aguarde 5-10 minutos e tente novamente"
    echo "   Use: /domains verify $domain"
fi
```

---

## Outputs

```yaml
outputs:
  status: success | pending | error
  domain: meusite.com.br
  dns_provider: registro.br
  configuration_type: manual | automatic
  dns_records:
    - type: A
      name: "@"
      value: 76.76.21.21
  propagation_time: 14min 23s
  https_active: true
  ssl_certificate:
    issuer: Let's Encrypt
    valid_until: 2024-04-15
  final_url: https://meusite.com.br
  instructions_path: workspace/[projeto]/deploy/domains/meusite.com.br-instructions.md
```

---

## Tratamento de Erros

### Domínio já em Uso

```yaml
erro: Domain already in use
causa: Domínio já conectado a outro projeto
solucao:
  - Remover do projeto anterior
  - Ou usar subdomínio diferente
comando: vercel domains rm meusite.com.br --scope outro-projeto
```

### DNS Não Propaga

```yaml
erro: DNS not propagating
causa: Registros DNS incorretos ou TTL alto
solucao:
  - Verificar registros no painel DNS
  - Confirmar valores exatos
  - Limpar cache DNS local
  - Aguardar TTL expirar
diagnostico:
  - dig +trace meusite.com.br
  - nslookup meusite.com.br
  - https://whatsmydns.net
```

### HTTPS Não Ativa

```yaml
erro: HTTPS not activating
causa: DNS ainda não propagou ou erro no SSL
solucao:
  - Aguardar DNS propagar completamente
  - Forçar renovação SSL no provider
  - Verificar CAA records (se houver)
tempo_espera: 5-10 minutos após DNS propagar
```

---

## Salvando Configuração

```yaml
# workspace/[projeto]/deploy/domains/meusite.com.br.yaml
domain: meusite.com.br
configured_at: 2024-01-15 14:45:33
provider: vercel
dns_provider: registro.br
configuration_type: manual

dns_records:
  - type: A
    name: "@"
    value: 76.76.21.21
    ttl: 3600

status: active
https: true
ssl_certificate:
  issuer: Let's Encrypt
  issued: 2024-01-15
  expires: 2024-04-15

propagation_time: 14min 23s
verification_history:
  - timestamp: 2024-01-15 14:45:00
    status: pending
  - timestamp: 2024-01-15 14:59:23
    status: propagated
  - timestamp: 2024-01-15 15:00:10
    status: https_active
```

---

## Notificações

### Configuração Iniciada

```
🔧 Configurando domínio: meusite.com.br

✅ Domínio adicionado na Vercel
📍 DNS Provider: Registro.br

📋 Próximo passo: Configurar DNS
[Instruções detalhadas]
```

### Aguardando Propagação

```
⏱️ Aguardando propagação DNS...

⏲️ Tempo decorrido: 5min 23s
🔄 Próxima verificação: 30s

💡 Enquanto aguarda, você pode:
- Usar a URL temporária: https://projeto.vercel.app
- Verificar propagação: https://whatsmydns.net

Vou te notificar quando estiver pronto!
```

### Configuração Concluída

```
🎉 Domínio configurado com sucesso!

✅ DNS propagado (14min 23s)
✅ HTTPS ativo
🔒 SSL: Let's Encrypt (válido até 15/04/2024)

🌐 Seu site está disponível em:
https://meusite.com.br

📊 Performance:
- Response time: 1.1s
- SSL Grade: A+
```

---

## Referências

- [dns-specialist.md](../agentes/dns-specialist.md)
- [qa-validator.md](../agentes/qa-validator.md)
