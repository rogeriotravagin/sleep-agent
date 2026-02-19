# Base de Conhecimento: UI/UX Design

## Visao Geral

Este documento compila os principios fundamentais, heuristicas e melhores praticas de UI/UX Design baseado nos maiores especialistas mundiais.

---

## 1. MESTRES DE UX

### Don Norman

**Obra Principal:** The Design of Everyday Things (1988)

**Conceito Central:**
> "User experience encompasses all aspects of the end-user's interaction with the company, its services, and its products"

**Principios Fundamentais:**

1. **Affordances**
   - Possibilidades de acao que um objeto oferece
   - Botao parece clicavel
   - Macaneta convida a puxar

2. **Signifiers**
   - Sinais que indicam affordances
   - Seta indicando direcao
   - Texto "clique aqui"

3. **Mapping**
   - Relacao entre controles e resultados
   - Botao a esquerda controla elemento a esquerda
   - Natural mapping = intuitivo

4. **Feedback**
   - Sistema comunica resultado de acao
   - Botao muda ao clicar
   - Loading indica processo

5. **Constraints**
   - Limitacoes que guiam uso correto
   - Campo aceita apenas numeros
   - Botao desabilitado ate preencher form

**Tipos de Erro (Norman):**
- **Slips:** Erros de execucao (digitou errado)
- **Mistakes:** Erros de intencao (nao entendeu)

---

### Steve Krug

**Obra Principal:** Don't Make Me Think (2000)

**Principio Central:**
> "Don't make me think" - Interface deve ser auto-evidente

**Leis de Krug:**

1. **Lei #1: Nao me faca pensar**
   - Obvio > Cleverness
   - Auto-explicativo
   - Sem ambiguidade

2. **Lei #2: Cliques sao OK se sao mindless**
   - Numero de cliques < Dificuldade
   - 3 cliques faceis > 1 click dificil

3. **Lei #3: Elimine metade das palavras**
   - Menos texto = mais lido
   - Seja conciso
   - Escaneabilidade

**Testes de Usabilidade:**
- Testes de guerrilha
- 5 usuarios = maioria dos problemas
- Testar cedo e frequentemente

---

### Jakob Nielsen

**10 Heuristicas de Usabilidade (1994, atualizado 2020):**

#### 1. Visibilidade do Status do Sistema
- Sempre informar o que esta acontecendo
- Feedback em tempo adequado
- Exemplos: Loading spinners, progress bars

#### 2. Correspondencia Sistema-Mundo Real
- Usar linguagem do usuario
- Convencoes do mundo real
- Informacoes em ordem logica

#### 3. Controle e Liberdade do Usuario
- "Saida de emergencia" clara
- Undo e redo
- Nao prender usuario

#### 4. Consistencia e Padroes
- Mesmas palavras = mesmas acoes
- Seguir convencoes da plataforma
- Consistencia interna e externa

#### 5. Prevencao de Erros
- Eliminar condicoes de erro
- Confirmacao antes de acoes criticas
- Constraints e defaults inteligentes

#### 6. Reconhecimento > Memoria
- Tornar opcoes visiveis
- Nao exigir memorizacao
- Instrucoes acessiveis

#### 7. Flexibilidade e Eficiencia
- Aceleradores para experts
- Permitir customizacao
- Atalhos de teclado

#### 8. Design Estetico e Minimalista
- Sem informacao irrelevante
- Cada elemento deve ter proposito
- Menos = mais

#### 9. Ajudar Usuarios com Erros
- Mensagens de erro em linguagem clara
- Indicar problema precisamente
- Sugerir solucao

#### 10. Ajuda e Documentacao
- Sistema deve funcionar sem manual
- Ajuda facil de encontrar
- Focada na tarefa do usuario

---

## 2. PRINCIPIOS DE UI

### Hierarquia Visual

**Elementos de Hierarquia:**

1. **Tamanho**
   - Maior = mais importante
   - Headlines > Body > Caption

2. **Cor**
   - Cores fortes = atencao
   - Contraste cria foco

3. **Espacamento**
   - Whitespace agrupa
   - Separacao indica diferenca

4. **Posicao**
   - Topo > Fundo
   - Esquerda > Direita (ocidental)

5. **Peso**
   - Bold = importante
   - Light = secundario

6. **Tipografia**
   - Serif vs Sans-serif
   - Tamanhos variados

---

### Padroes de Leitura

**F-Pattern:**
- Para conteudo denso em texto
- Usuarios escaneiam em F
- Coloque importante a esquerda e topo

**Z-Pattern:**
- Para paginas simples
- Leitura em Z
- Bom para landing pages

**Gutenberg Diagram:**
- Atencao primaria: top-left
- Atencao terminal: bottom-right
- Falhas: top-right, bottom-left

---

### Grid System

**12 Colunas:**
- Padrao da industria
- Divisivel por 1, 2, 3, 4, 6, 12
- Flexibilidade maxima

**Elementos:**
- **Columns:** Areas de conteudo
- **Gutters:** Espacos entre colunas
- **Margins:** Bordas externas

**8px Grid:**
- Base de espacamento
- Multiplos: 8, 16, 24, 32, 48, 64
- Consistencia visual

---

### Espacamento

**Sistema de 8px:**
```
4px  - Micro (entre icone e texto)
8px  - Pequeno (padding interno)
16px - Medio (entre elementos)
24px - Grande (entre grupos)
32px - Extra (entre secoes)
48px - Section padding
64px - Section margins
```

**Regras:**
- Elementos relacionados = mais perto
- Elementos diferentes = mais longe
- Whitespace nao e desperdicio

---

### Tipografia

