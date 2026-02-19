# Playwright - Fundamentos de Automação Web

## O Que é Playwright?

**Para não-técnicos:** Playwright é uma ferramenta que cria "robôs" que controlam o navegador automaticamente. Como se você estivesse usando o mouse e teclado, mas de forma automática.

**Tecnicamente:** Playwright é um framework de automação de navegador desenvolvido pela Microsoft que permite controlar Chrome, Firefox e Safari programaticamente.

## Conceitos Fundamentais

### 1. Browser (Navegador)

O navegador que será controlado.

**Suporta:**
- Chromium (base do Chrome)
- Firefox
- WebKit (base do Safari)

**Exemplo:**
```javascript
const { chromium } = require('playwright');
const browser = await chromium.launch();
```

### 2. Context (Contexto)

Um "perfil" isolado dentro do navegador, com seus próprios cookies e sessão.

**Analogia:** Como usar "modo anônimo" - cada context é independente.

**Exemplo:**
```javascript
const context = await browser.newContext();
```

### 3. Page (Página)

Uma aba do navegador.

**Exemplo:**
```javascript
const page = await context.newPage();
```

### 4. Element (Elemento)

Qualquer componente da página: botão, input, div, link, etc.

**Seletores comuns:**
```javascript
// Por ID
'#submit-button'

// Por classe
'.btn-primary'

// Por atributo
'[data-testid="login-button"]'

// Por texto
'text=Enviar'

// Por name
'input[name="email"]'
```

## Ações Básicas

### 1. Navegar para uma Página
```javascript
await page.goto('https://example.com');

// Com opções
await page.goto('https://example.com', {
    waitUntil: 'networkidle'  // Aguardar rede ficar ociosa
});
```

### 2. Clicar em Elemento
```javascript
// Clicar em botão
await page.click('button.submit');

// Clicar com opções
await page.click('button', {
    clickCount: 2  // Duplo clique
});
```

### 3. Preencher Campo de Texto
```javascript
// Preencher input
await page.fill('input[name="email"]', 'usuario@example.com');

// Digitar caractere por caractere (mais lento, mais realista)
await page.type('input[name="senha"]', 'minhasenha', {
    delay: 100  // 100ms entre cada tecla
});
```

### 4. Selecionar em Dropdown
```javascript
// Por valor
await page.selectOption('select#pais', 'BR');

// Por label
await page.selectOption('select#pais', { label: 'Brasil' });

// Múltiplas seleções
await page.selectOption('select#opcoes', ['opcao1', 'opcao2']);
```

### 5. Marcar Checkbox / Radio Button
```javascript
// Marcar
await page.check('input[type="checkbox"]');

// Desmarcar
await page.uncheck('input[type="checkbox"]');

// Radio button
await page.check('input[value="masculino"]');
```

### 6. Upload de Arquivo
```javascript
await page.setInputFiles('input[type="file"]', './documento.pdf');

// Múltiplos arquivos
await page.setInputFiles('input[type="file"]', [
    './arquivo1.pdf',
    './arquivo2.pdf'
]);
```

### 7. Pressionar Teclas
```javascript
// Enter
await page.press('input', 'Enter');

// Ctrl+A
await page.press('input', 'Control+A');

// Teclas especiais
await page.keyboard.press('Escape');
await page.keyboard.press('Tab');
```

## Esperar por Elementos (Waits)

**Muito importante:** Páginas web carregam assincronamente. Sempre espere elementos estarem prontos!

### 1. Esperar Elemento Aparecer
```javascript
// Esperar até elemento estar visível
await page.waitForSelector('button.submit', {
    state: 'visible',
    timeout: 10000  // 10 segundos
});
```

### 2. Esperar Navegação
```javascript
// Esperar página carregar após clique
await Promise.all([
    page.waitForNavigation(),
    page.click('a.link')
]);
```

### 3. Esperar Rede Ficar Ociosa
```javascript
await page.waitForLoadState('networkidle');
```

### 4. Esperar Tempo Fixo (use com moderação!)
```javascript
await page.waitForTimeout(2000);  // 2 segundos
// ⚠️ Use apenas quando realmente necessário
```

### 5. Esperar Condição Customizada
```javascript
await page.waitForFunction(() => {
    return document.querySelector('.dados')?.textContent !== '';
});
```

## Extrair Dados da Página

### 1. Obter Texto de Elemento
```javascript
const texto = await page.textContent('.titulo');
console.log(texto);
```

### 2. Obter Valor de Input
```javascript
const email = await page.inputValue('input[name="email"]');
```

