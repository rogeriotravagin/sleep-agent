# Plano de Renomeacao de Agentes - Sleep Agent

## Objetivo

Renomear todos os agentes do Sleep Agent para facilitar a descoberta via @ (autocomplete).
Os usuarios devem poder digitar @ e encontrar rapidamente o agente certo.

---

## Convencao de Nomenclatura

### Formato Padrao

```
@[prefixo]-[funcao]
```

### Prefixos por Extensao

| Extensao | Prefixo | Exemplo |
|----------|---------|---------|
| Marketing | `mkt` | @mkt-copy |
| Educacional | `edu` | @edu-conteudo |
| Branding | `brand` | @brand-visual |
| Customer Success | `cs` | @cs-onboarding |
| Produtos | `prod` | @prod-discovery |
| Juridico | `legal` | @legal-contratos |
| Criminal | `crim` | @crim-defesa |
| Dados | `data` | @data-analista |
| TI | `ti` | @ti-automacao |
| Secretaria | `sec` | @sec-prioridades |
| Deploy | `deploy` | @deploy-engineer |
| Criador | `meta` | @meta-agentes |

---

## Mapeamento Completo de Renomeacao

### MARKETING

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| COPYWRITER.md | Copywriter | MKT Copywriter | @mkt-copy | MKT-COPYWRITER.md |
| ESTRATEGISTA.md | Estrategista | MKT Estrategista | @mkt-estrategia | MKT-ESTRATEGISTA.md |
| TRAFEGO.md | Especialista em Trafego | MKT Trafego | @mkt-trafego | MKT-TRAFEGO.md |

### EDUCACIONAL

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| DESIGNER-INSTRUCIONAL.md | Designer Instrucional | EDU Arquiteto | @edu-arquiteto | EDU-ARQUITETO.md |
| CONTEUDISTA.md | Conteudista | EDU Conteudista | @edu-conteudo | EDU-CONTEUDISTA.md |
| ESPECIALISTA-AVALIACAO.md | Especialista em Avaliacao | EDU Avaliador | @edu-avaliacao | EDU-AVALIADOR.md |

### BRANDING

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| BRAND-STRATEGIST.md | Brand Strategist | BRAND Estrategista | @brand-estrategia | BRAND-ESTRATEGISTA.md |
| DESIGN-ANALYST.md | Design Analyst | BRAND Analista | @brand-analista | BRAND-ANALISTA.md |
| DESIGNER.md | Designer Visual | BRAND Designer | @brand-designer | BRAND-DESIGNER.md |
| UI-UX.md | UI/UX Specialist | BRAND UX | @brand-ux | BRAND-UX.md |

### CUSTOMER SUCCESS

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| CSM-ESTRATEGISTA.md | CSM Estrategista | CS Estrategista | @cs-estrategia | CS-ESTRATEGISTA.md |
| ONBOARDING-SPECIALIST.md | Onboarding Specialist | CS Onboarding | @cs-onboarding | CS-ONBOARDING.md |
| RETENTION-EXPERT.md | Retention Expert | CS Retencao | @cs-retencao | CS-RETENCAO.md |
| CRITICAL-CASES.md | Critical Cases | CS Criticos | @cs-criticos | CS-CRITICOS.md |

### PRODUTOS

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| PRODUCT-STRATEGIST.md | Product Strategist | PROD Estrategista | @prod-estrategia | PROD-ESTRATEGISTA.md |
| DISCOVERY-LEAD.md | Discovery Lead | PROD Discovery | @prod-discovery | PROD-DISCOVERY.md |
| DELIVERY-MANAGER.md | Delivery Manager | PROD Delivery | @prod-delivery | PROD-DELIVERY.md |

### JURIDICO

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| EMPRESARIAL.md | Advogado Empresarial | LEGAL Empresarial | @legal-empresarial | LEGAL-EMPRESARIAL.md |
| CONTRATOS.md | Especialista Contratos | LEGAL Contratos | @legal-contratos | LEGAL-CONTRATOS.md |
| COMPLIANCE.md | Especialista Compliance | LEGAL Compliance | @legal-compliance | LEGAL-COMPLIANCE.md |

### CRIMINAL

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| CRIMINALISTA.md | Criminalista | CRIM Defesa | @crim-defesa | CRIM-DEFESA.md |
| EXECUCAO.md | Especialista Execucao | CRIM Execucao | @crim-execucao | CRIM-EXECUCAO.md |
| JURI.md | Especialista Juri | CRIM Juri | @crim-juri | CRIM-JURI.md |
| RECURSOS.md | Especialista Recursos | CRIM Recursos | @crim-recursos | CRIM-RECURSOS.md |

### DADOS

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| ANALISTA-DADOS.md | Analista de Dados | DATA Analista | @data-analista | DATA-ANALISTA.md |
| CIENTISTA-DADOS.md | Cientista de Dados | DATA Cientista | @data-cientista | DATA-CIENTISTA.md |
| PESQUISADOR-MERCADO.md | Pesquisador Mercado | DATA Pesquisador | @data-pesquisador | DATA-PESQUISADOR.md |

