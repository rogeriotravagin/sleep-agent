# Mautic 5 - Diretrizes de Email HTML

## VISAO GERAL

O Mautic 5 usa o **GrapesJS** como builder visual de emails. O formato de trabalho e **HTML com inline CSS**, que ao ser colado no editor de codigo do Mautic, e automaticamente convertido para o builder visual.

**Regra de ouro:** Sempre gerar HTML com inline CSS. O Mautic converte automaticamente para o builder GrapesJS.

**Fluxo de trabalho:**
1. Sleep Agent gera o HTML completo com inline CSS
2. Usuario abre o Mautic > Channels > Emails > New
3. Clica em "Code Editor" ou "Source"
4. Cola o HTML
5. O GrapesJS converte e exibe visualmente
6. Usuario pode editar visualmente se quiser

---

## ESTRUTURA HTML PARA EMAIL

### Padrao de Estrutura

```html
<!-- Container externo (background) -->
<div style="font-family: ...; background: #f4f4f4; margin: 0; padding: 20px;">

  <!-- Container principal (600px) -->
  <div style="max-width: 600px; margin: 0 auto; background: #ffffff;">

    <!-- Header -->
    <div style="padding: 48px 30px; text-align: center;">
      <!-- Logo em table para compatibilidade -->
      <table cellpadding="0" cellspacing="0" border="0" align="center">
        <tr><td>LOGO</td></tr>
      </table>
    </div>

    <!-- Conteudo -->
    <div style="padding: 40px 48px;">
      <h2 style="...">Titulo</h2>
      <p style="...">Texto</p>

      <!-- Botao CTA (sempre em table) -->
      <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
          <td align="center">
            <table cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="background: #COR; border-radius: 16px;">
                  <a href="URL" style="display: inline-block; padding: 20px 48px; color: #fff; text-decoration: none;">TEXTO</a>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </div>

    <!-- Footer -->
    <div style="padding: 36px 48px; text-align: center;">
      <p style="...">Info + unsubscribe</p>
    </div>

  </div>
</div>
```

### Regras de HTML para Email

| Regra | Motivo |
|-------|--------|
| **Inline CSS em TUDO** | Clientes de email removem `<style>` tags |
| **Tables para botoes** | `<a>` com padding nao funciona em Outlook |
| **Tables para cards** | Garantem layout em todos os clientes |
| **Divs para estrutura simples** | Containers, secoes de conteudo |
| **cellpadding="0" cellspacing="0" border="0"** | Reset de table obrigatorio |
| **max-width: 600px** | Largura maxima universal |
| **Sem `<style>` tag** | Tudo inline, sem CSS externo |
| **Sem CSS classes** | Clientes de email podem remover |
| **Sem JavaScript** | Bloqueado por todos os clientes |
| **Sem position/float** | Suporte inconsistente |

### Elementos que DEVEM usar Table

1. **Botoes CTA** - Table > tr > td com background > `<a>` com padding
2. **Cards com borda** - Table com border/border-radius
3. **Layout 2+ colunas** - Table com multiple `<td>`
4. **Badges/pills** - Table com border-radius
5. **Alinhamento centralizado** de blocos - Table com align="center"

### Elementos que podem usar Div

1. **Container externo** (background geral)
2. **Container principal** (max-width: 600px)
3. **Secoes de conteudo** (padding wrapper)
4. **Divisores simples** (height: 1px; background: cor)

---

## TOKENS DO MAUTIC - REFERENCIA COMPLETA

### Campos de Contato

```
{contactfield=firstname}          → Nome
{contactfield=lastname}           → Sobrenome
{contactfield=email}              → Email
{contactfield=phone}              → Telefone
{contactfield=company}            → Empresa
{contactfield=city}               → Cidade
{contactfield=state}              → Estado
{contactfield=country}            → Pais
{contactfield=position}           → Cargo
{contactfield=title}              → Titulo
{contactfield=website}            → Site
{contactfield=address1}           → Endereco 1
{contactfield=address2}           → Endereco 2
{contactfield=zipcode}            → CEP
```

### Campos com Valor Padrao (Fallback)

```
{contactfield=firstname|amigo}    → "amigo" se nome nao existir
{contactfield=company|sua empresa} → Fallback para empresa
```

### Campos de Data

```
{contactfield=CAMPO|datetime}     → Data e hora
{contactfield=CAMPO|date}         → Apenas data
{contactfield=CAMPO|time}         → Apenas hora
```

### Campos da Empresa

```
{contactfield=companyname}
{contactfield=companyemail}
{contactfield=companyphone}
{contactfield=companyindustry}
{contactfield=companywebsite}
{contactfield=companycity}
{contactfield=companystate}
{contactfield=companycountry}
{contactfield=companyannual_revenue}
{contactfield=companynumber_of_employees}
```

### Campos do Proprietario (Owner)

