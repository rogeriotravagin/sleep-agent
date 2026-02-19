# Base de Conhecimento: Design Systems

## Visao Geral

Este documento compila os melhores frameworks, padroes e praticas para criacao e manutencao de design systems.

---

## 1. O QUE E DESIGN SYSTEM

### Definicao

> Um design system e uma colecao de componentes reutilizaveis, guiados por padroes claros, que podem ser montados para construir qualquer numero de aplicacoes.

**Componentes:**
1. **Design Tokens** - Valores atomicos (cores, espacamento)
2. **Componentes** - Elementos de UI reutilizaveis
3. **Patterns** - Combinacoes de componentes
4. **Guidelines** - Regras de uso
5. **Documentacao** - Como usar tudo

### Por que ter um Design System

**Beneficios:**

1. **Consistencia**
   - Mesma experiencia em todos os produtos
   - Marca coesa

2. **Eficiencia**
   - Desenvolvimento mais rapido
   - Menos decisoes repetidas

3. **Escalabilidade**
   - Cresce com a empresa
   - Facil manutencao

4. **Colaboracao**
   - Linguagem comum
   - Designers + Devs alinhados

5. **Qualidade**
   - Componentes testados
   - Acessibilidade built-in

---

## 2. DESIGN SYSTEMS DE REFERENCIA

### Material Design (Google)

**Caracteristicas:**
- Sistema mais documentado
- Baseado em "material" fisico
- Depth, motion, interaction
- Cross-platform

**Componentes:**
- 50+ componentes
- Design tokens extensivos
- Temas customizaveis

**Principios:**
1. Material is the metaphor
2. Bold, graphic, intentional
3. Motion provides meaning

---

### Human Interface Guidelines (Apple)

**Caracteristicas:**
- iOS, macOS, watchOS, tvOS
- Foco em experiencia nativa
- Padroes de interacao refinados

**Principios:**
1. Clarity (clareza)
2. Deference (conteudo primeiro)
3. Depth (hierarquia visual)

**Foco:**
- Gestos nativos
- Animacoes fluidas
- Padronizacao de plataforma

---

### Fluent Design (Microsoft)

**Caracteristicas:**
- Windows, Office, Web
- Light, depth, motion, material, scale

**5 Elementos:**
1. **Light** - Iluminacao guia atencao
2. **Depth** - Profundidade e camadas
3. **Motion** - Animacoes significativas
4. **Material** - Texturas e efeitos
5. **Scale** - Adaptacao a dispositivos

---

### Outros Referencias

**Carbon (IBM)**
- Enterprise-focused
- Acessibilidade forte
- React, Vue, Angular

**Polaris (Shopify)**
- E-commerce focused
- Componentes especializados
- Guidelines de conteudo

**Atlassian Design System**
- Produtos de produtividade
- Design tokens robustos
- Documentacao excelente

---

## 3. ATOMIC DESIGN

### Framework de Brad Frost

**5 Niveis:**

```
     Pages
       ↑
   Templates
       ↑
   Organisms
       ↑
   Molecules
       ↑
     Atoms
```

### Atoms (Atomos)

**Definicao:** Elementos basicos, indivisiveis

**Exemplos:**
- Botoes
- Inputs
- Labels
- Icones
- Cores
- Tipografia

**Caracteristicas:**
- Nao podem ser quebrados mais
- Blocos de construcao
- Abstratos sozinhos

---

### Molecules (Moleculas)

**Definicao:** Combinacoes simples de atomos

**Exemplos:**
- Form field (label + input + helper)
- Search box (input + button)
- Card simples (imagem + titulo)
- List item (icone + texto)

**Caracteristicas:**
- Comecam a ter proposito
- Combinacoes funcionais
- Reutilizaveis

---

### Organisms (Organismos)

**Definicao:** Secoes completas da interface

**Exemplos:**
- Header/Navbar
- Footer
- Card grid
- Form completo
- Hero section

**Caracteristicas:**
- Secoes da pagina
- Combinam moleculas
- Contexto de uso

---

### Templates

**Definicao:** Layouts de pagina sem conteudo

**Exemplos:**
- Layout de blog
- Layout de produto
- Layout de dashboard

**Caracteristicas:**
- Estrutura da pagina
- Placeholder para conteudo
- Wireframe visual

---

### Pages

**Definicao:** Instancias finais com conteudo real

**Exemplos:**
- Homepage real
- Pagina de produto real
- Artigo de blog real

**Caracteristicas:**
- Conteudo final
- Variantes de uso
- Teste de sistema

---

## 4. DESIGN TOKENS

### O que sao

> Valores atomicos que representam decisoes de design

**Tipos:**

