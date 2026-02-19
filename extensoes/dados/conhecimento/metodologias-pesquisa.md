# Metodologias de Pesquisa - Base de Conhecimento

## Tipos de Pesquisa

### Pesquisa Quantitativa
Focada em numeros e medicoes estatisticas.

**Caracteristicas:**
- Amostras grandes e representativas
- Resultados mensuraveis e comparaveis
- Analise estatistica
- Generalizacao possivel

**Metodos:**
- Surveys e questionarios
- Experimentos (A/B testing)
- Analise de dados transacionais
- Web analytics

### Pesquisa Qualitativa
Focada em entender o "por que" por tras dos comportamentos.

**Caracteristicas:**
- Amostras menores e profundas
- Exploratoria e interpretativa
- Insights ricos em contexto
- Geracao de hipoteses

**Metodos:**
- Entrevistas em profundidade
- Focus groups
- Etnografia
- Analise de conteudo

### Pesquisa Mista
Combina abordagens quantitativas e qualitativas.

**Quando usar:**
- Validar insights qualitativos com dados quantitativos
- Aprofundar resultados quantitativos com contexto qualitativo
- Triangular informacoes de multiplas fontes

---

## Frameworks de Pesquisa

### CRISP-DM (Cross-Industry Standard Process for Data Mining)

```
1. Business Understanding
   - Entender objetivos do negocio
   - Definir criterios de sucesso
   - Avaliar situacao atual

2. Data Understanding
   - Coletar dados iniciais
   - Descrever dados
   - Explorar dados
   - Verificar qualidade

3. Data Preparation
   - Selecionar dados
   - Limpar dados
   - Construir variaveis
   - Integrar dados
   - Formatar dados

4. Modeling
   - Selecionar tecnicas
   - Gerar desenho de teste
   - Construir modelo
   - Avaliar modelo

5. Evaluation
   - Avaliar resultados
   - Revisar processo
   - Determinar proximos passos

6. Deployment
   - Planejar implementacao
   - Monitorar e manter
   - Documentar
```

### Design Thinking para Pesquisa

```
EMPATIZAR    ->    DEFINIR    ->    IDEAR    ->    PROTOTIPAR    ->    TESTAR
   |                  |               |               |                |
Entender o      Sintetizar      Gerar           Criar            Validar
usuario         insights        solucoes        experimentos     hipoteses
```

### Jobs to be Done (JTBD)

Framework para entender motivacoes do consumidor:

| Elemento | Pergunta Chave |
|----------|----------------|
| **Job** | O que o cliente esta tentando realizar? |
| **Contexto** | Em que situacao ele esta? |
| **Resultado** | O que significa sucesso para ele? |
| **Barreiras** | O que impede de conseguir? |
| **Solucao Atual** | Como ele resolve hoje? |

**Template de Job Statement:**
```
Quando [situacao], eu quero [motivacao], para que [resultado esperado].
```

---

## Metodos de Coleta

### Pesquisa Primaria

**1. Surveys/Questionarios**
- Online (Typeform, Google Forms, SurveyMonkey)
- Por telefone (CATI)
- Presencial (interceptacao)

**Boas praticas:**
- Perguntas claras e objetivas
- Escala Likert para opiniao (1-5 ou 1-7)
- Evitar perguntas tendenciosas
- Testar antes de aplicar (piloto)

**2. Entrevistas em Profundidade**
- Duracao: 30-60 minutos
- Semi-estruturadas (roteiro flexivel)
- Foco em "por que" e "como"
- Gravar (com permissao)

**Tecnicas:**
- Laddering (aprofundar respostas)
- Projecao (cenarios hipoteticos)
- Storytelling (pedir exemplos concretos)

**3. Focus Groups**
- 6-10 participantes
- Duracao: 90-120 minutos
- Moderador experiente
- Bom para gerar ideias e explorar percepcoes

### Pesquisa Secundaria (Desk Research)

**Fontes:**
- Relatorios de mercado (Statista, IBISWorld)
- Dados governamentais (IBGE, Banco Central)
- Publicacoes academicas (Google Scholar)
- Noticias e artigos do setor
- Dados publicos de concorrentes
- Redes sociais e reviews

**Dica:** Sempre verificar data e fonte dos dados secundarios.

---

## Amostragem

### Amostra Probabilistica
Todos tem chance conhecida de ser selecionados.

| Tipo | Quando usar |
|------|-------------|
| Aleatoria simples | Base homogenea |
| Estratificada | Grupos distintos importantes |
| Por conglomerado | Base geograficamente dispersa |
| Sistematica | Lista ordenada disponivel |

### Amostra Nao-Probabilistica
Selecao por conveniencia ou julgamento.

| Tipo | Quando usar |
|------|-------------|
| Conveniencia | Estudos exploratórios |
| Bola de neve | Populacoes de difícil acesso |
| Intencional | Perfis específicos importantes |
| Por cota | Garantir representatividade |

### Tamanho de Amostra

**Para pesquisa quantitativa:**
- Margem de erro de 5%: ~385 respondentes (populacao grande)
- Margem de erro de 3%: ~1.067 respondentes

**Para pesquisa qualitativa:**
- Saturacao teorica: quando novas entrevistas nao trazem insights novos
- Tipicamente: 15-30 entrevistas

---

## Analise de Dados

### Estatistica Descritiva
- Media, mediana, moda
- Desvio padrao, variancia
- Percentis e quartis
- Frequencias e distribuicoes

### Analise de Correlacao
- Coeficiente de Pearson (linear)
- Spearman (ordinal)
- Cuidado: correlacao =/= causalidade

### Segmentacao
- Clustering (K-means, hierarquico)
- RFM (Recency, Frequency, Monetary)
- Analise de cohort

### Analise Qualitativa
- Codificacao tematica
- Analise de conteudo
- Grounded theory
- Framework analysis

---

## Validacao e Qualidade

### Triangulacao
Combinar multiplas fontes para validar descobertas:
- Diferentes metodos (quali + quanti)
- Diferentes fontes (primaria + secundaria)
- Diferentes pesquisadores

### Vieses Comuns

| Vies | Descricao | Como evitar |
|------|-----------|-------------|
| Confirmacao | Buscar dados que confirmem hipotese | Pre-registrar hipoteses |
| Selecao | Amostra nao representativa | Amostragem rigorosa |
| Resposta | Respondente quer agradar | Perguntas neutras |
| Sobrevivencia | So analisar casos de sucesso | Incluir casos de insucesso |

### Checklist de Qualidade

```
[ ] Objetivo de pesquisa claro
[ ] Metodologia apropriada
[ ] Amostra representativa
[ ] Instrumento validado
[ ] Dados limpos e consistentes
[ ] Analise rigorosa
[ ] Limitacoes explicitadas
[ ] Conclusoes suportadas por evidencias
```

---

## Ferramentas Recomendadas

### Coleta
- **Surveys:** Typeform, Google Forms, SurveyMonkey
- **Entrevistas:** Zoom, Google Meet, Otter.ai (transcricao)
- **Analise de reviews:** AppFollow, G2

### Analise
- **Quantitativo:** Excel, Google Sheets, Python (Pandas)
- **Qualitativo:** NVivo, Atlas.ti, Dovetail
- **Visualizacao:** Tableau, Power BI, Google Data Studio

### Pesquisa Secundaria
- **Mercado:** Statista, Euromonitor, IBISWorld
- **Academico:** Google Scholar, ResearchGate
- **Tendencias:** Google Trends, Exploding Topics
- **Social:** BuzzSumo, Brandwatch