```
{ownerfield=firstname}            → Nome do dono do contato
{ownerfield=lastname}
{ownerfield=email}
{ownerfield=position}
{ownerfield=signature}            → Assinatura do owner
```

### Tokens de Email (OBRIGATORIOS)

```
{unsubscribe_text}                → Link de descadastro com texto
{unsubscribe_url}                 → URL de descadastro (para href)
{webview_text}                    → Link "ver no navegador" com texto
{webview_url}                     → URL de webview
{tracking_pixel}                  → Pixel de rastreamento (OBRIGATORIO)
{signature}                       → Assinatura configurada
{subject}                         → Assunto do email
{resubscribe_url}                 → URL de re-inscricao
```

### Tokens de Componentes

```
{assetlink=ID}                    → Link para asset
{pagelink=ID}                     → Link para landing page
{form=ID}                         → Formulario incorporado
{focus=ID}                        → Focus item
{dynamiccontent="Nome"}           → Conteudo dinamico
```

### Tokens de Monitoramento

```
{language}                        → Idioma do contato
{page_title}                      → Titulo da pagina
{page_url}                        → URL da pagina
{referrer}                        → Referrer
{utm_source}                      → UTM Source
{utm_medium}                      → UTM Medium
{utm_campaign}                    → UTM Campaign
```

### Preference Center

```
{leadidentifier}                  → Identificador do lead
{categorylist}                    → Lista de categorias
{segmentlist}                     → Lista de segmentos
{preferredchannel}                → Canal preferido
{channelfrequency}                → Frequencia de canal
{saveprefsbutton}                 → Botao salvar preferencias
```

---

## PADRAO DE BOTAO CTA

### Botao Solido (primario)

```html
<table cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>
    <td align="center">
      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td style="background: #COR_PRIMARIA; border-radius: 16px;">
            <a href="URL" style="display: inline-block; padding: 20px 48px; color: #FFFFFF; text-decoration: none; font-weight: 800; font-size: 12px; letter-spacing: 2px; text-transform: uppercase;">TEXTO CTA</a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
```

### Botao Outline (secundario)

```html
<table cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>
    <td align="center">
      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td style="background: transparent; border: 2px solid #COR; border-radius: 16px;">
            <a href="URL" style="display: inline-block; padding: 16px 32px; color: #COR; text-decoration: none; font-weight: 800; font-size: 10px; letter-spacing: 2px; text-transform: uppercase;">TEXTO</a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
```

---

## PADRAO DE CARD

```html
<table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px solid #BORDA; border-radius: 24px; background: #BG_CARD; margin-bottom: 32px;">
  <tr>
    <td style="padding: 28px; text-align: center;">
      <p style="margin: 0 0 8px 0; font-size: 11px; font-weight: 500; color: #LABEL_COR; text-transform: uppercase; letter-spacing: 0.5px;">LABEL</p>
      <p style="margin: 0 0 4px 0; font-size: 32px; font-weight: 700; color: #DESTAQUE;">VALOR PRINCIPAL</p>
      <p style="margin: 0; font-size: 24px; font-weight: 600; color: #SECUNDARIO;">VALOR SECUNDARIO</p>
    </td>
  </tr>
</table>
```

---

## PADRAO DE BADGE/PILL

```html
<table cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td style="background-color: rgba(COR, 0.15); border-radius: 100px; padding: 10px 24px;">
      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td style="width: 10px; height: 10px; background-color: #COR; border-radius: 50%;"></td>
          <td style="padding-left: 10px; font-size: 9px; font-weight: 800; color: #COR; letter-spacing: 3px; text-transform: uppercase;">TEXTO BADGE</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
```

---

## PADRAO DE DIVISOR

### Divisor simples
```html
<div style="height: 1px; background-color: #COR_BORDA; margin: 32px 0;"></div>
```

### Divisor gradiente
```html
<div style="text-align: center; margin: 32px 0;">
  <span style="display: inline-block; width: 100%; height: 1px; background: linear-gradient(90deg, transparent 0%, #COR_ACCENT 50%, transparent 100%);"></span>
</div>
```

---

## REGRAS DE DESIGN

### Dimensoes

| Propriedade | Valor |
|-------------|-------|
| Largura maxima | 600px |
| Padding lateral conteudo | 48px |
| Padding header/footer | 36-48px |
| Botao CTA minimo | 44x44px (tappable) |
| Border-radius padrao | 16px (botoes), 24px (cards), 40px (container) |

### Fontes Seguras (Web-Safe)

```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, Helvetica, sans-serif;
```

**CUIDADO:** Outlook nao suporta fontes Google de forma confiavel. Sempre usar system fonts com fallback.

### Tamanhos de Fonte

| Elemento | Tamanho | Peso |
|----------|---------|------|
| Titulo principal | 28px | 700 |
| Subtitulo | 18-20px | 600 |
| Corpo do texto | 16-18px | 400 |
| Botao CTA | 12px | 800 + uppercase + letter-spacing |
| Label/tag | 9-11px | 800 + uppercase + letter-spacing |
| Footer | 10-12px | 400 |
| Preheader oculto | 1px | - |

