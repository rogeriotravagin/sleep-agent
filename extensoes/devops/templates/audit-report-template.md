# Relatorio de Auditoria de Seguranca

**Data:** {{DATA}}
**Auditor:** Sleep Agent - DevOps Seguranca
**Escopo:** {{ESCOPO}}

---

## Score Geral: {{SCORE}}/100

| Nivel | Quantidade | Status |
|-------|-----------|--------|
| CRITICO | {{N_CRITICO}} | Corrigir IMEDIATAMENTE |
| ALTO | {{N_ALTO}} | Corrigir em 24h |
| MEDIO | {{N_MEDIO}} | Corrigir em 1 semana |
| BAIXO | {{N_BAIXO}} | Planejar correcao |

---

## 1. Acesso e Autenticacao

| Verificacao | Status | Risco | Observacao |
|-------------|--------|-------|------------|
| Root login via SSH | | | |
| Autenticacao por senha | | | |
| SSH keys autorizadas | | | |
| Porta SSH customizada | | | |
| Fail2ban ativo | | | |
| MaxAuthTries | | | |
| Usuarios ativos revisados | | | |

---

## 2. Firewall

| Verificacao | Status | Risco | Observacao |
|-------------|--------|-------|------------|
| Default deny incoming | | | |
| Portas necessarias abertas | | | |
| SSH restrito por IP | | | |
| Cloud Firewall ativo | | | |
| UFW/iptables sincronizado | | | |
| Docker Swarm apenas interno | | | |

---

## 3. SSL/TLS

| Dominio | Valido | Expira Em | TLS Version | HSTS |
|---------|--------|-----------|-------------|------|
| | | | | |

---

## 4. Docker/Containers

| Stack | Health Check | Limits | Tag Fixa | Network Isolada |
|-------|-------------|--------|----------|-----------------|
| | | | | |

---

## 5. Backup

| Recurso | Tipo Backup | Frequencia | Ultimo Backup | Restore Testado |
|---------|------------|------------|---------------|-----------------|
| Servidor | | | | |
| Volumes | | | | |
| Stacks | | | | |

---

## 6. Monitoramento

| Item | Status | Observacao |
|------|--------|------------|
| Logs centralizados | | |
| Alertas configurados | | |
| Metricas de recursos | | |
| Uptime monitoring | | |
| Audit log ativo | | |

---

## Plano de Acao

| # | Prioridade | Acao | Responsavel | Prazo | Status |
|---|-----------|------|-------------|-------|--------|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |

---

## Proxima Auditoria

**Data recomendada:** {{PROXIMA_AUDITORIA}}
**Frequencia sugerida:** Mensal para CRITICO/ALTO, Trimestral para completa

---

*Gerado pelo Sleep Agent - Time de DevOps*
