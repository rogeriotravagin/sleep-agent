# Vícios de Linguagem da IA — Antipatterns que Matam Sua Copy

## Por que Este Documento Existe

Toda IA tem vícios. Padrões que se repetem, tiques de linguagem, muletas invisíveis que transformam um texto potencialmente bom em algo genérico, frio, sem alma.

Este documento cataloga **cada um desses vícios**, mostra como identificar e dá a correção exata.

Leia. Internalize. E nunca mais escreva como robô.

---

## VÍCIO 1: Excesso de Pontos Finais (Texto Metralhadora)

### O problema
A IA trata cada frase como unidade isolada. Coloca ponto final. Começa outra frase. Coloca ponto final. E assim vai. O texto vira uma rajada de frases curtas e desconectadas.

### Como identificar
Três ou mais frases consecutivas terminando em ponto final, todas com tamanho parecido, sem nenhum conectivo entre elas.

### Exemplo ruim
```
Nosso método é comprovado. Mais de 5 mil pessoas já usaram. Os resultados aparecem em 30 dias. Você pode começar hoje. O investimento é acessível. Temos garantia de 7 dias.
```

### Correção
```
Nosso método é comprovado — mais de 5 mil pessoas já usaram e os resultados aparecem em 30 dias.

Quer começar hoje? Pode. O investimento cabe no bolso e você ainda tem 7 dias de garantia pra testar sem risco.
```

### Regra
Nunca mais de 3 frases seguidas terminando em ponto final com tamanho similar. Varie com vírgulas, travessões, reticências, perguntas.

---

## VÍCIO 2: Acentuação Inconsistente

### O problema
A IA às vezes "esquece" acentos ou os coloca de forma inconsistente. Num parágrafo escreve "é", no outro escreve "e" (sem acento) quando deveria acentuar. Ou confunde "á" com "a", "ão" com "ao".

### Erros mais comuns
| Errado | Certo | Tipo |
|--------|-------|------|
| voce | você | Acento agudo |
| tambem | também | Acento agudo |
| nao | não | Til |
| ja | já | Acento agudo |
| ate | até | Acento agudo |
| e (verbo ser) | é | Acento agudo |
| esta (verbo) | está | Acento agudo |
| numero | número | Acento agudo |
| unico | único | Acento agudo |
| facil | fácil | Acento agudo |
| impossivel | impossível | Acento agudo |
| voces | vocês | Circunflexo |
| nos (pronome tônico) | nós | Acento agudo |

### Regra
**SEMPRE** acentuar corretamente. Sem exceção. Acento errado ou faltando é erro grave — destrói credibilidade instantaneamente.

Mesmo em copy informal, a acentuação segue as regras do português. "Pra" pode, "tá" pode, mas "voce" sem acento NUNCA.

---

## VÍCIO 3: Tom Corporativo Robótico

### O problema
A IA foi treinada com toneladas de texto corporativo e acadêmico. Resultado: escreve como se fosse um relatório da McKinsey traduzido do inglês.

### Palavras-gatilho do robô
Quando você vê essas palavras, pare. Reescreva.

**Categoria: Adjetivos vazios**
- "diversos" → substituir por número exato
- "inúmeros" → substituir por número exato
- "vários" → substituir por número exato
- "múltiplos" → substituir por número exato
- "significativo" → dizer o quanto
- "relevante" → dizer por quê
- "fundamental" → dizer pra quê

**Categoria: Verbos corporativos**
- "otimizar" → "melhorar", "acelerar", "cortar pela metade"
- "maximizar" → "dobrar", "triplicar", número concreto
- "potencializar" → "turbinar", "destravar", verbo real
- "viabilizar" → "fazer acontecer", "tornar possível"
- "impactar" → "mudar", "transformar", "destruir"
- "alavancar" → "usar", "aproveitar"
- "implementar" → "colocar em prática", "fazer"

**Categoria: Substantivos ocos**
- "aspectos" → dizer quais
- "fatores" → dizer quais
- "elementos" → dizer quais
- "contexto" → ser específico
- "cenário" → descrever a situação real
- "paradigma" → eliminar da face da terra

**Categoria: Conectivos formais demais**
- "portanto" → "então", "por isso"
- "entretanto" → "mas", "só que"
- "ademais" → "e tem mais", "além disso"
- "outrossim" → não. Só não.
- "destarte" → menos ainda
- "não obstante" → "mesmo assim", "mas"
- "consoante" → "como", "segundo"

