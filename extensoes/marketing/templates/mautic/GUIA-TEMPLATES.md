# Guia de Templates HTML para Mautic 5

## Como Funciona

O Sleep Agent gera emails em **HTML com inline CSS**. Voce cola o codigo no editor de codigo do Mautic e ele converte automaticamente para o builder visual GrapesJS.

**Fluxo:**
1. Sleep Agent gera HTML completo
2. No Mautic: Channels > Emails > New
3. Abra o editor de codigo (Source/Code)
4. Cole o HTML
5. O Mautic converte para o builder visual
6. Edite visualmente se quiser

---

## Templates Disponiveis

| Template | Arquivo | Uso |
|----------|---------|-----|
| Base | `base-email.html` | Email simples - boas-vindas, conteudo, relacionamento |
| Venda | `venda.html` | Email de venda com beneficios, preco, garantia, urgencia |
| Newsletter | `newsletter.html` | Newsletter com artigos e destaques |
| Transacional | `transacional.html` | Confirmacoes, pedidos, notificacoes do sistema |

---

## Variaveis de Substituicao

Cada template usa placeholders que DEVEM ser substituidos antes do uso.

### Variaveis de Cor e Visual (todos os templates)

| Variavel | Descricao | Exemplo (dark) | Exemplo (light) |
|----------|-----------|-----------------|------------------|
| `BG_EXTERNO` | Background do body | `#000000` | `#f4f4f4` |
| `BG_CONTEUDO` | Background do container | `#080404` | `#ffffff` |
| `COR_BORDA` | Bordas e divisores | `#2D1518` | `#e0e0e0` |
| `COR_PRIMARIA` | Cor principal / CTA | `#FF2D55` | `#e74c3c` |
| `COR_TITULO` | Titulos e destaques | `#FAFAFA` | `#333333` |
| `COR_TEXTO` | Corpo do texto | `#A09090` | `#555555` |
| `COR_TEXTO_CLARO` | Texto em destaque | `#E8E0E0` | `#333333` |
| `COR_MUTED` | Texto sutil/footer | `#706060` | `#999999` |

### Variaveis de Conteudo (todos os templates)

| Variavel | Descricao | Exemplo |
|----------|-----------|---------|
| `URL_LOGO` | URL da imagem do logo | `https://cdn.exemplo.com/logo.png` |
| `NOME_MARCA` | Nome da marca (alt do logo) | `Sua Marca` |
| `NOME_EMPRESA` | Razao social | `Sua Marca LTDA` |
| `NOME_REMETENTE` | Nome de quem assina | `Equipe Sua Marca` |
| `PREHEADER_TEXT` | Texto de preview (40-90 chars) | `Veja o que preparamos para voce` |
| `URL_CTA` | Link do botao principal | `https://exemplo.com/oferta` |
| `TEXTO_CTA` | Texto do botao | `QUERO COMECAR AGORA` |

### Variaveis do Template de Venda

| Variavel | Descricao |
|----------|-----------|
| `TEXTO_GANCHO_ABERTURA` | Gancho que abre o email |
| `TEXTO_CORPO` | Corpo da argumentacao |
| `BENEFICIO_1` a `BENEFICIO_4` | Lista de beneficios |
| `BONUS_1`, `BONUS_2` | Bonus opcionais |
| `PRECO_ORIGINAL` | Preco riscado |
| `PRECO_ATUAL` | Preco real |
| `PARCELAMENTO` | Opcao parcelada |
| `DIAS` | Dias de garantia |
| `BG_GARANTIA` / `COR_GARANTIA` | Cores do box de garantia |
| `BG_URGENCIA` / `COR_URGENCIA` | Cores do box de urgencia |
| `TEXTO_URGENCIA` | Texto de escassez |
| `TEXTO_PS` | Post scriptum |
| `URL_CHECKOUT` | URL do checkout |

### Variaveis do Template de Newsletter

| Variavel | Descricao |
|----------|-----------|
| `TEXTO_INTRODUCAO_NEWSLETTER` | Intro da edicao |
| `CATEGORIA_N` | Tag de categoria do artigo |
| `TITULO_ARTIGO_N` | Titulo do artigo |
| `RESUMO_ARTIGO_N` | Resumo/excerpt |
| `URL_ARTIGO_N` | Link do artigo |
| `URL_IMAGEM_ARTIGO_N` | Imagem de capa (artigo 1) |
| `BG_TAG` / `COR_TAG` | Cores das tags de categoria |
| `TEXTO_CTA_NEWSLETTER` | Chamada pre-botao |
| `TEXTO_BOTAO` | Texto do botao |

### Variaveis do Template Transacional

| Variavel | Descricao |
|----------|-----------|
| `STATUS_BADGE_TEXT` | Texto do badge (Confirmado, Pendente) |
| `BG_STATUS` / `COR_STATUS` | Cores do badge |
| `TITULO_TRANSACIONAL` | Titulo principal |
| `SUBTITULO_TRANSACIONAL` | Subtitulo explicativo |
| `BG_CARD` | Background do card de info |
| `LABEL_N` / `VALOR_N` | Pares label/valor |
| `MENSAGEM_TRANSACIONAL` | Corpo da mensagem |
| `EMAIL_SUPORTE` | Email de suporte |

---

## Tokens Mautic Incluidos

Todos os templates ja incluem:
- `{contactfield=firstname|amigo}` - Personalizacao com fallback
- `{contactfield=email}` - Email do contato no footer
- `{unsubscribe_url}` - Link de descadastro (OBRIGATORIO)
- `{tracking_pixel}` - Pixel de rastreamento (OBRIGATORIO)

---

## Regras de Ouro

1. **Nunca remover** `{tracking_pixel}` e `{unsubscribe_url}`
2. **Tudo em inline CSS** - Sem `<style>` tags
3. **Botoes em table** - Nunca `<a>` com padding sozinho
4. **Peso maximo** do HTML: 102KB (Gmail clipa acima disso)
5. **Largura:** max-width 600px
6. **Fontes:** System fonts com fallback web-safe
7. **Imagens:** Sempre com alt text
8. **CTA:** Maximo 1 principal (pode repetir o mesmo)
9. **Preheader:** Nunca vazio ou igual ao subject
10. **Testar** no preview mobile do Mautic antes de enviar
