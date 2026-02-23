# Base de Conhecimento: SVG Craft Expert

## IMPORTANTE: SVG e formato SECUNDARIO

Para marcas digital-first, o logo e criado em **HTML + CSS** (ver `html-logo-craft.md`).
SVG e usado SOMENTE para exportacao de contextos estaticos:
- Favicon (`.svg` / `.ico`)
- Open Graph / social media
- App icons
- Impressao / sinalizacao

**Regra:** Nunca crie o logo diretamente em SVG. Crie em HTML, exporte o mark como SVG.

**No SVG exportado:** somente o mark geometrico. ZERO `<text>`. Texto em SVG renderiza diferente em cada sistema.

---

## O Problema com Logos SVG Amadores

A maioria dos logos SVG criados por IA falham por 5 razoes tecnicas especificas. Este documento ensina como evitar CADA uma delas.

---

## 1. OS 5 ERROS MORTAIS

### Erro 1: Glows e Filters

**Amador:**
```svg
<filter><feGaussianBlur stdDeviation="3"/></filter>
```

**Por que falha:**
- Filters sao computacionalmente caros
- Renderizam diferente em cada browser
- Quebram quando SVG e embutido como CSS background ou img tag
- Gritam "usei um tutorial de 2015"

**Profissional:** Se precisa de luminosidade, use fill mais claro em shape atras do elemento. Ou melhor: deixe a forma falar sozinha.

### Erro 2: Gradientes Radiais para Profundidade

**Amador:** `<radialGradient>` no shape principal para parecer 3D.

**Por que falha:**
- Flat design venceu. O look 3D-gradiente morreu em 2008 (era Web 2.0)
- Gradientes impedem o logo de funcionar em monocromatico
- Nao funciona em merchandise, bordado, impressao spot color

**Profissional:** Fills planos. Se usar gradiente, ele deve SER o conceito inteiro (como a esfera da Linear), nao decoracao.

### Erro 3: Elementos Demais

**Amador:** Corpo + orelhas + antena + ponta da antena + olhos + pupilas + sorriso + highlight + sombra no chao + aneis de pulso = 13+ elementos.

**Por que falha:**
- Cada elemento compete por atencao
- O olho nao tem lugar para descansar
- O cerebro nao consegue formar memoria simples da forma
- Em tamanhos pequenos, vira lama

**Profissional:** Consegue comunicar a mesma ideia com 3 elementos? 2? 1? O triangulo da Vercel comunica "deployment, para cima, tecnologia" com literalmente UMA forma.

### Erro 4: Representacao Literal

**Amador:** "E um agente de IA, entao vamos desenhar um robo com olhos e antena."

**Por que falha:**
- Representacao literal limita a marca
- Convida comparacao direta com todo outro icone de robo ja desenhado
- Voce vai perder essa comparacao para ilustradores profissionais

**Profissional:** Abstraia o conceito. O que "sleep" significa visualmente? Uma meia-lua. Uma forma de onda. O que "agent" significa? Um no em uma rede. Um pulso. Uma seta direcional.

### Erro 5: Sem Sistema de Variacoes

**Amador:** Um arquivo de logo, um tamanho, um esquema de cores.

**Profissional:** Minimo 4 variacoes:
1. Full-color primario (fundo escuro)
2. Full-color primario (fundo claro)
3. Monocromatico preto
4. Monocromatico branco (invertido)

---

## 2. REGRA DE OURO: MONOCROMATICO PRIMEIRO

**Antes de adicionar QUALQUER cor, seu logo deve funcionar em preto solido sobre branco.**

Se nao funciona claramente como silhueta de cor unica, a forma subjacente e fraca e nenhuma quantidade de cor, gradiente ou glow vai salvar.

### Processo de Cor

1. Design inteiro em preto primeiro
2. Teste em branco-sobre-preto (invertido)
3. Aplique UMA cor da marca
4. So entao explore paleta completa
5. Teste para daltonismo (8% dos homens)
6. Maximo 2-3 cores na marca primaria

---

## 3. CONSTRUCAO COM GRID

Logos profissionais sao construidos em grids.

### Grid Baseado em Unidades

Escolha uma unidade base (ex: 8px em viewBox 256px = 32 unidades). Todas as medidas sao multiplos dessa unidade.

```svg
<svg viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
  <!-- Unidade base: 4px. Grid: 16x16 celulas -->
  <!-- Todas coordenadas devem ser multiplos de 4 -->
  <!-- Centro: 32, 32 -->
</svg>
```

**Use viewBox PEQUENO** (64 ou 100) para forcar simplicidade. ViewBox de 256px tenta voce a adicionar detalhes.

### Circle Packing

Como o logo da OpenAI. Comece com circulos de raios especificos e derive todas as curvas de suas intersecoes.