### Exemplo ruim
```
Gostaríamos de apresentar nossa solução inovadora que possibilita a otimização de diversos processos, viabilizando resultados significativos e potencializando a performance de sua organização.
```

### Correção
```
A gente criou uma ferramenta que corta pela metade o tempo que você gasta em tarefas manuais.

500 empresas já testaram. Resultado médio: 10 horas a menos por semana fazendo trabalho repetitivo.
```

### Regra
Se você não falaria isso numa conversa com amigo, não escreva.

---

## VÍCIO 4: Estrutura de Ensaio Acadêmico

### O problema
A IA organiza texto assim: introdução → ponto 1 → ponto 2 → ponto 3 → conclusão. Toda vez. Todo texto. Como redação do ENEM.

### Como identificar
- Começa com "Neste artigo, vamos explorar..."
- Tem títulos como "Primeiro ponto:", "Segundo ponto:", "Terceiro ponto:"
- Termina com "Portanto, podemos concluir que..." ou "Em resumo..."
- Frases de abertura que descrevem o que o texto vai fazer em vez de fazer

### O que fazer
Comece pelo impacto. Abra com uma história, uma pergunta, uma afirmação forte. O leitor não quer saber o que você vai dizer — quer que você diga.

### Exemplo ruim
```
Neste guia, vamos explorar as principais estratégias para aumentar suas vendas online. Abordaremos três pontos fundamentais que, quando aplicados corretamente, podem transformar seus resultados.

1. Tráfego qualificado
O primeiro passo é garantir que...

2. Página otimizada
Em segundo lugar...

3. Follow-up eficiente
Por fim, é importante...

Conclusão: Ao aplicar essas três estratégias, você estará no caminho certo para resultados expressivos.
```

### Correção
```
Minhas vendas estavam no zero.

Zero. Nada. Silêncio no caixa.

Aí eu mudei 3 coisas — e em 60 dias faturei R$ 47 mil.

Não foi sorte. Foi método.

E o método é ridiculamente simples...
```

### Regra
Nunca comece com "Neste artigo...", "Vamos explorar...", "Neste guia...". Comece pelo meio da ação.

---

## VÍCIO 5: Listas Numeradas como Muleta

### O problema
A IA ama listas. Ama demais. Transforma tudo em bullet points e números. Até quando não faz sentido.

### Quando lista funciona
- Comparação de features
- Passo a passo de um processo
- Benefícios rápidos (bullets de venda)

### Quando lista NÃO funciona
- Narrativa emocional
- Storytelling
- Argumentação persuasiva
- Conexão empática
- Desenvolvimento de ideia complexa

### Exemplo ruim
```
Por que investir em copywriting:

1. Aumenta suas vendas
2. Melhora a comunicação
3. Cria conexão com clientes
4. Diferencia da concorrência
5. Gera mais leads
```

### Correção
```
Sabe por que seu concorrente vende mais que você?

Não é porque o produto dele é melhor. Não é porque ele gasta mais em anúncio.

É porque ele fala a língua do cliente. Ele sabe escrever de um jeito que a pessoa lê e pensa: "parece que tão falando comigo".

Isso é copywriting. E é a habilidade que separa quem fatura de quem reclama.
```

### Regra
Antes de criar uma lista, pergunte: "Isso ficaria melhor como narrativa?" Se a resposta for sim, escreva como texto corrido.

---

## VÍCIO 6: Excesso de Qualificadores e Hedge Words

### O problema
A IA é treinada pra ser cautelosa. Resultado: polvilha o texto com palavras que enfraquecem tudo.

### Palavras que matam a copy
- "pode ajudar a..." → ajuda.
- "é possível que..." → acontece.
- "tende a..." → faz.
- "em certa medida..." → cortar.
- "de certa forma..." → cortar.
- "relativamente..." → cortar.
- "geralmente..." → cortar (ou dar o dado).
- "provavelmente..." → cortar.
- "talvez..." → decidir: é ou não é?
- "um pouco..." → quanto exatamente?
- "basicamente..." → cortar.
- "essencialmente..." → cortar.
- "em última análise..." → "no fim das contas" ou cortar.

### Exemplo ruim
```
Nosso método pode ajudar a melhorar relativamente seus resultados, geralmente trazendo benefícios significativos que, em certa medida, podem transformar a forma como você trabalha.
```

### Correção
```
Nosso método melhora seus resultados. Ponto.

Quem aplica, fatura mais. Quem não aplica, continua onde está.
```

### Regra
Copy precisa de convicção. Se você não tem certeza do que está dizendo, pesquise até ter. Depois, diga com segurança.

---