**Hierarquia:**
```
Display  - 60-72px - Heroes
H1       - 36-48px - Titulos de pagina
H2       - 28-36px - Secoes
H3       - 22-28px - Subsecoes
Body     - 16-18px - Texto corrido
Small    - 14px    - Secundario
Caption  - 12px    - Legendas
```

**Line Height:**
- Headlines: 1.2-1.3
- Body text: 1.5-1.7
- Espacamento entre linhas

**Line Length:**
- Ideal: 50-75 caracteres
- Muito longo = cansativo
- Muito curto = quebrado

---

## 3. DESIGN THINKING

### Framework IDEO

**5 Fases:**

1. **Empathize**
   - Entender o usuario
   - Pesquisa de campo
   - Entrevistas

2. **Define**
   - Definir o problema
   - Point of View
   - "How might we..."

3. **Ideate**
   - Brainstorming
   - Sem julgamento
   - Quantidade > Qualidade

4. **Prototype**
   - Criar versao rapida
   - Baixa fidelidade OK
   - Testar conceito

5. **Test**
   - Validar com usuarios
   - Aprender e iterar
   - Falhar rapido

---

### Double Diamond

**Discover → Define → Develop → Deliver**

```
    Discover        Define         Develop        Deliver
      ◢◣             ◥◤              ◢◣             ◥◤
     ◢  ◣           ◥  ◤            ◢  ◣           ◥  ◤
    ◢    ◣         ◥    ◤          ◢    ◣         ◥    ◤
   Diverge      Converge         Diverge       Converge
```

**Fase 1: Discover (Diverge)**
- Explorar problema
- Pesquisa ampla

**Fase 2: Define (Converge)**
- Focar no problema certo
- Design brief

**Fase 3: Develop (Diverge)**
- Explorar solucoes
- Ideacao ampla

**Fase 4: Deliver (Converge)**
- Refinar solucao
- Entregar produto

---

### Atomic Design (Brad Frost)

**5 Niveis:**

1. **Atoms**
   - Elementos basicos
   - Botoes, inputs, labels
   - Indivsibilei

2. **Molecules**
   - Combinacoes simples
   - Search box (input + button)
   - Form field (label + input)

3. **Organisms**
   - Secoes completas
   - Header, footer
   - Card grid

4. **Templates**
   - Layouts de pagina
   - Estrutura sem conteudo

5. **Pages**
   - Instancias finais
   - Conteudo real

---

## 4. ACESSIBILIDADE

### WCAG 2.1

**Niveis:**
- **A:** Minimo
- **AA:** Recomendado
- **AAA:** Otimo

**4 Principios (POUR):**

1. **Perceivable**
   - Conteudo percebivel
   - Alt text, legendas
   - Contraste adequado

2. **Operable**
   - Navegavel por teclado
   - Tempo suficiente
   - Sem seizure triggers

3. **Understandable**
   - Legivel e compreensivel
   - Previsivel
   - Ajuda com erros

4. **Robust**
   - Compativel com assistive tech
   - Codigo valido
   - Futureproof

### Contraste

**Requisitos:**
- Texto normal: 4.5:1 (AA)
- Texto grande: 3:1 (AA)
- Graficos: 3:1 (AA)

**Ferramentas:**
- WebAIM Contrast Checker
- Colorable
- Stark

### Checklist Basico

- [ ] Contraste adequado
- [ ] Navegacao por teclado
- [ ] Focus states visiveis
- [ ] Alt text em imagens
- [ ] Labels em inputs
- [ ] Mensagens de erro claras
- [ ] Touch targets 44x44px minimo

---

## 5. DESIGN SYSTEMS

### Beneficios

1. **Consistencia**
   - Mesma experiencia
   - Mesmos padroes

2. **Eficiencia**
   - Reutilizacao
   - Velocidade de desenvolvimento

3. **Escalabilidade**
   - Cresce com o produto
   - Facil manutencao

4. **Colaboracao**
   - Linguagem comum
   - Designers + Devs alinhados

### Componentes

**Design Tokens:**
- Cores
- Tipografia
- Espacamento
- Shadows
- Border radius

**Componentes:**
- Buttons
- Inputs
- Cards
- Navigation
- Modals

**Patterns:**
- Form patterns
- Navigation patterns
- Data display

### Referencias

**Material Design (Google)**
- Sistema mais documentado
- Components para todas plataformas
- Design tokens extensivos

**Human Interface Guidelines (Apple)**
- iOS, macOS, watchOS
- Foco em experiencia nativa
- Padroes de interacao

**Fluent Design (Microsoft)**
- Windows, Office
- Light, depth, motion
- Cross-platform

---

## 6. METRICAS UX

### Quantitativas

- **Task Success Rate:** % completou tarefa
- **Time on Task:** Tempo para completar
- **Error Rate:** % de erros
- **Conversion Rate:** % converteu

### Qualitativas

- **SUS (System Usability Scale):** Questionario padrao
- **NPS (Net Promoter Score):** Recomendaria?
- **CSAT:** Satisfacao geral

### Comportamentais

- **Click-through Rate:** % clicou
- **Bounce Rate:** % saiu rapido
- **Pages per Session:** Engajamento
- **Scroll Depth:** Quanto scrollou

---

## 7. RECURSOS

### Livros
- Don't Make Me Think - Steve Krug
- The Design of Everyday Things - Don Norman
- About Face - Alan Cooper
- Lean UX - Jeff Gothelf

### Sites
- Nielsen Norman Group (nngroup.com)
- Smashing Magazine
- UX Collective
- A List Apart

### Ferramentas
- Figma
- Sketch
- Adobe XD
- Framer
- Principle