### Line Height

- **Corpo:** 1.7
- **Titulos:** 1.2-1.3
- **Footer:** 1.8

### Imagens

| Regra | Valor |
|-------|-------|
| Formato preferido | JPG para fotos, PNG para graficos |
| Largura maxima | 600px |
| DPI | 144 (2x para retina) |
| Alt text | SEMPRE incluir |
| Hosting | Mautic asset manager ou CDN |
| Tamanho maximo | 200KB por imagem |

---

## PREHEADER OCULTO

Sempre incluir logo apos o container externo:

```html
<div style="display:none;font-size:1px;color:#MESMA_COR_BG;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
  TEXTO DO PREHEADER AQUI
  &zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;
</div>
```

Os caracteres `&zwnj;&nbsp;` preenchem o espaco para evitar que o cliente de email puxe texto do corpo.

---

## DELIVERABILITY - BOAS PRATICAS

### Ratio Texto/Imagem

- **Minimo:** 60% texto / 40% imagens
- **Ideal:** 70% texto / 30% imagens
- **NUNCA:** Email somente com imagens

### Peso do Email

| Tipo | Peso Maximo |
|------|-------------|
| HTML total | 102KB (Gmail clipa acima disso) |
| Ideal | 50-80KB |
| Imagens totais | 800KB maximo |
| Por imagem | 200KB maximo |

### Preheader

- **Tamanho:** 40-90 caracteres
- **Primeiros 50:** Mais importantes
- **NUNCA** repetir o subject line
- **Subject + preheader** devem trabalhar juntos

### Palavras que Disparam Spam Filters

**EVITAR em subject lines:**
- "Gratis", "Free", "Ganhe dinheiro"
- "Clique aqui", "Urgente!!!"
- "Sem compromisso", "Risk-free"
- ALL CAPS
- Multiplos !!! ou ???

### Autenticacao (obrigatorio)

| Protocolo | Funcao |
|-----------|--------|
| SPF | Servidores autorizados a enviar |
| DKIM | Assinatura digital do email |
| DMARC | Politica de autenticacao |

### Regras Gmail/Yahoo (2024+)

- SPF + DKIM + DMARC **obrigatorios** para 5000+ emails/dia
- Taxa de spam maxima: **0.3%**
- **One-click unsubscribe obrigatorio**

### Links e CTA

- **Maximo:** 1 CTA principal por email (pode repetir o mesmo)
- **Texto:** Especifico ("ENTRAR NA AULA AO VIVO" > "Clique aqui")
- **Cor:** Contraste alto com background
- **Tamanho:** Minimo 44x44px
- **Usar HTTPS** em todos os links

---

## FOOTER OBRIGATORIO

Todo email DEVE ter no footer:

```html
<!-- Footer -->
<div style="padding: 36px 48px; text-align: center; border-top: 1px solid #BORDA;">

  <!-- Nome da empresa -->
  <p style="margin: 0 0 10px 0; font-size: 10px; color: #COR_MUTED; line-height: 1.8;">
    NOME_EMPRESA<br>
    Este email foi enviado para {contactfield=email}
  </p>

  <!-- Link de Descadastro (OBRIGATORIO) -->
  <p style="margin: 10px 0 0 0;">
    <a href="{unsubscribe_url}" style="color: #COR_MUTED; text-decoration: underline; font-size: 11px;">Cancelar inscricao</a>
  </p>
</div>

<!-- Tracking Pixel (OBRIGATORIO - nao remover) -->
{tracking_pixel}
```

---

## CHECKLIST PRE-ENVIO

### Obrigatorio
- [ ] Token `{unsubscribe_url}` presente no footer
- [ ] Token `{tracking_pixel}` presente no final
- [ ] Preheader oculto definido (diferente do subject)
- [ ] Alt text em todas as imagens
- [ ] Links HTTPS
- [ ] CTA claro e funcional
- [ ] Inline CSS em TUDO (sem `<style>` tag)
- [ ] Botoes em table (nao em `<a>` simples)
- [ ] Subject line < 50 caracteres
- [ ] Peso total < 102KB

### Recomendado
- [ ] Fontes system com fallback web-safe
- [ ] Ratio texto/imagem 60/40+
- [ ] P.S. com reforco de CTA
- [ ] Tokens com valor padrao ({contactfield=firstname|amigo})
- [ ] Testado em preview mobile no Mautic

---

## REFERENCIAS

- Documentacao oficial Mautic 5: https://docs.mautic.org/en/5.x/
- GrapesJS Builder: https://devdocs.mautic.org/en/5.x/themes/grapesjs.html
- Variaveis Mautic: https://docs.mautic.org/en/5.x/configuration/variables.html
- Criacao de Temas: https://docs.mautic.org/en/5.x/builders/creating_themes.html
