# Boas Práticas de Automação

## Princípios Fundamentais

### 1. KISS - Keep It Simple, Stupid
**Princípio:** Automações simples funcionam melhor que automações complexas.

**Na prática:**
✅ Resolver um problema específico muito bem
❌ Tentar resolver tudo de uma vez

**Exemplo:**
- ✅ Automatizar preenchimento de 1 formulário
- ❌ Criar sistema genérico que preenche qualquer formulário

### 2. Fail Fast, Fail Loud
**Princípio:** Quando der erro, falhe rápido e avise claramente.

**Na prática:**
```python
# ❌ Ruim - ignora erro silenciosamente
try:
    result = api_call()
except:
    result = None  # E agora? O que fazer?

# ✅ Bom - falha rápido com erro claro
try:
    result = api_call()
except APIError as e:
    logger.error(f"Falha na API: {e}")
    send_alert("API falhou!")
    raise  # Re-lança erro para parar execução
```

### 3. DRY - Don't Repeat Yourself
**Princípio:** Não repita código. Crie funções reutilizáveis.

**Na prática:**
```javascript
// ❌ Ruim - código repetido
await page.fill('#email', email);
await page.waitForTimeout(1000);
await page.fill('#nome', nome);
await page.waitForTimeout(1000);
await page.fill('#telefone', telefone);
await page.waitForTimeout(1000);

// ✅ Bom - função reutilizável
async function preencherCampo(selector, valor) {
    await page.fill(selector, valor);
    await page.waitForTimeout(1000);
}

await preencherCampo('#email', email);
await preencherCampo('#nome', nome);
await preencherCampo('#telefone', telefone);
```

### 4. Idempotência
**Princípio:** Executar a automação múltiplas vezes deve dar o mesmo resultado.

**Na prática:**
```python
# ❌ Ruim - cria duplicado se rodar 2 vezes
def criar_usuario(nome):
    db.insert({"nome": nome})

# ✅ Bom - verifica se já existe
def criar_usuario(nome):
    if not db.exists({"nome": nome}):
        db.insert({"nome": nome})
    else:
        logger.info(f"Usuário {nome} já existe")
```

### 5. Observabilidade
**Princípio:** Você deve saber o que a automação está fazendo e quando falha.

**Na prática:**
- Logs em cada etapa importante
- Screenshots de erros
- Métricas de execução
- Alertas quando falha

## Tratamento de Erros

### Hierarquia de Tratamento

```
1. PREVENIR
   ↓ (se não der para prevenir)
2. TRATAR GRACEFULLY
   ↓ (se não der para tratar)
3. LOGAR E ALERTAR
   ↓ (sempre)
4. FALHAR DE FORMA CONTROLADA
```

### 1. PREVENIR Erros

```python
# Validar entrada antes de processar
def processar_pedido(pedido):
    # Prevenir erro validando primeiro
    if not pedido.get('email'):
        raise ValueError("Email é obrigatório")

    if not '@' in pedido['email']:
        raise ValueError("Email inválido")

    # Agora pode processar com segurança
    ...
```

### 2. TRATAR Gracefully

```python
# Retry com exponential backoff
def fazer_requisicao_com_retry(url, max_tentativas=3):
    for tentativa in range(max_tentativas):
        try:
            response = requests.get(url, timeout=30)
            response.raise_for_status()
            return response.json()

        except requests.Timeout:
            if tentativa == max_tentativas - 1:
                raise
            tempo_espera = 2 ** tentativa  # 1s, 2s, 4s
            logger.warning(f"Timeout. Tentando novamente em {tempo_espera}s...")
            time.sleep(tempo_espera)

        except requests.HTTPError as e:
            if e.response.status_code == 429:  # Rate limit
                retry_after = int(e.response.headers.get('Retry-After', 60))
                logger.warning(f"Rate limit. Aguardando {retry_after}s...")
                time.sleep(retry_after)
            else:
                raise
```

### 3. LOGAR e ALERTAR

```python
import logging

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('automation.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

# Usar em automação
try:
    logger.info("Iniciando processamento do pedido #123")
    processar_pedido(pedido)
    logger.info("✅ Pedido #123 processado com sucesso")
except Exception as e:
    logger.error(f"❌ Erro ao processar pedido #123: {e}", exc_info=True)
    enviar_alerta_urgente(f"Pedido #123 falhou: {e}")
    raise
```

