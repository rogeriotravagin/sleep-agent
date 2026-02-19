# Mapa de Infraestrutura

**Atualizado em:** {{DATA}}
**Responsavel:** {{RESPONSAVEL}}

---

## Visao Geral

```
Cloud Provider: {{PROVIDER}}
Servidor(es): {{N_SERVIDORES}}
Stacks: {{N_STACKS}}
Services: {{N_SERVICES}}
Custo Mensal: {{CUSTO_TOTAL}}
```

---

## Servidores

### {{SERVIDOR_NOME}}

| Item | Valor |
|------|-------|
| Provider | Hetzner Cloud |
| Tipo | {{SERVER_TYPE}} |
| vCPU | {{VCPU}} |
| RAM | {{RAM}} |
| Disco | {{DISCO}} |
| IP Publico | {{IP}} |
| Datacenter | {{DATACENTER}} |
| OS | {{OS}} |
| Custo | {{CUSTO}}/mes |
| Criado em | {{DATA_CRIACAO}} |

**Acesso:**
- SSH: `ssh {{USER}}@{{IP}} -p {{SSH_PORT}}`
- Portainer: Endpoint "{{ENDPOINT_NAME}}"

**Firewall:**
| Porta | Protocolo | Origem | Descricao |
|-------|-----------|--------|-----------|
| {{SSH_PORT}} | TCP | IP autorizado | SSH |
| 80 | TCP | Todos | HTTP |
| 443 | TCP | Todos | HTTPS |

---

## Docker Swarm

| Item | Valor |
|------|-------|
| Status | Ativo/Inativo |
| Nodes | {{N_NODES}} |
| Managers | {{N_MANAGERS}} |
| Workers | {{N_WORKERS}} |

### Networks
| Nome | Driver | Scope | Uso |
|------|--------|-------|-----|
| public | overlay | swarm | Servicos com acesso web |
| {{NETWORK}} | overlay | swarm | {{USO}} |

---

## Stacks e Services

### Stack: {{STACK_NOME}}

| Service | Imagem | Replicas | Porta | Dominio | Health |
|---------|--------|----------|-------|---------|--------|
| | | | | | |

**Volumes:**
| Volume | Mount | Backup |
|--------|-------|--------|
| | | |

**Variaveis de Ambiente:**
| Variavel | Descricao | Sensivel |
|----------|-----------|----------|
| | | Sim/Nao |

---

## DNS

| Dominio | Tipo | Valor | TTL | Provider |
|---------|------|-------|-----|----------|
| | A | {{IP}} | 300 | |
| | CNAME | | 300 | |

---

## Backup

| Recurso | Tipo | Frequencia | Retencao | Ultimo |
|---------|------|------------|----------|--------|
| Servidor | Snapshot | | | |
| Volumes | tar.gz | | | |
| Stacks | YAML export | | | |

---

## Monitoramento

| Item | Status | URL/Metodo |
|------|--------|------------|
| Uptime | | |
| SSL | | |
| Recursos | | |

---

## Custos Mensais

| Recurso | Custo |
|---------|-------|
| Servidor(es) | {{CUSTO_SERVIDOR}} |
| Backups | {{CUSTO_BACKUP}} |
| Volumes extra | {{CUSTO_VOLUMES}} |
| Trafego | {{CUSTO_TRAFEGO}} |
| **Total** | **{{CUSTO_TOTAL}}** |

---

*Gerado pelo Sleep Agent - Time de DevOps*
