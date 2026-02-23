# Base de Conhecimento: HTML Logo Craft

## Por que HTML-first para Logos Digitais

Logos de marcas digital-first vivem em telas. HTML + CSS e o meio nativo dessas telas. SVG e um formato de exportacao - nao o meio de criacao.

### Limitacoes Criticas do SVG para Logos

| Problema | SVG | HTML + CSS |
|----------|-----|------------|
| **Tipografia** | `font-family` depende do sistema. Sem a fonte instalada, cai para fallback | Google Fonts carrega a fonte exata. Renderizacao consistente |
| **Posicionamento** | Coordenadas absolutas (x, y). Desalinha entre browsers | Flexbox/Grid centraliza automaticamente |
| **Efeitos visuais** | Filters XML verbosos, pesados, inconsistentes | `box-shadow`, `text-shadow` - uma linha, GPU-accelerated |
| **Animacao** | SMIL praticamente morto | CSS animations, transitions, keyframes |
| **Responsivo** | viewBox fixo | Media queries, clamp(), container queries |
| **Temas** | Arquivo separado por tema | CSS variables, `prefers-color-scheme` |
| **Interatividade** | Quase zero | Hover, focus, transitions |
| **Kerning/tracking** | Manual, impreciso | `letter-spacing`, `font-feature-settings` |

### Quando AINDA usar SVG

SVG continua necessario para contextos estaticos:
- Favicon (`.svg` ou `.ico`)
- Open Graph / social media (imagem estatica)
- Impressao / sinalizacao
- Icone de app (exportar como PNG)
- Embed em ferramentas de design (Figma, Canva)

**Regra:** Crie em HTML. Exporte SVG limpo para contextos estaticos.

---

## Arquitetura de um Logo HTML Profissional

### Estrutura Base

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;700&display=swap" rel="stylesheet">
<style>
  /* CSS Variables para temas */
  .logo {
    --mark-color: #000;
    --text-muted: #666;
    --text-accent: #000;
  }
</style>
</head>
<body>
  <div class="logo">
    <div class="mark"><!-- Geometria CSS --></div>
    <div class="wordmark">
      <span class="sleep">sleep</span>
      <span class="agent">agent</span>
    </div>
  </div>
</body>
</html>
```

### Principios

1. **CSS Variables para temas** - Uma classe base, variantes por override de variables
2. **Flexbox para layout** - Nunca posicionar com margins absolutas
3. **Google Fonts** - Fonte exata, nao system fallback
4. **`preconnect`** - Performance de carregamento de fontes
5. **Unidades relativas** - `em`, `%`, `clamp()` para responsividade
6. **Transicoes sutis** - Hover states profissionais

---

## Construcao do Mark em CSS

### Formas Geometricas

```css
/* Circulo */
.circle {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  border: 3px solid var(--mark-color);
}

/* Ponto */
.dot {
  width: 13px;
  height: 13px;
  border-radius: 50%;
  background: var(--mark-color);
}

/* Triangulo */
.triangle {
  width: 0;
  height: 0;
  border-left: 20px solid transparent;
  border-right: 20px solid transparent;
  border-bottom: 35px solid var(--mark-color);
}

/* Arco (semicirculo) */
.arc {
  width: 56px;
  height: 28px;
  border-radius: 56px 56px 0 0;
  border: 3px solid var(--mark-color);
  border-bottom: none;
}
```

### Posicionamento Preciso

```css
.mark {
  position: relative;
  width: 56px;
  height: 56px;
}

.mark .dot {
  position: absolute;
  /* Posicao calculada geometricamente */
  top: 3px;
  right: 5px;
}
```

### Quando CSS nao basta

Para formas complexas (paths curvos nao-circulares), use SVG inline DENTRO do HTML:

```html
<div class="mark">
  <svg viewBox="0 0 80 80" class="mark-svg">
    <path d="M60 25 A25 25 0 1 0 60 55 L50 40 Z" fill="var(--mark-color)"/>
  </svg>
</div>
```

Isso combina o melhor dos dois mundos: SVG para geometria complexa, CSS para todo o resto.

---

## Sistema de Temas com CSS Variables

```css
/* Base */
.logo {
  display: inline-flex;
  align-items: center;
  gap: 20px;
  padding: 24px 40px;
  border-radius: 12px;
  font-family: 'Inter', sans-serif;
}

/* Dark (principal) */
.logo--dark {
  --mark-color: #D97706;
  --text-muted: #6B6B80;
  --text-accent: #D97706;
  background: #0F0F1A;
}

/* Light */
.logo--light {
  --mark-color: #92400E;
  --text-muted: #71717A;
  --text-accent: #92400E;
  background: #FAFAFE;
}

/* Mono */
.logo--mono {
  --mark-color: #1A1A2E;
  --text-muted: #1A1A2E;
  --text-accent: #1A1A2E;
  background: #FFFFFF;
}

/* Auto (segue o sistema) */
@media (prefers-color-scheme: dark) {
  .logo--auto {
    --mark-color: #D97706;
    --text-muted: #6B6B80;
    --text-accent: #D97706;
    background: #0F0F1A;
  }
}