### 4. FALHAR de Forma Controlada

```javascript
async function automacao() {
    let browser;

    try {
        browser = await chromium.launch();
        const page = await browser.newPage();

        // ... automação ...

    } catch (error) {
        console.error('❌ Erro:', error.message);

        // Salvar estado para debug
        if (page) {
            await page.screenshot({ path: 'erro.png' });
        }

        // Enviar alerta
        await enviarAlerta(`Automação falhou: ${error.message}`);

        throw error;  // Re-lançar para quem chamou saber que falhou

    } finally {
        // SEMPRE fechar recursos
        if (browser) {
            await browser.close();
        }
    }
}
```

## Configuração e Credenciais

### NUNCA Hardcode Credenciais

```python
# ❌ PÉSSIMO - credenciais no código
api_key = "abc123def456"
password = "minhasenha123"

# ✅ BOM - variáveis de ambiente
import os
from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv('API_KEY')
password = os.getenv('PASSWORD')

if not api_key:
    raise ValueError("API_KEY não configurada")
```

### Estrutura de Configuração

```python
# config.py
import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Configuração centralizada"""

    # API
    API_BASE_URL = os.getenv('API_BASE_URL', 'https://api.example.com')
    API_KEY = os.getenv('API_KEY')

    # Timeouts
    REQUEST_TIMEOUT = int(os.getenv('REQUEST_TIMEOUT', '30'))
    BROWSER_TIMEOUT = int(os.getenv('BROWSER_TIMEOUT', '60'))

    # Retry
    MAX_RETRIES = int(os.getenv('MAX_RETRIES', '3'))

    # Logs
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')

    # Validar configurações obrigatórias
    @classmethod
    def validar(cls):
        if not cls.API_KEY:
            raise ValueError("API_KEY é obrigatória")

# Validar ao importar
Config.validar()
```

### Arquivo .env.example

```bash
# .env.example - Commit isso no Git
# Copie para .env e preencha com valores reais

# API Configuration
API_BASE_URL=https://api.example.com
API_KEY=your_api_key_here

# Timeouts (seconds)
REQUEST_TIMEOUT=30
BROWSER_TIMEOUT=60

# Retry Configuration
MAX_RETRIES=3

# Logging
LOG_LEVEL=INFO
```

## Logs Eficazes

### Níveis de Log

```python
# DEBUG - Informação detalhada para debugging
logger.debug(f"Payload enviado: {payload}")

# INFO - Eventos normais da aplicação
logger.info("✅ Pedido #123 processado com sucesso")

# WARNING - Algo inesperado mas não crítico
logger.warning("⚠️ Rate limit atingido, aguardando...")

# ERROR - Erro que impediu operação
logger.error("❌ Falha ao conectar API", exc_info=True)

# CRITICAL - Erro crítico que afeta sistema todo
logger.critical("💥 Banco de dados inacessível")
```

### O Que Logar

**✅ SEMPRE logar:**
- Início e fim de processo
- Decisões importantes (if/else que importa)
- Chamadas externas (API, banco, etc)
- Erros e exceções
- Métricas (tempo, quantidade processada)

**❌ NUNCA logar:**
- Senhas, tokens, API keys
- Dados pessoais sensíveis (CPF, cartão de crédito)
- Payloads completos em produção

**Exemplo:**
```python
# ❌ Ruim - loga senha
logger.info(f"Login com: {username} / {password}")

# ❌ Ruim - loga token
logger.info(f"Token: {api_token}")

# ✅ Bom - omite dados sensíveis
logger.info(f"Login com usuário: {username}")
logger.info(f"Token obtido com sucesso (exp: {expiry})")

# ✅ Bom - mascara dados
logger.info(f"Processando cartão: ****-****-****-{card_last4}")
```

## Testes e Validação

### 1. Testar com Dados Variados

```python
# Não teste só caso feliz
def test_processar_pedido():
    # ✅ Caso normal
    assert processar_pedido({"email": "test@test.com"}) == sucesso

    # ✅ Email inválido
    with pytest.raises(ValueError):
        processar_pedido({"email": "invalido"})

    # ✅ Email faltando
    with pytest.raises(ValueError):
        processar_pedido({})

    # ✅ Campo extra inesperado
    assert processar_pedido({"email": "test@test.com", "extra": "value"}) == sucesso
```