### 3. Obter Atributo
```javascript
const href = await page.getAttribute('a.link', 'href');
const src = await page.getAttribute('img', 'src');
```

### 4. Verificar se Elemento Existe/Está Visível
```javascript
const exists = await page.isVisible('.mensagem-sucesso');
if (exists) {
    console.log('✅ Mensagem de sucesso apareceu');
}
```

### 5. Extrair Múltiplos Elementos
```javascript
const produtos = await page.$$eval('.produto', items => {
    return items.map(item => ({
        nome: item.querySelector('.nome')?.textContent,
        preco: item.querySelector('.preco')?.textContent,
        link: item.querySelector('a')?.href
    }));
});

console.log(`${produtos.length} produtos encontrados`);
```

## Screenshots e PDFs

### 1. Capturar Screenshot
```javascript
// Screenshot da página inteira
await page.screenshot({
    path: 'screenshot.png',
    fullPage: true
});

// Screenshot de elemento específico
await page.locator('.grafico').screenshot({
    path: 'grafico.png'
});
```

### 2. Gerar PDF
```javascript
await page.pdf({
    path: 'pagina.pdf',
    format: 'A4',
    printBackground: true
});
```

## Tratamento de Pop-ups e Modais

### 1. Aceitar/Rejeitar Dialogs
```javascript
page.on('dialog', async dialog => {
    console.log(`Dialog: ${dialog.message()}`);
    await dialog.accept();  // Ou dialog.dismiss()
});
```

### 2. Lidar com Abas Novas
```javascript
const [newPage] = await Promise.all([
    context.waitForEvent('page'),
    page.click('a[target="_blank"]')  // Link que abre nova aba
]);

await newPage.waitForLoadState();
console.log(await newPage.title());
```

## Modo Headless vs Headed

### Headless (Padrão)
```javascript
const browser = await chromium.launch({
    headless: true  // Não abre janela visível
});
```

**Vantagens:**
- ✅ Mais rápido
- ✅ Usa menos recursos
- ✅ Roda em servidores sem interface gráfica

### Headed (Com Interface)
```javascript
const browser = await chromium.launch({
    headless: false,  // Abre navegador visível
    slowMo: 1000      // Adiciona delay de 1s entre ações (para visualizar)
});
```

**Vantagens:**
- ✅ Ver o que está acontecendo
- ✅ Melhor para debug
- ✅ Útil para demonstrações

## Login e Cookies

### 1. Login Básico
```javascript
async function login(page, username, password) {
    await page.goto('https://example.com/login');

    await page.fill('input[name="username"]', username);
    await page.fill('input[name="password"]', password);

    await Promise.all([
        page.waitForNavigation(),
        page.click('button[type="submit"]')
    ]);

    // Verificar se login funcionou
    const isLoggedIn = await page.isVisible('.user-menu');
    return isLoggedIn;
}
```

### 2. Salvar/Carregar Cookies (manter sessão)
```javascript
// Salvar cookies após login
const cookies = await context.cookies();
fs.writeFileSync('cookies.json', JSON.stringify(cookies));

// Carregar cookies em nova sessão
const savedCookies = JSON.parse(fs.readFileSync('cookies.json'));
await context.addCookies(savedCookies);
```

## Tratamento de Erros

### 1. Try-Catch Básico
```javascript
try {
    await page.click('button.submit', { timeout: 5000 });
    console.log('✅ Botão clicado');
} catch (error) {
    console.error('❌ Erro ao clicar:', error.message);
    await page.screenshot({ path: 'erro.png' });
}
```

### 2. Verificar Elemento Antes de Interagir
```javascript
const exists = await page.isVisible('button.submit');
if (exists) {
    await page.click('button.submit');
} else {
    console.warn('⚠️  Botão não encontrado');
}
```

### 3. Retry Logic
```javascript
async function clickWithRetry(page, selector, maxRetries = 3) {
    for (let i = 0; i < maxRetries; i++) {
        try {
            await page.click(selector, { timeout: 5000 });
            console.log('✅ Clique bem-sucedido');
            return true;
        } catch (error) {
            console.warn(`⚠️  Tentativa ${i + 1}/${maxRetries} falhou`);
            if (i === maxRetries - 1) {
                console.error('❌ Todas as tentativas falharam');
                await page.screenshot({ path: 'erro_click.png' });
                throw error;
            }
            await page.waitForTimeout(2000);  // Aguardar antes de tentar novamente
        }
    }
}
```

## Exemplo Completo: Automação de Formulário