### TI

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| ANALISTA-PROCESSOS.md | Analista de Processos | TI Processos | @ti-processos | TI-PROCESSOS.md |
| ESPECIALISTA-INTEGRACOES.md | Especialista Integracoes | TI Integracoes | @ti-integracoes | TI-INTEGRACOES.md |
| ENGENHEIRO-AUTOMACAO.md | Engenheiro Automacao | TI Automacao | @ti-automacao | TI-AUTOMACAO.md |

### SECRETARIA

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| ORGANIZADOR-DEMANDAS.md | Organizador Demandas | SEC Demandas | @sec-demandas | SEC-DEMANDAS.md |
| ESTRATEGISTA-PRIORIDADES.md | Estrategista Prioridades | SEC Prioridades | @sec-prioridades | SEC-PRIORIDADES.md |
| COORDENADOR-WORKFLOWS.md | Coordenador Workflows | SEC Coordenador | @sec-coordenador | SEC-COORDENADOR.md |

### DEPLOY

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| deploy-engineer.md | Deploy Engineer | DEPLOY Engineer | @deploy-engineer | DEPLOY-ENGINEER.md |
| dns-specialist.md | DNS Specialist | DEPLOY DNS | @deploy-dns | DEPLOY-DNS.md |
| qa-validator.md | QA Validator | DEPLOY QA | @deploy-qa | DEPLOY-QA.md |

### CRIADOR (Meta-Extensao)

| Arquivo Atual | Nome Atual | Novo Nome | Novo Comando | Novo Arquivo |
|---------------|------------|-----------|--------------|--------------|
| ARQUITETO-EXTENSOES.md | Arquiteto de Extensoes | META Extensoes | @meta-extensoes | META-EXTENSOES.md |
| DESIGNER-AGENTES.md | Designer de Agentes | META Agentes | @meta-agentes | META-AGENTES.md |
| CRIADOR-WORKFLOWS.md | Criador de Workflows | META Workflows | @meta-workflows | META-WORKFLOWS.md |

---

## Beneficios da Nova Nomenclatura

### 1. Descoberta Facil via @

Quando o usuario digita `@mkt`, ve todos os agentes de marketing:
- @mkt-copy
- @mkt-estrategia
- @mkt-trafego

Quando digita `@edu`, ve todos os agentes educacionais:
- @edu-arquiteto
- @edu-conteudo
- @edu-avaliacao

### 2. Elimina Ambiguidades

**Antes:**
- "Estrategista" podia ser Marketing, Produtos ou Secretaria
- "Designer" podia ser Branding ou Criador

**Depois:**
- @mkt-estrategia (Marketing)
- @prod-estrategia (Produtos)
- @sec-prioridades (Secretaria)
- @brand-designer (Branding)
- @meta-agentes (Criador)

### 3. Hierarquia Clara

Os prefixos criam grupos logicos que o usuario aprende rapidamente:
- `mkt-*` = Vender
- `edu-*` = Ensinar
- `brand-*` = Identidade visual
- `cs-*` = Reter clientes
- `prod-*` = Desenvolver produtos

---

## Arquivos a Atualizar por Extensao

### Para cada agente renomeado:

1. **Renomear arquivo** de `NOME-ANTIGO.md` para `PREFIXO-FUNCAO.md`
2. **Atualizar conteudo** do arquivo:
   - Titulo/Nome do agente
   - Comando de ativacao
   - Referencias internas
3. **Atualizar extensao.yaml** com novos comandos
4. **Atualizar delegacao.yaml** com novos nomes

---

## Ordem de Execucao

1. Marketing (3 agentes)
2. Educacional (3 agentes)
3. Branding (4 agentes)
4. Customer Success (4 agentes)
5. Produtos (3 agentes)
6. Juridico (3 agentes)
7. Criminal (4 agentes)
8. Dados (3 agentes)
9. TI (3 agentes)
10. Secretaria (3 agentes)
11. Deploy (3 agentes)
12. Criador (3 agentes)

**Total: 39 agentes a renomear**

---

## Checklist de Execucao

- [ ] Marketing - 3 agentes
- [ ] Educacional - 3 agentes
- [ ] Branding - 4 agentes
- [ ] Customer Success - 4 agentes
- [ ] Produtos - 3 agentes
- [ ] Juridico - 3 agentes
- [ ] Criminal - 4 agentes
- [ ] Dados - 3 agentes
- [ ] TI - 3 agentes
- [ ] Secretaria - 3 agentes
- [ ] Deploy - 3 agentes
- [ ] Criador - 3 agentes
- [ ] Atualizar extensao.yaml de cada extensao
- [ ] Atualizar delegacao.yaml de cada extensao
- [ ] Testar descoberta via @
