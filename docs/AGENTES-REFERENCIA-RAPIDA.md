# Sleep Agent - Referencia Rapida de Agentes

Use `@` seguido do prefixo para encontrar rapidamente o agente que precisa.

---

## Prefixos por Area

| Prefixo | Area | Descricao |
|---------|------|-----------|
| `@mkt-` | Marketing | Copywriting, estrategia, trafego pago |
| `@edu-` | Educacional | Cursos, aulas, avaliacoes |
| `@brand-` | Branding | Identidade visual, design, UX |
| `@cs-` | Customer Success | Onboarding, retencao, casos criticos |
| `@prod-` | Produtos | Estrategia, discovery, delivery |
| `@legal-` | Juridico | Contratos, empresarial, compliance |
| `@crim-` | Criminal | Defesa, recursos, execucao penal |
| `@data-` | Dados | Analise, pesquisa, ciencia de dados |
| `@ti-` | TI | Automacao, integracoes, processos |
| `@sec-` | Secretaria | Demandas, prioridades, coordenacao |
| `@deploy-` | Deploy | Publicacao, DNS, QA |
| `@meta-` | Meta/Criador | Criar extensoes, agentes, workflows |

---

## Lista Completa de Agentes

### MARKETING (@mkt-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@mkt-copy` | MKT Copywriter | Headlines, emails, paginas de venda, VSLs |
| `@mkt-estrategia` | MKT Estrategista | Pesquisa, ICP, persona, posicionamento, ofertas |
| `@mkt-trafego` | MKT Trafego | Meta Ads, Google Ads, campanhas, otimizacao |

### EDUCACIONAL (@edu-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@edu-arquiteto` | EDU Arquiteto | Arquitetura de cursos, Bloom, trilhas, estrutura |
| `@edu-conteudo` | EDU Conteudista | Aulas, roteiros, material didatico, slides |
| `@edu-avaliacao` | EDU Avaliador | Provas, exercicios, rubricas, gamificacao |

### BRANDING (@brand-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@brand-estrategia` | BRAND Estrategista | Posicionamento de marca, arquetipo, valores |
| `@brand-analista` | BRAND Analista | Reverse engineering visual, extracao de padroes |
| `@brand-designer` | BRAND Designer | Logo, identidade visual, paleta de cores |
| `@brand-ux` | BRAND UX | Interfaces, landing pages, design systems |

### CUSTOMER SUCCESS (@cs-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@cs-estrategia` | CS Estrategista | Health score, segmentacao, metricas, jornada |
| `@cs-onboarding` | CS Onboarding | Ativacao, TTFV, playbooks, boas-vindas |
| `@cs-retencao` | CS Retencao | Anti-churn, NPS, QBR, expansion revenue |
| `@cs-criticos` | CS Criticos | Casos criticos, de-escalation, compensacoes |

### PRODUTOS (@prod-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@prod-estrategia` | PROD Estrategista | Visao, OKRs, PMF, go-to-market |
| `@prod-discovery` | PROD Discovery | OST, JTBD, entrevistas, validacao |
| `@prod-delivery` | PROD Delivery | Priorizacao RICE/Kano, roadmap, backlog |

### JURIDICO (@legal-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@legal-empresarial` | LEGAL Empresarial | Societario, M&A, governanca, sucessao |
| `@legal-contratos` | LEGAL Contratos | Elaboracao e revisao de contratos |
| `@legal-compliance` | LEGAL Compliance | LGPD, politicas, termos de uso |

### CRIMINAL (@crim-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@crim-defesa` | CRIM Defesa | Defesa criminal, teses, resposta a acusacao |
| `@crim-juri` | CRIM Juri | Crimes dolosos, tribunal do juri |
| `@crim-execucao` | CRIM Execucao | Beneficios, progressao de regime |
| `@crim-recursos` | CRIM Recursos | HC, apelacao, REsp, RE |

### DADOS (@data-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@data-analista` | DATA Analista | Relatorios, dashboards, storytelling com dados |
| `@data-cientista` | DATA Cientista | Pesquisa profunda, analise exploratoria |
| `@data-pesquisador` | DATA Pesquisador | Inteligencia competitiva, tendencias, benchmark |

### TI (@ti-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@ti-processos` | TI Processos | Mapear processos manuais, propor solucoes |
| `@ti-integracoes` | TI Integracoes | APIs, conectar sistemas, webhooks |
| `@ti-automacao` | TI Automacao | Playwright, web scraping, automacao |

### SECRETARIA (@sec-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@sec-demandas` | SEC Demandas | Captura, categorizacao, estruturacao |
| `@sec-prioridades` | SEC Prioridades | Eisenhower, ABC, resolucao de conflitos |
| `@sec-coordenador` | SEC Coordenador | Agendar, acompanhar, coordenar execucao |

### DEPLOY (@deploy-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@deploy-engineer` | DEPLOY Engineer | Deploys, Git, Vercel/Netlify/Cloudflare |
| `@deploy-dns` | DEPLOY DNS | Dominios, registros DNS, propagacao |
| `@deploy-qa` | DEPLOY QA | Testes, validacao URLs, responsividade |

### META/CRIADOR (@meta-)

| Comando | Agente | O que faz |
|---------|--------|-----------|
| `@meta-extensoes` | META Extensoes | Arquitetura, estrutura de extensoes |
| `@meta-agentes` | META Agentes | Criar personas de agentes especializados |
| `@meta-workflows` | META Workflows | Desenhar processos, fases, etapas |

---

## Fluxos Comuns

### Criar Curso + Vender

```
@edu-arquiteto -> @edu-conteudo -> @edu-avaliacao
                        |
                        v
@mkt-estrategia -> @mkt-copy -> @mkt-trafego
```

### Criar Marca + Produto

```
@brand-estrategia -> @brand-designer -> @brand-ux
                           |
                           v
@prod-estrategia -> @prod-discovery -> @prod-delivery
```

### Lançar Site

```
@brand-ux -> @mkt-copy -> @deploy-engineer -> @deploy-qa
```

### Customer Success Completo

```
@cs-onboarding -> @cs-estrategia -> @cs-retencao
                         |
                         v
                  @cs-criticos (se necessario)
```

---

## Dicas de Uso

1. **Digite @** e comece a digitar o prefixo da area
2. **Use Tab** para autocompletar
3. **Combine agentes** de diferentes areas para projetos complexos
4. **Cada agente sabe** quando delegar para outro

---

## Total: 39 Agentes Especializados

| Area | Quantidade |
|------|------------|
| Marketing | 3 |
| Educacional | 3 |
| Branding | 4 |
| Customer Success | 4 |
| Produtos | 3 |
| Juridico | 3 |
| Criminal | 4 |
| Dados | 3 |
| TI | 3 |
| Secretaria | 3 |
| Deploy | 3 |
| Meta/Criador | 3 |
| **TOTAL** | **39** |