## VÍCIO 7: Frases Genéricas de Abertura e Fechamento

### O problema
A IA tem uma coleção de frases prontas pra começar e terminar textos. São reconhecíveis a quilômetros.

### Aberturas que denunciam IA
- "Você já se perguntou...?"
- "No mundo de hoje..."
- "Em um cenário cada vez mais..."
- "É inegável que..."
- "Não é segredo que..."
- "Como sabemos..."
- "Ao longo dos anos..."
- "Na era digital..."

### Fechamentos que denunciam IA
- "Em resumo..."
- "Portanto, podemos concluir que..."
- "Diante do exposto..."
- "Em última análise..."
- "Sendo assim..."
- "Fica claro que..."
- "Dessa forma, percebemos que..."
- "Sem dúvida alguma..."

### O que fazer
Abertura: comece com fato, pergunta direta, declaração forte ou história. Fechamento: termine com CTA, frase de impacto ou pergunta que fica na cabeça.

### Exemplo de fechamento ruim
```
Portanto, podemos concluir que investir em copywriting é essencial para qualquer empreendedor que deseja alcançar resultados expressivos em seus negócios digitais.
```

### Correção
```
Então, sua escolha:

Continuar escrevendo textos que ninguém lê.

Ou aprender a escrever de um jeito que faz caixa.

Você decide.
```

---

## VÍCIO 8: Repetição Excessiva de Palavras-Chave

### O problema
A IA martela a mesma palavra várias vezes. Se o tema é "produtividade", vai usar "produtividade" 15 vezes num texto de 500 palavras.

### Como identificar
Leia o texto e destaque a palavra mais repetida. Se aparece mais de 3 vezes em 2 parágrafos, tem problema.

### Solução
Use sinônimos naturais, pronomes, reformulações. Ou simplesmente omita quando o contexto já deixa claro.

### Exemplo ruim
```
A produtividade é essencial. Para aumentar sua produtividade, você precisa de ferramentas de produtividade. Nossa ferramenta de produtividade melhora a produtividade em até 50%.
```

### Correção
```
Você precisa render mais — e em menos tempo.

Com a ferramenta certa, dá pra fazer em 2 horas o que antes levava um dia inteiro.

Resultado? 50% mais entregas sem trabalhar mais.
```

---

## VÍCIO 9: Falsa Empatia e Emoção Forçada

### O problema
A IA tenta soar empática, mas de um jeito que parece roteiro de atendente de telemarketing.

### Frases de falsa empatia
- "Entendemos perfeitamente sua dor..."
- "Sabemos como é difícil..."
- "Você não está sozinho nessa jornada..."
- "Sentimos sua frustração..."
- "Compreendemos os desafios que..."

### Por que é ruim
Porque é vago. Não demonstra entendimento REAL. Diz que entende sem provar que entende.

### O que fazer
Descreva a situação específica. Mostre que SABE como é. Dê detalhes que só quem viveu saberia.

### Exemplo ruim
```
Sabemos como é difícil empreender. Entendemos os desafios que você enfrenta diariamente. Estamos aqui para ajudar.
```

### Correção
```
Acordar às 5h. Responder cliente no WhatsApp enquanto escova os dentes. Almoçar em 10 minutos na frente do computador. Deitar à meia-noite sem saber se vai ter dinheiro pra pagar a conta de luz.

Eu sei como é. Vivi isso por 3 anos.
```

### Regra
Empatia se prova com detalhes, não com declarações genéricas.

---

## VÍCIO 10: Transições Telegrafadas

### O problema
A IA sinaliza toda mudança de assunto com transições óbvias e desnecessárias.

### Transições que denunciam IA
- "Dito isso..."
- "Com isso em mente..."
- "Tendo isso em vista..."
- "Nesse sentido..."
- "Diante disso..."
- "À luz do que foi apresentado..."
- "Seguindo essa linha de raciocínio..."
- "Agora que entendemos X, vamos falar sobre Y..."

### O que fazer
Corte a transição. Se o texto flui bem, a mudança acontece naturalmente. Se não flui, o problema está na organização das ideias, não na falta de transição.

### Exemplo ruim
```
As vendas caíram 30% no último trimestre. Dito isso, é importante considerar que o mercado como um todo passou por turbulências. Nesse sentido, nossa estratégia precisou se adaptar.
```

### Correção
```
Vendas caíram 30%.

O mercado inteiro balançou. A gente se adaptou.
```

---

## VÍCIO 11: Excesso de Paralelismo Perfeito

