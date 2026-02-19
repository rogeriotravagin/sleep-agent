# Setup Completo - Extensão Deploy

Guia passo a passo para configurar tudo que você precisa para fazer deploy de sites.

---

## 📋 Checklist Inicial

Antes de começar, você vai precisar de:

- [ ] Conta no Vercel (gratuita)
- [ ] Token de API do Vercel
- [ ] Node.js instalado (para usar o Vercel CLI)

**Tempo estimado:** 10-15 minutos

---

## 1️⃣ Criar Conta na Vercel

### Passo 1.1: Verificar se já tem conta

Acesse: https://vercel.com/login

- ✅ **Já tem conta?** → Faça login e pule para a [Seção 2](#2%EF%B8%8F⃣-obter-token-de-api-da-vercel)
- ❌ **Não tem conta?** → Continue abaixo

### Passo 1.2: Criar conta gratuita

1. Acesse: https://vercel.com/signup

2. Escolha uma opção de cadastro:
   - **GitHub** (Recomendado - conecta seus repositórios automaticamente)
   - **GitLab**
   - **Bitbucket**
   - **Email** (cadastro manual)

3. Siga as instruções na tela para completar o cadastro

4. Confirme seu email (se cadastrou por email)

5. Pronto! Você tem uma conta Vercel gratuita 🎉

**Plano Gratuito inclui:**
- ✅ Deploys ilimitados
- ✅ HTTPS automático
- ✅ 100GB de largura de banda por mês
- ✅ Domínios customizados
- ✅ Preview URLs

---

## 2️⃣ Obter Token de API da Vercel

### Por que preciso do token?

O token permite que o Sleep Agent faça deploys automaticamente sem precisar de login manual toda vez.

### Passo 2.1: Acessar página de tokens

1. Faça login na Vercel: https://vercel.com/login

2. Clique no seu avatar (canto superior direito)

3. Clique em **"Settings"**

4. No menu lateral esquerdo, clique em **"Tokens"**

   Ou acesse diretamente: https://vercel.com/account/tokens

### Passo 2.2: Criar novo token

1. Na página de Tokens, clique em **"Create"** ou **"Create Token"**

2. Preencha as informações:

   **Token Name:** (nome para identificar o token)
   ```
   Sleep Agent Deploy
   ```

   **Scope:** (deixe como está - "Full Account")

   **Expiration:** (quando o token expira)
   - Recomendação: **No Expiration** (nunca expira)
   - Ou: **30 days / 60 days / 90 days** (se preferir renovar periodicamente)

3. Clique em **"Create Token"**

### Passo 2.3: Copiar e salvar o token

⚠️ **MUITO IMPORTANTE:**

O token será mostrado **apenas uma vez**. Se você fechar a página sem copiar, terá que criar um novo token.

1. Copie o token que aparece na tela

   **Exemplo de token:**
   ```
   mby6idUuGLDAQ0h7gB1x7R1Q
   ```

2. **Guarde em local seguro** - sugestões:
   - Gerenciador de senhas (LastPass, 1Password, Bitwarden)
   - Arquivo `.env` no seu projeto (explicado abaixo)
   - Nota segura no celular

3. ✅ **Não compartilhe este token** - ele dá acesso total à sua conta Vercel

---

## 3️⃣ Configurar Token no Projeto

### Opção A: Arquivo .env (Recomendado)

1. No diretório do seu projeto, crie um arquivo chamado `.env`

2. Adicione o token no arquivo:

```bash
# Vercel Deploy Token
VERCEL_TOKEN=seu-token-aqui
```

**Exemplo:**
```bash
# Vercel Deploy Token
VERCEL_TOKEN=mby6idUuGLDAQ0h7gB1x7R1Q
```

3. Crie/atualize o arquivo `.gitignore` para **não commitar o token**:

```bash
# .gitignore
.env
.vercel
*.log
node_modules/
```

### Opção B: Variável de Ambiente Global

**Windows (PowerShell):**
```powershell
$env:VERCEL_TOKEN="seu-token-aqui"
```

**Windows (CMD):**
```cmd
set VERCEL_TOKEN=seu-token-aqui
```

**Linux/Mac:**
```bash
export VERCEL_TOKEN="seu-token-aqui"
```

Para tornar permanente, adicione ao arquivo de perfil:
- **Linux/Mac:** `~/.bashrc` ou `~/.zshrc`
- **Windows:** Variáveis de Ambiente do Sistema

---

## 4️⃣ Instalar Vercel CLI

### Passo 4.1: Verificar se Node.js está instalado

```bash
node --version
```

- ✅ **Retornou versão** (ex: `v18.17.0`) → Continue
- ❌ **Comando não encontrado** → Instale Node.js

**Instalar Node.js:**
1. Acesse: https://nodejs.org/
2. Baixe a versão **LTS (Recommended)**
3. Execute o instalador
4. Verifique novamente: `node --version`

### Passo 4.2: Instalar Vercel CLI globalmente

```bash
npm install -g vercel
```

**Aguarde a instalação** (pode levar 1-2 minutos)

### Passo 4.3: Verificar instalação

```bash
vercel --version
```

Deve retornar algo como:
```
Vercel CLI 50.9.6
```

✅ **Pronto! Vercel CLI instalado com sucesso**

---

## 5️⃣ Testar Configuração

Vamos testar se tudo está funcionando.

### Teste 1: Verificar autenticação com token

```bash
vercel whoami --token="seu-token-aqui"
```

**Exemplo:**
```bash
vercel whoami --token="seu-token-aqui"
```

**Resultado esperado:**
```
> Seu Nome
> Email: seuemail@exemplo.com
```

✅ **Se retornou seu nome/email** → Token está funcionando!
❌ **Se deu erro** → Verifique se copiou o token corretamente

### Teste 2: Criar projeto de teste

```bash
# 1. Criar pasta de teste
mkdir teste-deploy
cd teste-deploy

# 2. Criar arquivo HTML simples
echo "<h1>Deploy funcionando!</h1>" > index.html

# 3. Fazer deploy de teste
vercel --prod --token="seu-token-aqui"
```

**Resultado esperado:**
```
✅ Production: https://teste-deploy-xxxx.vercel.app
```

Abra a URL no navegador - você deve ver "Deploy funcionando!" 🎉

---

## 6️⃣ Integrar com Sleep Agent

### Passo 6.1: Configurar token no workspace

```bash
# Navegue ate o workspace do Sleep Agent
cd workspace/

# Crie pasta de configuracao (se nao existir)
mkdir -p .config

# Crie arquivo com o token
echo "VERCEL_TOKEN=seu-token-aqui" > .config/.env
```

### Passo 6.2: Testar com Sleep Agent

No Sleep Agent, digite:

```
/deploy
```

O Sleep Agent vai:
1. ✅ Detectar o token no `.env`
2. ✅ Verificar seu projeto
3. ✅ Fazer deploy automaticamente
4. ✅ Retornar a URL do site

---

## ✅ Checklist Final

Confirme que completou todos os passos:

- [ ] ✅ Conta criada na Vercel
- [ ] ✅ Token de API gerado
- [ ] ✅ Token salvo em `.env`
- [ ] ✅ `.gitignore` configurado (protegendo o token)
- [ ] ✅ Node.js instalado
- [ ] ✅ Vercel CLI instalado
- [ ] ✅ Teste de autenticação passou
- [ ] ✅ Deploy de teste funcionou

**🎉 Tudo pronto! Agora você pode fazer deploy com o Sleep Agent!**

---

## 🔒 Segurança do Token

### ⚠️ IMPORTANTE - NÃO FAÇA ISSO:

❌ **NÃO** compartilhe seu token
❌ **NÃO** commite o token no Git
❌ **NÃO** poste o token em fóruns/chats
❌ **NÃO** inclua o token em screenshots

### ✅ BOAS PRÁTICAS:

✅ **SEMPRE** use arquivo `.env`
✅ **SEMPRE** adicione `.env` ao `.gitignore`
✅ **SEMPRE** guarde em local seguro
✅ **SEMPRE** revogue tokens antigos que não usa mais

### Se o token vazou:

1. Acesse: https://vercel.com/account/tokens
2. Encontre o token comprometido
3. Clique nos 3 pontos (⋮) → **Delete**
4. Crie um novo token
5. Atualize seu `.env` com o novo token

---

## 🆘 Troubleshooting

### Erro: "Token is not valid"

**Causa:** Token incorreto ou expirado

**Solução:**
1. Verifique se copiou o token completo
2. Crie um novo token se necessário
3. Atualize o `.env`

### Erro: "vercel: command not found"

**Causa:** Vercel CLI não instalado ou não está no PATH

**Solução:**
```bash
# Reinstalar Vercel CLI
npm install -g vercel

# Verificar instalação
vercel --version
```

### Erro: "EACCES: permission denied"

**Causa:** Permissões insuficientes para instalar globalmente

**Solução Linux/Mac:**
```bash
sudo npm install -g vercel
```

**Solução Windows:**
- Execute o terminal como Administrador
- Reinstale o Vercel CLI

### Erro: "No such file or directory"

**Causa:** Arquivo `.env` não encontrado

**Solução:**
1. Certifique-se de estar no diretório correto
2. Crie o arquivo `.env` manualmente
3. Adicione o token

---

## 📚 Recursos Adicionais

### Documentação Oficial

- **Vercel:** https://vercel.com/docs
- **Vercel CLI:** https://vercel.com/docs/cli
- **Tokens:** https://vercel.com/docs/rest-api#authentication

### Tutoriais em Vídeo

- **Criar conta Vercel:** https://www.youtube.com/results?search_query=criar+conta+vercel
- **Deploy na Vercel:** https://www.youtube.com/results?search_query=deploy+vercel

### Suporte

- **Vercel Support:** https://vercel.com/support
- **Sleep Agent Issues:** (repositório do projeto)

---

## 🎯 Próximos Passos

Após completar o setup:

1. **Fazer primeiro deploy:** [QUICK-START.md](QUICK-START.md)
2. **Configurar domínio:** [README.md](README.md#domains)
3. **Automatizar deploys:** [QUICK-START.md](QUICK-START.md#deploy-automático)

---

**Setup completo! 🚀 Agora você está pronto para fazer deploy de sites automaticamente com o Sleep Agent!**