```javascript
const { chromium } = require('playwright');

async function preencherFormulario() {
    // 1. Inicializar
    const browser = await chromium.launch({ headless: false });
    const context = await browser.newContext();
    const page = await context.newPage();

    try {
        // 2. Navegar
        console.log('🌐 Acessando página...');
        await page.goto('https://example.com/formulario');
        await page.screenshot({ path: '01_pagina_inicial.png' });

        // 3. Preencher campos
        console.log('✏️  Preenchendo formulário...');
        await page.fill('input[name="nome"]', 'João Silva');
        await page.fill('input[name="email"]', 'joao@example.com');
        await page.fill('input[name="telefone"]', '11999999999');
        await page.selectOption('select[name="pais"]', 'BR');
        await page.check('input[name="aceito_termos"]');

        await page.screenshot({ path: '02_formulario_preenchido.png' });

        // 4. Enviar
        console.log('📤 Enviando formulário...');
        await Promise.all([
            page.waitForNavigation({ waitUntil: 'networkidle' }),
            page.click('button[type="submit"]')
        ]);

        // 5. Verificar sucesso
        const sucesso = await page.isVisible('.mensagem-sucesso');
        if (sucesso) {
            console.log('✅ Formulário enviado com sucesso!');
            await page.screenshot({ path: '03_sucesso.png' });
        } else {
            console.error('❌ Erro ao enviar formulário');
            await page.screenshot({ path: '03_erro.png' });
        }

    } catch (error) {
        console.error('❌ Erro durante automação:', error.message);
        await page.screenshot({ path: 'erro_geral.png' });
    } finally {
        // 6. Limpar
        await browser.close();
        console.log('🏁 Automação finalizada');
    }
}

preencherFormulario();
```

## Boas Práticas

### 1. Sempre Use Timeouts
```javascript
await page.click('button', { timeout: 10000 });  // ✅ Bom
await page.click('button');  // ⚠️ Usa timeout padrão (30s)
```

### 2. Prefira Seletores Estáveis
```javascript
// ✅ Melhor - Data attributes (criados para testes)
await page.click('[data-testid="submit-button"]');

// ✅ Bom - Classes semânticas
await page.click('.btn-submit');

// ⚠️ Okay - Por texto (se único)
await page.click('text=Enviar');

// ❌ Evitar - IDs dinâmicos
await page.click('#button-12345678');

// ❌ Evitar - Seletores frágeis
await page.click('div > div > div > button:nth-child(3)');
```

### 3. Screenshots para Debug
```javascript
// Após cada ação importante
await page.fill('input', 'valor');
await page.screenshot({ path: 'apos_preencher.png' });

// Em catch de erros
catch (error) {
    await page.screenshot({ path: 'erro.png' });
    throw error;
}
```

### 4. Logs Claros
```javascript
console.log('🌐 Acessando página...');
console.log('🔐 Fazendo login...');
console.log('✏️  Preenchendo formulário...');
console.log('✅ Sucesso!');
console.error('❌ Erro!');
```

### 5. Sempre Fechar Navegador
```javascript
try {
    // ... automação ...
} finally {
    await browser.close();  // Garante que navegador fecha
}
```

## Limitações Importantes

### ❌ Não Funciona com Captchas
Automações não conseguem resolver captchas automaticamente. Se o site tiver captcha, precisará intervenção manual.

### ❌ Sites que Mudam Constantemente
Se o site mudar a estrutura HTML, os seletores podem quebrar e a automação precisará ser atualizada.

### ❌ Detecção de Bots
Alguns sites detectam e bloqueiam automações. Playwright tem opções para ser "mais humano", mas não é garantido.

### ⚠️ Performance
Automações são mais lentas que APIs. Use APIs quando disponíveis.

## Recursos Adicionais

- **Documentação oficial:** https://playwright.dev
- **Playwright Inspector:** Debug visual de automações
- **Codegen:** Gerar código automaticamente gravando ações
- **Trace Viewer:** Analisar execução passo a passo

## Comandos Úteis

```bash
# Instalar Playwright
npm install playwright

# Instalar navegadores
npx playwright install

# Gerar código (codegen)
npx playwright codegen https://example.com

# Abrir Playwright Inspector
PWDEBUG=1 node script.js

# Executar com trace
npx playwright test --trace on
```

## Glossário

- **Selector:** Identificador de elemento (CSS, XPath, etc)
- **Locator:** Objeto que representa um elemento
- **Context:** Sessão isolada do navegador
- **Headless:** Modo sem interface gráfica
- **Screenshot:** Captura de tela
- **Wait:** Esperar por condição
- **Navigation:** Mudança de página/URL