### O problema
A IA ama paralelismo. Cria estruturas simétricas demais. Tudo bonitinho, tudo equilibrado. Mas a vida não é simétrica — e textos simétricos demais parecem artificiais.

### Como identificar
```
Não é sobre velocidade. É sobre consistência.
Não é sobre talento. É sobre dedicação.
Não é sobre sorte. É sobre estratégia.
```

(Uma ou duas: ótimo. Três ou mais: vício de IA.)

### Regra
Paralelismo funciona em DOSES. Use uma ou duas construções paralelas pra criar ritmo. Depois quebre o padrão.

### Correção
```
Não é sobre velocidade — é sobre consistência.

Talento sem dedicação não vale nada.

E sorte? Sorte é o que acontece quando a estratégia encontra a oportunidade.
```

---

## VÍCIO 12: Linguagem "Traduzida" do Inglês

### O problema
Muitos modelos de IA pensam em inglês e traduzem. Resultado: construções que soam estranhas em português.

### Anglicismos estruturais comuns
| Padrão inglês | Tradução robótica | Forma natural em PT-BR |
|---------------|-------------------|----------------------|
| "It is important to..." | "É importante..." | "O que importa é..." ou reformular |
| "In order to..." | "A fim de..." | "Pra..." |
| "Make sure..." | "Certifique-se de..." | "Garanta que..." ou "Faz isso:" |
| "Keep in mind..." | "Tenha em mente..." | "Lembra:", "Olha:" |
| "Based on..." | "Baseado em..." | "Com base em..." ou "A partir de..." |
| "At the end of the day..." | "No final do dia..." | "No fim das contas..." |
| "Game changer" | "Divisor de águas" | pode funcionar, mas avaliar contexto |
| "Leverage" | "Alavancar" | "Usar", "Aproveitar" |
| "Mindset" | "Mentalidade" | funciona, mas evitar excesso |
| "Framework" | "Framework" | em contexto técnico: ok. Copy: "método", "sistema" |

### Exemplo ruim
```
É importante ter em mente que, a fim de alavancar seus resultados, você precisa se certificar de implementar as estratégias corretas. No final do dia, isso será um verdadeiro game changer.
```

### Correção
```
Quer resultado de verdade? Então aplica o método certo.

Simples. Sem firula.

E quando funcionar — e vai funcionar — você vai se perguntar por que não fez isso antes.
```

---

## QUADRO DE REFERÊNCIA RÁPIDA

| # | Vício | Sinal de Alerta | Correção |
|---|-------|-----------------|----------|
| 1 | Texto metralhadora | 3+ frases curtas seguidas com ponto | Variar pontuação: vírgulas, travessões, reticências |
| 2 | Acentuação inconsistente | Palavras sem acento | Revisar TODA acentuação |
| 3 | Tom corporativo | "otimizar", "diversos", "viabilizar" | Linguagem de conversa real |
| 4 | Ensaio acadêmico | "Neste artigo vamos explorar..." | Começar pelo impacto |
| 5 | Listas como muleta | Tudo vira bullet point | Narrativa quando couber |
| 6 | Qualificadores fracos | "pode", "talvez", "relativamente" | Afirmar com convicção |
| 7 | Aberturas/fechamentos genéricos | "Em resumo...", "No mundo de hoje..." | Fato, pergunta ou história |
| 8 | Repetição de palavras-chave | Mesma palavra 5x em 2 parágrafos | Sinônimos e reformulações |
| 9 | Falsa empatia | "Sabemos como é difícil..." | Detalhes específicos e vividos |
| 10 | Transições telegrafadas | "Dito isso...", "Nesse sentido..." | Cortar e deixar fluir |
| 11 | Paralelismo excessivo | 3+ construções simétricas | Usar em doses, depois quebrar |
| 12 | Linguagem traduzida | "É importante ter em mente..." | Reescrever em PT-BR natural |

---

## COMO USAR ESTE DOCUMENTO

### Na hora de escrever
1. Escreva o rascunho
2. Releia procurando cada vício desta lista
3. Corrija um por um
4. Leia em voz alta — se travar, tem problema

### Na hora de revisar
1. Escaneie primeiro os vícios mais graves (1, 3, 4, 6)
2. Depois os vícios de estilo (5, 7, 8, 10, 11)
3. Por último, detalhes (2, 9, 12)

### Pra internalizar
Leia os exemplos ruins em voz alta. Sinta o desconforto. Depois leia as correções. Sinta a diferença. Esse contraste vai calibrar seu radar.

---

**Versão:** 1.0
**Data:** 17/02/2026
**Atualização:** Sempre que novos vícios forem identificados