### 2. Testar Cenários de Erro

- Rede lenta (timeout)
- Serviço fora do ar (ConnectionError)
- Rate limit (429)
- Autenticação expirada (401)
- Dados malformados
- Elemento não encontrado (Playwright)

### 3. Validar Antes de Produção

**Checklist:**
- [ ] Testado com dados reais (ambiente de teste)
- [ ] Testado cenários de erro
- [ ] Logs estão claros e úteis
- [ ] Screenshots funcionando
- [ ] Alertas configurados
- [ ] Documentação atualizada
- [ ] Variáveis de ambiente documentadas
- [ ] Timeout configurado adequadamente
- [ ] Retry logic implementado

## Performance e Otimização

### 1. Não Otimize Prematuramente

**Regra:** Faça funcionar primeiro, otimize depois (se necessário).

```python
# Primeiro: faça funcionar
def processar_itens(itens):
    for item in itens:
        processar(item)

# Depois (se for gargalo): otimize
def processar_itens_paralelo(itens):
    with ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(processar, itens)
```

### 2. Rate Limiting Proativo

```python
import time
from datetime import datetime, timedelta

class RateLimiter:
    def __init__(self, max_requests, periodo_segundos):
        self.max_requests = max_requests
        self.periodo = timedelta(seconds=periodo_segundos)
        self.requests = []

    def aguardar_se_necessario(self):
        agora = datetime.now()

        # Remover requests antigas
        self.requests = [r for r in self.requests if agora - r < self.periodo]

        # Se atingiu limite, aguardar
        if len(self.requests) >= self.max_requests:
            mais_antigo = min(self.requests)
            tempo_espera = (mais_antigo + self.periodo - agora).total_seconds()
            if tempo_espera > 0:
                logger.info(f"Rate limit: aguardando {tempo_espera:.1f}s")
                time.sleep(tempo_espera)

        self.requests.append(agora)

# Uso
limiter = RateLimiter(max_requests=100, periodo_segundos=60)

for item in itens:
    limiter.aguardar_se_necessario()
    api_call(item)
```

### 3. Caching Inteligente

```python
from functools import lru_cache
import time

# Cache de função pura
@lru_cache(maxsize=100)
def buscar_configuracao(key):
    # Operação cara
    return db.get(key)

# Cache com TTL (Time To Live)
class CacheComTTL:
    def __init__(self, ttl_segundos=300):
        self.cache = {}
        self.ttl = ttl_segundos

    def get(self, key):
        if key in self.cache:
            valor, timestamp = self.cache[key]
            if time.time() - timestamp < self.ttl:
                return valor
            else:
                del self.cache[key]  # Expirado
        return None

    def set(self, key, valor):
        self.cache[key] = (valor, time.time())

# Uso
cache = CacheComTTL(ttl_segundos=600)  # 10 minutos

def buscar_dados_api(id):
    cached = cache.get(id)
    if cached:
        logger.debug(f"Cache hit: {id}")
        return cached

    logger.debug(f"Cache miss: {id}")
    dados = api.get(id)
    cache.set(id, dados)
    return dados
```

## Documentação

### README Mínimo

```markdown
# [Nome da Automação]

## O Que Faz
[Descrição em 1-2 frases do que a automação faz]

## Requisitos
- Python 3.8+
- Node.js 18+ (se usar Playwright)
- [Outras dependências]

## Instalação

```bash
pip install -r requirements.txt
# ou
npm install
```

## Configuração

Copie `.env.example` para `.env` e preencha:

```bash
cp .env.example .env
```

Variáveis obrigatórias:
- `API_KEY` - Chave da API (obter em...)
- `BASE_URL` - URL base do sistema

## Uso

```bash
python automation.py
# ou
node automation.js
```

## Logs

Logs são salvos em `logs/automation.log`

## Troubleshooting

### Erro: "API_KEY não configurada"
**Solução:** Configure API_KEY no arquivo .env

### Erro: "Timeout ao acessar página"
**Solução:** Verifique conexão de internet ou aumente TIMEOUT

## Contato
[Seu nome/email para suporte]
```

### Comentários no Código

```python
# ❌ Comentário inútil
i = i + 1  # Incrementa i

# ✅ Comentário útil
# Aguardar 2s para evitar rate limit (limite é 100/min)
time.sleep(2)

# ✅ Comentário útil
# API retorna status "processing" por até 5 min
# Pooling a cada 10s até completar
while status == "processing":
    time.sleep(10)
    status = check_status()
```

