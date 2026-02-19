# SSH Hardening Checklist

**Servidor:** {{SERVIDOR}}
**Data:** {{DATA}}
**Executado por:** Sleep Agent - DevOps Seguranca

---

## Pre-Requisitos

- [ ] SSH key publica disponivel
- [ ] Acesso root atual ao servidor
- [ ] IP atual anotado para whitelist

---

## Checklist de Hardening

### 1. Usuario Nao-Root
- [ ] Criar usuario `deploy`
- [ ] Copiar authorized_keys para novo usuario
- [ ] Adicionar ao grupo sudo
- [ ] Configurar NOPASSWD para sudo
- [ ] Testar login com novo usuario

### 2. Configuracao SSH
- [ ] Alterar porta para {{SSH_PORT:-2222}}
- [ ] PermitRootLogin: **no**
- [ ] PasswordAuthentication: **no**
- [ ] PubkeyAuthentication: **yes**
- [ ] MaxAuthTries: **3**
- [ ] LoginGraceTime: **30**
- [ ] AllowUsers: **deploy**
- [ ] ClientAliveInterval: **300**
- [ ] ClientAliveCountMax: **2**
- [ ] X11Forwarding: **no**
- [ ] AllowTcpForwarding: **no**
- [ ] AllowAgentForwarding: **no**

### 3. Algoritmos Seguros
- [ ] KexAlgorithms: curve25519-sha256@libssh.org
- [ ] Ciphers: chacha20-poly1305@openssh.com, aes256-gcm@openssh.com
- [ ] MACs: hmac-sha2-512-etm@openssh.com, hmac-sha2-256-etm@openssh.com

### 4. Teste (CRITICO)
- [ ] Testar conexao SSH com novo usuario **ANTES** de fechar sessao atual
- [ ] Confirmar que sudo funciona
- [ ] Confirmar que root nao consegue logar
- [ ] Confirmar que senha nao e aceita

### 5. Firewall
- [ ] SSH (porta customizada) restrito por IP no UFW
- [ ] SSH (porta customizada) restrito por IP no Cloud Firewall

### 6. Fail2ban
- [ ] Instalado e ativo
- [ ] Configurado para porta SSH customizada
- [ ] maxretry: 3
- [ ] bantime: 7200
- [ ] Jail sshd-ddos habilitado

---

## Pos-Hardening

- [ ] Reiniciar sshd
- [ ] Testar acesso novamente
- [ ] Documentar porta e IP autorizado
- [ ] Atualizar inventario

---

## Notas
```
{{NOTAS}}
```

---

*Gerado pelo Sleep Agent - Time de DevOps*
