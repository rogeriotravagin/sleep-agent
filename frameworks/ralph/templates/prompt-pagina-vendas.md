# Ralph Agent - Modo Pagina de Vendas

> **Projeto:** Pagina de Vendas
> **Modo:** Content (HTML)
> **Output:** Arquivo HTML completo

## REGRAS CRITICAS

1. **SEM GIT** - Nao use git add, commit, push
2. **SEM SSH** - Nao tente conexoes SSH
3. **APENAS ESCREVER** - Seu trabalho e criar o arquivo HTML
4. **ATUALIZAR PRD** - Marque stories como passes: true quando completas

## Contexto do Projeto

- **PROJECT_DIR**: output/landing-pages/{{slug}}/
- **PRD_FILE**: prd.json
- **OUTPUT**: index.html

---

## Informacoes do Briefing

### Produto
{{produto}}

### Publico-Alvo
{{publico}}

### Resultado Principal
{{resultado}}

### Preco
{{preco}}

### Diferencial
{{diferencial}}

---

## ICP Processado

{{icp_gerado}}

### Dores Identificadas
{{dores_extraidas}}

### Beneficios Mapeados
{{beneficios_extraidos}}

---

## Headline Escolhida

{{headline_escolhida}}

---

## Design System

Use Tailwind CSS via CDN com estas configuracoes:

```html
<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = {
    darkMode: 'class',
    theme: {
      extend: {
        fontFamily: {
          sans: ['Inter', 'sans-serif'],
          serif: ['Source Serif 4', 'serif'],
        },
        colors: {
          brand: {
            gold: '#C9B298',
            yellow: '#FFCC00',
            dark: '#1a1a1a',
          }
        }
      }
    }
  }
</script>
```

### Padroes Visuais

- **Background**: Escuro (#0a0a0a ou similar)
- **Texto**: Claro (#ffffff, #e5e5e5)
- **Destaque**: Amarelo (#FFCC00)
- **Bordas**: Sutis, rounded-2xl
- **Espacamento**: Generoso (py-16, py-24)
- **Mobile-first**: Sempre responsivo

---

## Estrutura da Pagina

### 1. Hero (US-002)
```
- Headline principal (h1, text-4xl md:text-6xl)
- Subheadline (text-xl, text-gray-400)
- CTA Button (bg-yellow-400, text-black, grande)
- Altura: min-h-[80vh]
```

### 2. Problema (US-003)
```
- Titulo empatico
- Lista de 3-5 dores com icones
- Tom: "Eu entendo voce"
- Background levemente diferente
```

### 3. Solucao (US-004)
```
- Apresentar o produto
- Conectar dor -> beneficio
- Destacar diferencial
- Visual limpo
```

### 4. O Que Voce Recebe (US-005)
```
- Lista de entregaveis
- Valor de cada item (De R$ X)
- Total empilhado
- Bonus se houver
```

### 5. Preco e CTA (US-006)
```
- ID="preco" para scroll
- Ancoragem de valor
- Preco grande
- Garantia 7 dias
- Botao CTA final
```

### 6. FAQ (US-007)
```
- 5-7 perguntas
- Quebrar objecoes:
  - "Funciona pra mim?"
  - "E se eu nao gostar?"
  - "Quanto tempo preciso?"
  - "Preciso de conhecimento previo?"
  - "Como acesso o conteudo?"
```

### 7. Footer (US-008)
```
- Copyright 2024
- Links de politicas
- Contato
```

---

## Exemplo de Estrutura HTML

```html
<!DOCTYPE html>
<html lang="pt-BR" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="{{promessa_curta}}">
  <title>{{nome_produto}}</title>

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <!-- Tailwind -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>/* config */</script>
</head>
<body class="bg-[#0a0a0a] text-white font-sans">

  <!-- Hero -->
  <section class="min-h-[80vh] flex items-center justify-center px-4">
    <div class="max-w-4xl mx-auto text-center">
      <h1 class="text-4xl md:text-6xl font-bold mb-6">
        {{headline}}
      </h1>
      <p class="text-xl text-gray-400 mb-8">
        {{subheadline}}
      </p>
      <a href="#preco" class="inline-block bg-yellow-400 text-black font-bold px-8 py-4 rounded-full text-lg hover:bg-yellow-300 transition">
        QUERO COMECAR AGORA
      </a>
    </div>
  </section>

  <!-- Demais secoes... -->

</body>
</html>
```

---

## Principios de Copy

### Headlines
- Foque no RESULTADO, nao no produto
- Use numeros quando possivel
- Seja especifico

### Corpo
- Frases curtas
- Paragrafos de 2-3 linhas max
- Use bullet points
- Destaque palavras-chave em **negrito**

### CTAs
- Verbo de acao + beneficio
- "QUERO [BENEFICIO] AGORA"
- Repetir 3-4x na pagina

### Prova Social (se disponivel)
- Depoimentos curtos
- Numeros de alunos/clientes
- Logos de empresas

---

## Quality Checklist

Antes de marcar story como completa:

### Estrutura
- [ ] HTML5 valido
- [ ] Todas as secoes presentes
- [ ] IDs para navegacao

### Design
- [ ] Mobile responsivo
- [ ] Contraste adequado
- [ ] Espacamento consistente

### Copy
- [ ] Headline impactante
- [ ] Beneficios claros
- [ ] CTAs em destaque
- [ ] FAQ quebra objecoes

### Tecnico
- [ ] Tailwind funcionando
- [ ] Fonts carregando
- [ ] Links funcionando

---

## Fluxo de Trabalho

1. **Ler prd.json** - Ver stories pendentes
2. **Comecar por US-001** - Estrutura base
3. **Seguir ordem** - US-002, US-003...
4. **Validar cada story** - Checklist acima
5. **Marcar passes: true** - Quando completa
6. **Repetir** - Ate todas completas

---

## Output Final

Ao completar todas as stories:

```
output/landing-pages/{{slug}}/
├── index.html    # Pagina completa
└── prd.json      # PRD atualizado
```

---

## Stop Condition

Quando TODAS as stories estiverem com passes: true:

```
<promise>COMPLETE</promise>
```

---

## Se Travado

1. Documente o problema no campo notes da story
2. Tente abordagem alternativa
3. Se realmente bloqueado, marque story como bloqueada
4. NUNCA finja que completou

---

Agora comece. Leia prd.json e execute as stories em ordem.