## Segurança

### 1. Sanitização de Inputs

```python
# ❌ Vulnerável a SQL injection
query = f"SELECT * FROM users WHERE email = '{email}'"

# ✅ Seguro - usa prepared statement
query = "SELECT * FROM users WHERE email = ?"
cursor.execute(query, (email,))
```

### 2. Validação de Dados

```python
def validar_email(email):
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    if not re.match(pattern, email):
        raise ValueError(f"Email inválido: {email}")

def processar_pedido(pedido):
    # Validar antes de processar
    validar_email(pedido['email'])

    # Sanitizar strings
    nome = pedido['nome'].strip()[:100]  # Limitar tamanho

    # Processar...
```

### 3. HTTPS e Verificação SSL

```python
# ✅ Sempre usar HTTPS
response = requests.get('https://api.example.com', verify=True)

# ❌ NUNCA em produção
response = requests.get('https://api.example.com', verify=False)  # Inseguro!
```

## Manutenibilidade

### 1. Código Legível

```python
# ❌ Ruim - obscuro
def p(d):
    return sum([x['v'] for x in d if x['s'] == 'a']) / len(d)

# ✅ Bom - claro
def calcular_media_vendas_ativas(vendas):
    """
    Calcula média de valor das vendas ativas.

    Args:
        vendas: Lista de dicionários com vendas

    Returns:
        float: Média dos valores
    """
    vendas_ativas = [v for v in vendas if v['status'] == 'ativa']
    total = sum(venda['valor'] for venda in vendas_ativas)
    return total / len(vendas_ativas) if vendas_ativas else 0
```

### 2. Funções Pequenas e Focadas

```python
# ❌ Função faz muita coisa
def processar_tudo(dados):
    # valida
    # transforma
    # salva no banco
    # envia email
    # atualiza cache
    # ... 200 linhas ...

# ✅ Funções pequenas e focadas
def validar_dados(dados):
    ...

def transformar_dados(dados):
    ...

def salvar_banco(dados):
    ...

def enviar_notificacao(dados):
    ...

def processar(dados):
    validar_dados(dados)
    dados_transformados = transformar_dados(dados)
    salvar_banco(dados_transformados)
    enviar_notificacao(dados_transformados)
```

### 3. Versionamento e Git

```bash
# Commits claros
git commit -m "feat: adiciona retry logic para API calls"
git commit -m "fix: corrige timeout em navegação lenta"
git commit -m "docs: atualiza README com nova config"

# .gitignore essencial
.env
*.log
screenshots/
__pycache__/
node_modules/
```

## Monitoramento

### Métricas Importantes

```python
import time
from datetime import datetime

class Metricas:
    def __init__(self):
        self.inicio = None
        self.fim = None
        self.itens_processados = 0
        self.itens_com_erro = 0

    def iniciar(self):
        self.inicio = datetime.now()

    def finalizar(self):
        self.fim = datetime.now()
        self.relatorio()

    def incrementar_sucesso(self):
        self.itens_processados += 1

    def incrementar_erro(self):
        self.itens_com_erro += 1

    def relatorio(self):
        duracao = (self.fim - self.inicio).total_seconds()
        taxa_sucesso = (self.itens_processados /
                       (self.itens_processados + self.itens_com_erro) * 100)

        logger.info("=" * 50)
        logger.info("RELATÓRIO DE EXECUÇÃO")
        logger.info(f"Início: {self.inicio}")
        logger.info(f"Fim: {self.fim}")
        logger.info(f"Duração: {duracao:.2f}s")
        logger.info(f"Itens processados: {self.itens_processados}")
        logger.info(f"Itens com erro: {self.itens_com_erro}")
        logger.info(f"Taxa de sucesso: {taxa_sucesso:.2f}%")
        logger.info("=" * 50)

# Uso
metricas = Metricas()
metricas.iniciar()

for item in itens:
    try:
        processar(item)
        metricas.incrementar_sucesso()
    except Exception as e:
        logger.error(f"Erro: {e}")
        metricas.incrementar_erro()

metricas.finalizar()
```

---

**Lembre-se:** Código bom é código que funciona, é fácil de entender, e é fácil de manter. Não precisa ser perfeito, precisa ser bom o suficiente.