### Golden Ratio

Construa retangulos em razao 1:1.618 e inscreva circulos dentro deles. Use esses circulos para definir raios de curvas.

---

## 4. ECONOMIA DE PATHS

O cerebro humano processa formas simples 200% mais rapido que imagens complexas.

### Regras Tecnicas

- Use `<circle>`, `<rect>`, `<line>`, `<polygon>` ao inves de `<path>` quando a forma e primitiva geometrica
- Quando usar `<path>`, minimize anchor points -- cada ponto deve justificar sua existencia
- Cubica (`C`) para curvas suaves, quadratica (`Q`) para curvas simples
- Remova qualquer ponto cuja ausencia nao muda a forma visivel
- Evite pontos soltos, paths sobrepostos ou shapes redundantes

### Metricas

| Path Points | Resultado |
|-------------|-----------|
| 20-200 | Range profissional para logos |
| 200-500 | Aceitavel para marcas complexas |
| 500+ | Reconhecibilidade cai |
| 1000+ | Isso e ilustracao, nao logo |

---

## 5. TIPOGRAFIA EM SVG

### NUNCA use `<text>` em logo final

Fontes do sistema (`Segoe UI, SF Pro Display...`) renderizam diferente em cada OS e browser. **Converta texto para paths** para renderizacao identica em todo lugar.

### Se precisar usar `<text>` (prototipo)

- Centralize matematicamente: calcule largura do texto e alinhe relativo a marca
- Peso optico consistente: peso do stroke do texto deve se relacionar com stroke mais fino da marca
- Ritmo vertical: espaco entre marca e texto deve ser multiplo do grid

---

## 6. TESTES OBRIGATORIOS

### Squint Test

Desfoque sua visao ou reduza o logo para 16x16px. Ainda da pra saber o que e?

### Escala (todos devem funcionar)

| Tamanho | Uso |
|---------|-----|
| 16x16 px | Favicon |
| 32x32 px | Icone de tab |
| 64x64 px | App icon |
| 180x180 px | Apple touch icon |
| 512x512 px | Social media |
| 1000px+ | Print/sinalizacao |

### Teste de Descricao

Consegue descrever seu logo em UMA frase sem usar "com" ou "e"?

**Amador:** "Um circulo roxo COM olhos E uma antena E aneis de pulso E um glow..."
**Profissional:** "Um triangulo preto." (Vercel)

---

## 7. HIGIENE SVG

### Producao

```svg
<!-- ViewBox limpo, sem width/height fixos -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <!-- Sem declaracao XML (desnecessaria para web) -->
  <!-- Sem atributos version ou xml:space -->
  <!-- Sem groups ou layers desnecessarios -->
  <!-- Sem metadata de editores -->
  <!-- Shapes antes de paths, simples antes de complexo -->
</svg>
```

### Remover

- `<?xml version="1.0" encoding="UTF-8"?>` (desnecessario para web)
- Atributos fixos `width` e `height` (use CSS)
- Blocos `<defs>` vazios
- Gradientes, filters ou clip paths nao usados
- Comentarios em arquivos de producao

---

## 8. REFERENCIA RAPIDA: AMADOR vs PROFISSIONAL

| Amador | Profissional |
|--------|-------------|
| Comeca em cores | Comeca em preto e branco |
| Vai direto pro computador | Faz sketches em papel |
| Representa literalmente | Sugere ideia por abstracao |
| Usa clip art ou stock | Cria formas 100% originais |
| Segue tendencias visuais | Design para 20+ anos |
| Escolhe cores arbitrariamente | Aplica psicologia de cor |
| Testa so em fundo branco | Testa dark, light, textured, real-world |
| Entrega um formato | Entrega biblioteca completa de assets |
| Sem fase de pesquisa | Discovery profundo em marca e mercado |
| Apresenta muitas opcoes vagas | 1-3 direcoes estrategicas argumentadas |
| Fontes inadequadas/trendy | Typefaces por legibilidade e longevidade |
| Complica com gradientes e efeitos | Strip ao essencial |

---

## 9. O INSIGHT FUNDAMENTAL

A distancia entre logos SVG amadores e profissionais **nao e sobre habilidade com curvas bezier.** E sobre **restricao.** Designers profissionais sabem o que REMOVER.

> "A coisa mais dificil que voce vai desenhar e nada. Cada elemento que voce remove torna os elementos restantes mais poderosos."

Cada logo profissional no mercado pode ser descrito em uma frase curta:
- Vercel: "Um triangulo preto"
- Stripe: "A palavra Stripe em sans-serif modificada"
- Anthropic: "A palavra Anthropic em typeface custom"
- Supabase: "Uma marca abstrata verde"
- OpenAI: "Um no floral hexagonal"