@media (prefers-color-scheme: light) {
  .logo--auto {
    --mark-color: #92400E;
    --text-muted: #71717A;
    --text-accent: #92400E;
    background: #FAFAFE;
  }
}
```

**Vantagem:** Todas as variacoes num unico arquivo. Zero duplicacao de codigo.

---

## Tipografia Profissional

### Google Fonts - Carregamento Otimizado

```html
<!-- preconnect ANTES do link da fonte -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!-- So os pesos necessarios -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;700&display=swap" rel="stylesheet">
```

### CSS Tipografico

```css
.wordmark {
  display: inline-flex;
  align-items: baseline;
  gap: 6px;
  font-size: 28px;
  line-height: 1;
  letter-spacing: -0.02em;
}

.wordmark .sleep {
  font-weight: 300;
  color: var(--text-muted);
}

.wordmark .agent {
  font-weight: 700;
  color: var(--text-accent);
}
```

### Fontes Recomendadas para Logos Tech

| Fonte | Peso | Uso | Exemplo |
|-------|------|-----|---------|
| Inter | 300/700 | Clean, moderna, universal | Sleep Agent |
| Space Grotesk | 400/700 | Tech com personalidade | Projetos dev |
| Outfit | 300/600 | Amigavel, geometrica | SaaS |
| Plus Jakarta Sans | 300/700 | Premium, equilibrada | Fintech |
| Sora | 300/700 | Futurista, tech-native | AI/ML |
| Manrope | 300/700 | Geometrica, profissional | Ferramentas |

---

## Animacoes Profissionais

### Regra: Sutileza

Animacao em logo deve ser **quase imperceptivel**. Se alguem nota "uau, animacao!", esta errado.

### Patterns Aprovados

```css
/* Pulse sutil no hover */
@keyframes orbit-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.6; }
}

.logo:hover .dot {
  animation: orbit-pulse 1.5s ease-in-out infinite;
}

/* Scale sutil no hover */
.logo {
  transition: transform 0.2s ease;
}

.logo:hover {
  transform: scale(1.02);
}
```

### Patterns PROIBIDOS

- Rotacao do mark (distrai)
- Bounce (infantil)
- Delay longo (frustra)
- Animacao ao carregar (arrogante)
- Qualquer animacao que dure mais de 2s

---

## Responsividade

```css
/* Mobile */
@media (max-width: 600px) {
  .logo {
    gap: 14px;
    padding: 16px 24px;
  }

  .mark {
    width: 40px;
    height: 40px;
  }

  .wordmark {
    font-size: 22px;
  }
}

/* Extra small - so icon */
@media (max-width: 360px) {
  .wordmark {
    display: none;
  }
}
```

---

## Icones em Multiplas Escalas

```css
.icon {
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 16px;
}

.icon--lg  { width: 96px; height: 96px; }
.icon--md  { width: 48px; height: 48px; border-radius: 10px; }
.icon--sm  { width: 32px; height: 32px; border-radius: 8px; }
.icon--xs  { width: 16px; height: 16px; border-radius: 4px; }

/* Mark se adapta ao container */
.icon .mark {
  width: 60%;
  height: 60%;
}
```

---

## Exportacao SVG

Apos aprovacao do HTML, exportar SVG limpo para contextos estaticos:

### Icon (favicon)

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80">
  <circle cx="40" cy="40" r="25" fill="none" stroke="#D97706" stroke-width="3"/>
  <circle cx="55" cy="20" r="5.5" fill="#D97706"/>
</svg>
```

### Regras da exportacao SVG

1. So o mark (sem texto) - texto SVG e inconsistente
2. ViewBox pequeno (80x80 ou 64x64)
3. Zero filters, zero gradientes
4. Sem `<?xml?>` declaration
5. Sem width/height fixos

---

## Checklist: Logo HTML Profissional

### Obrigatorio
- [ ] Google Font carregada com preconnect
- [ ] CSS Variables para temas
- [ ] Flexbox para alinhamento
- [ ] Min 4 variantes (dark, light, mono, mono-invertido)
- [ ] Responsivo (mobile + desktop)
- [ ] Icones em 4 escalas (96, 48, 32, 16)
- [ ] Hover state sutil
- [ ] Funciona sem JavaScript

### Proibido
- [ ] Nenhum `position: absolute` para layout geral (ok para mark interno)
- [ ] Nenhuma fonte do sistema como primaria
- [ ] Nenhuma animacao que dure mais de 2s
- [ ] Nenhum efeito que nao funcione sem hover
- [ ] Nenhuma dependencia JavaScript

---

## Fluxo de Trabalho: HTML-first

```
1. CONCEITO (Logo Architect)
   ↓ Briefing com metafora, cor, restricoes
2. HTML (Logo Craftsman)
   ↓ Construir mark + wordmark em HTML + CSS
   ↓ Google Font real, CSS variables, flexbox
   ↓ Todas variantes num unico arquivo
3. VALIDACAO (Logo Critic)
   ↓ Abrir no browser, testar escalas
   ↓ Testar dark/light, responsivo
   ↓ Validar tipografia real
4. SVG EXPORT (Logo Craftsman)
   ↓ Exportar mark limpo para favicon
   ↓ Zero texto no SVG (so mark geometrico)
5. ENTREGA
   ├── logo.html (arquivo principal)
   ├── logo-icon.svg (favicon/export)
   └── BRIEFING-LOGO.md
```