| Tipo | Exemplo |
|------|---------|
| **Cores** | primary: #3B82F6 |
| **Tipografia** | font-family: Inter |
| **Espacamento** | spacing-4: 16px |
| **Border radius** | radius-md: 8px |
| **Shadows** | shadow-lg: 0 10px 15px... |
| **Breakpoints** | screen-md: 768px |

### Estrutura de Tokens

**3 Niveis:**

1. **Global tokens** - Valores brutos
```css
--blue-500: #3B82F6;
--gray-100: #F3F4F6;
```

2. **Alias tokens** - Semantica
```css
--color-primary: var(--blue-500);
--color-background: var(--gray-100);
```

3. **Component tokens** - Especificos
```css
--button-bg: var(--color-primary);
--card-bg: var(--color-background);
```

### Exemplo Completo

```css
:root {
  /* ===== CORES ===== */

  /* Primarias */
  --color-primary: #3B82F6;
  --color-primary-light: #60A5FA;
  --color-primary-dark: #2563EB;

  /* Secundarias */
  --color-secondary: #8B5CF6;
  --color-accent: #F59E0B;

  /* Neutras */
  --color-gray-900: #111827;
  --color-gray-800: #1F2937;
  --color-gray-700: #374151;
  --color-gray-600: #4B5563;
  --color-gray-500: #6B7280;
  --color-gray-400: #9CA3AF;
  --color-gray-300: #D1D5DB;
  --color-gray-200: #E5E7EB;
  --color-gray-100: #F3F4F6;
  --color-gray-50: #F9FAFB;
  --color-white: #FFFFFF;

  /* Semanticas */
  --color-success: #10B981;
  --color-warning: #F59E0B;
  --color-error: #EF4444;
  --color-info: #3B82F6;

  /* ===== TIPOGRAFIA ===== */

  /* Familias */
  --font-family-sans: 'Inter', -apple-system, sans-serif;
  --font-family-serif: 'Georgia', serif;
  --font-family-mono: 'JetBrains Mono', monospace;

  /* Tamanhos */
  --font-size-xs: 0.75rem;   /* 12px */
  --font-size-sm: 0.875rem;  /* 14px */
  --font-size-base: 1rem;    /* 16px */
  --font-size-lg: 1.125rem;  /* 18px */
  --font-size-xl: 1.25rem;   /* 20px */
  --font-size-2xl: 1.5rem;   /* 24px */
  --font-size-3xl: 1.875rem; /* 30px */
  --font-size-4xl: 2.25rem;  /* 36px */
  --font-size-5xl: 3rem;     /* 48px */

  /* Pesos */
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;

  /* Line Heights */
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;

  /* ===== ESPACAMENTO ===== */

  --spacing-0: 0;
  --spacing-1: 0.25rem;  /* 4px */
  --spacing-2: 0.5rem;   /* 8px */
  --spacing-3: 0.75rem;  /* 12px */
  --spacing-4: 1rem;     /* 16px */
  --spacing-5: 1.25rem;  /* 20px */
  --spacing-6: 1.5rem;   /* 24px */
  --spacing-8: 2rem;     /* 32px */
  --spacing-10: 2.5rem;  /* 40px */
  --spacing-12: 3rem;    /* 48px */
  --spacing-16: 4rem;    /* 64px */
  --spacing-20: 5rem;    /* 80px */
  --spacing-24: 6rem;    /* 96px */

  /* ===== BORDAS ===== */

  --radius-none: 0;
  --radius-sm: 0.25rem;   /* 4px */
  --radius-md: 0.5rem;    /* 8px */
  --radius-lg: 0.75rem;   /* 12px */
  --radius-xl: 1rem;      /* 16px */
  --radius-2xl: 1.5rem;   /* 24px */
  --radius-full: 9999px;

  /* ===== SOMBRAS ===== */

  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);

  /* ===== BREAKPOINTS ===== */

  --screen-sm: 640px;
  --screen-md: 768px;
  --screen-lg: 1024px;
  --screen-xl: 1280px;
  --screen-2xl: 1536px;

  /* ===== TRANSICOES ===== */

  --transition-fast: 150ms;
  --transition-normal: 300ms;
  --transition-slow: 500ms;
  --easing-default: cubic-bezier(0.4, 0, 0.2, 1);
}
```

---

## 5. COMPONENTES BASE

### Buttons

**Variantes:**
- Primary (acao principal)
- Secondary (acao secundaria)
- Ghost/Outline (terciaria)
- Danger (acoes destrutivas)

**Tamanhos:**
- Small (sm)
- Medium (md) - padrao
- Large (lg)

**Estados:**
- Default
- Hover
- Active/Pressed
- Focus
- Disabled
- Loading

**Especificacao:**
```css
.button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-weight: var(--font-weight-semibold);
  border-radius: var(--radius-md);
  transition: all var(--transition-fast) var(--easing-default);
}

.button-md {
  padding: var(--spacing-3) var(--spacing-6);
  font-size: var(--font-size-base);
}

.button-primary {
  background: var(--color-primary);
  color: var(--color-white);
}

.button-primary:hover {
  background: var(--color-primary-dark);
}

.button-primary:focus {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
}

.button-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
```

---

### Inputs

**Tipos:**
- Text
- Email
- Password
- Number
- Textarea
- Select

**Estados:**
- Default
- Focus
- Error
- Success
- Disabled

**Especificacao:**
```css
.input {
  width: 100%;
  padding: var(--spacing-3) var(--spacing-4);
  font-size: var(--font-size-base);
  border: 1px solid var(--color-gray-300);
  border-radius: var(--radius-md);
  transition: border-color var(--transition-fast);
}

.input:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.input-error {
  border-color: var(--color-error);
}

.input:disabled {
  background: var(--color-gray-100);
  cursor: not-allowed;
}
```

---

### Cards

**Estrutura:**
```
┌─────────────────────────────┐
│ [Header - opcional]         │
├─────────────────────────────┤
│ [Media - opcional]          │
├─────────────────────────────┤
│ [Body]                      │
│  - Titulo                   │
│  - Descricao                │
│  - Conteudo                 │
├─────────────────────────────┤
│ [Footer/Actions - opcional] │
└─────────────────────────────┘
```

**Especificacao:**
```css
.card {
  background: var(--color-white);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-md);
  overflow: hidden;
}

.card-body {
  padding: var(--spacing-6);
}

.card-title {
  font-size: var(--font-size-xl);
  font-weight: var(--font-weight-semibold);
  margin-bottom: var(--spacing-2);
}

.card-description {
  color: var(--color-gray-600);
  font-size: var(--font-size-base);
}
```

---

## 6. LAYOUT

### Grid System

**Container:**
```css
.container {
  width: 100%;
  max-width: var(--screen-xl);
  margin: 0 auto;
  padding: 0 var(--spacing-4);
}

@media (min-width: 768px) {
  .container {
    padding: 0 var(--spacing-8);
  }
}
```

**Grid:**
```css
.grid {
  display: grid;
  gap: var(--spacing-6);
}

.grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
.grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
.grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
.grid-cols-4 { grid-template-columns: repeat(4, 1fr); }

@media (max-width: 768px) {
  .md\:grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
}
```

---

## 7. DOCUMENTACAO

### Estrutura de Documentacao

```
docs/
├── getting-started/
│   ├── installation.md
│   ├── quick-start.md
│   └── principles.md
├── foundations/
│   ├── colors.md
│   ├── typography.md
│   ├── spacing.md
│   └── icons.md
├── components/
│   ├── buttons.md
│   ├── inputs.md
│   ├── cards.md
│   └── ...
├── patterns/
│   ├── forms.md
│   ├── navigation.md
│   └── ...
└── resources/
    ├── downloads.md
    └── changelog.md
```

### Template de Documentacao de Componente

```markdown
# Button

Buttons are used to trigger actions.

## Variants

### Primary
Use for main actions...

### Secondary
Use for secondary actions...

## Sizes

| Size | Padding | Font Size |
|------|---------|-----------|
| sm   | 8px 16px | 14px |
| md   | 12px 24px | 16px |
| lg   | 16px 32px | 18px |

## States

- Default
- Hover
- Active
- Focus
- Disabled
- Loading

## Usage

```jsx
<Button variant="primary" size="md">
  Click me
</Button>
```

## Do's and Don'ts

✅ Do: Use primary for main action
❌ Don't: Use multiple primary buttons

## Accessibility

- Use semantic button element
- Provide aria-label when needed
- Ensure focus is visible
```

---

## 8. FERRAMENTAS

### Design
- Figma
- Sketch
- Adobe XD

### Documentacao
- Storybook
- Zeroheight
- Notion

### Tokens
- Style Dictionary
- Theo
- Figma Tokens

### Codigo
- styled-components
- Tailwind CSS
- CSS Modules

---

## 9. CHECKLIST

### Fundacao
- [ ] Cores definidas (primarias, secundarias, neutras, semanticas)
- [ ] Tipografia definida (familias, tamanhos, pesos)
- [ ] Espacamento definido (escala de 8px)
- [ ] Border radius definidos
- [ ] Shadows definidos
- [ ] Breakpoints definidos

### Componentes Base
- [ ] Buttons (variantes, tamanhos, estados)
- [ ] Inputs (tipos, estados)
- [ ] Cards
- [ ] Typography (headings, body, links)
- [ ] Icons

### Documentacao
- [ ] Getting started
- [ ] Foundations docs
- [ ] Component docs
- [ ] Do's and Don'ts
- [ ] Accessibility guidelines

### Implementacao
- [ ] Design tokens exportados
- [ ] Componentes codificados
- [ ] Testes de componentes
- [ ] Storybook/docs ativos
