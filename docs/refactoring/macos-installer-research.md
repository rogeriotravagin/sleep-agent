# Pesquisa Profunda: Criação de Instaladores para macOS

**Objetivo:** Criar um instalador equivalente ao instalador Windows (Inno Setup) que instala automaticamente Node.js, Git, VS Code, Claude Code CLI, extensão VS Code, copia arquivos e configura o sistema.

**Data da Pesquisa:** 01/02/2026

---

## Índice

1. [Formatos de Instaladores macOS](#1-formatos-de-instaladores-macos)
2. [Ferramentas para Criar Instaladores](#2-ferramentas-para-criar-instaladores)
3. [Instalação de Dependências no macOS](#3-instalação-de-dependências-no-macos)
4. [Estrutura de Diretórios macOS](#4-estrutura-de-diretórios-macos)
5. [Scripts de Instalação](#5-scripts-de-instalação)
6. [Interface do Usuário](#6-interface-do-usuário)
7. [Distribuição](#7-distribuição)
8. [Best Practices](#8-best-practices)
9. [Recomendações Finais](#9-recomendações-finais)

---

## 1. Formatos de Instaladores macOS

### 1.1 PKG (Package Installer)

**O que é:**
- Formato oficial de instalação da Apple
- Arquivo comprimido no formato Xar, que pode ser assinado digitalmente
- Contém payload (estrutura de arquivos), scripts de instalação e recursos

**Vantagens:**
- ✅ **Ideal para instalações complexas** que precisam colocar arquivos em múltiplos diretórios (/Applications, ~/Library, /Library, etc.)
- ✅ **Suporta scripts** pre-install e post-install para automação
- ✅ **Pode ser executado via linha de comando** (`sudo installer -pkg`)
- ✅ **Perfeito para distribuição enterprise** via MDM (Mobile Device Management)
- ✅ **Interface wizard nativa** do macOS (equivalente ao Inno Setup)
- ✅ **Seleção de componentes** durante instalação
- ✅ **Verificação de proveniência** via assinatura digital

**Desvantagens:**
- ❌ Requer conhecimento técnico para criar
- ❌ Usuários menos técnicos podem ter receio de instaladores .pkg
- ❌ Processo de instalação mais formal

**Quando usar:**
- Instalação que requer arquivos em múltiplos diretórios do sistema
- Necessita de scripts de configuração pós-instalação
- Distribuição enterprise/corporativa
- Instalação de dependências do sistema
- **✨ Recomendado para o Sleep Agent** (equivalente ao Inno Setup do Windows)

### 1.2 DMG (Disk Image)

**O que é:**
- Reconstrução digital de um disco físico
- Arquivo montável que contém múltiplos arquivos e pastas
- Pode conter um .app bundle ou um .pkg dentro

**Vantagens:**
- ✅ **Experiência drag-and-drop** familiar aos usuários Mac
- ✅ **Visual atraente** com background customizado e ícones
- ✅ **Ideal para apps simples** que são autocontidos
- ✅ **Não requer senha de administrador** (para apps simples)
- ✅ **Percepção de segurança** pelos usuários

**Desvantagens:**
- ❌ **Não define comportamento de atualização** (sobrescrever? coexistir?)
- ❌ **Não suporta instalação em múltiplos diretórios** nativamente
- ❌ **Não é ideal para enterprise deployment**
- ❌ **Requer ação manual do usuário** (arrastar para Applications)
- ❌ **Não executa scripts automaticamente**

**Quando usar:**
- Apps simples e autocontidos (um único .app bundle)
- Distribuição direta ao consumidor final
- Quando a experiência drag-and-drop é desejada
- Apps que não precisam de configuração do sistema

### 1.3 App Bundle (.app)

**O que é:**
- Estrutura de diretório padronizada para aplicações macOS
- Parece um único arquivo no Finder, mas é uma pasta estruturada
- Contém executável, recursos, frameworks, etc.

**Estrutura:**
```
MyApp.app/
├── Contents/
│   ├── MacOS/           # Executável
│   ├── Resources/       # Ícones, imagens, etc.
│   ├── Frameworks/      # Libraries
│   ├── Info.plist       # Metadados da aplicação
│   └── PkgInfo          # Tipo de arquivo
```

**Vantagens:**
- ✅ **Padrão do macOS** reconhecido pelo sistema
- ✅ **Auto-contido** (teoricamente tudo que precisa está dentro)
- ✅ **Fácil de distribuir** (arrasta e solta)

**Desvantagens:**
- ❌ **Não é um instalador** - é o formato da aplicação em si
- ❌ **Precisa ser distribuído via DMG ou PKG**

**Quando usar:**
- Sempre que criar uma aplicação nativa macOS
- Geralmente distribuído dentro de DMG ou PKG

### 1.4 Comparação e Recomendação

| Aspecto | PKG | DMG | App Bundle |
|---------|-----|-----|------------|
| **Complexidade de instalação** | Alta ✅ | Baixa | N/A |
| **Scripts de instalação** | Sim ✅ | Não | N/A |
| **Múltiplos diretórios** | Sim ✅ | Não | Não |
| **Interface wizard** | Sim ✅ | Não | N/A |
| **Linha de comando** | Sim ✅ | Não | N/A |
| **Enterprise deployment** | Sim ✅ | Não | Não |
| **Experiência do usuário** | Formal | Casual ✅ | N/A |
| **Customização visual** | Limitada | Alta ✅ | N/A |

### 1.5 Abordagem Híbrida (Recomendada)

**PKG dentro de DMG:**
- Criar um PKG que faz toda a instalação complexa
- Colocar o PKG dentro de um DMG com visual bonito
- Adicionar README, ícones, background customizado no DMG
- Combina poder do PKG com apresentação visual do DMG

**✨ Para o Sleep Agent:**
```
SleepAgent-v1.0.dmg
├── SleepAgent-Installer.pkg     # Instalador real
├── README.html                   # Instruções
├── .background/                  # Imagem de fundo
└── .VolumeIcon.icns             # Ícone do volume
```

---

## 2. Ferramentas para Criar Instaladores

### 2.1 pkgbuild e productbuild (Nativo - Linha de Comando)

**O que são:**
- **pkgbuild**: Cria pacotes de componentes (.pkg) individuais
- **productbuild**: Combina pacotes em um produto final, com customização via XML

**Vantagens:**
- ✅ **Nativo do macOS** - já vem instalado
- ✅ **Gratuito** e oficialmente suportado pela Apple
- ✅ **Estável** e confiável
- ✅ **Suporte completo** a assinatura e notarização
- ✅ **Ideal para CI/CD** e automação

**Desvantagens:**
- ❌ **Linha de comando** - curva de aprendizado
- ❌ Requer conhecimento de XML para customização
- ❌ Sem interface gráfica

**Processo básico:**
```bash
# 1. Criar pacote de componente
pkgbuild --root ./payload \
         --identifier com.sleepagent.app \
         --version 1.0 \
         --install-location / \
         --scripts ./scripts \
         component.pkg

# 2. Criar arquivo de distribuição (distribution.xml)
productbuild --synthesize --package component.pkg distribution.xml

# 3. Customizar distribution.xml (título, background, etc.)

# 4. Criar produto final
productbuild --distribution distribution.xml \
             --resources ./resources \
             --package-path . \
             SleepAgent-Installer.pkg

# 5. Assinar
productsign --sign "Developer ID Installer: Your Name" \
            SleepAgent-Installer.pkg \
            SleepAgent-Installer-Signed.pkg

# 6. Notarizar
xcrun notarytool submit SleepAgent-Installer-Signed.pkg \
                        --keychain-profile "AC_PASSWORD" \
                        --wait

# 7. Staple
xcrun stapler staple SleepAgent-Installer-Signed.pkg
```

**Tutorial Recomendado:**
- [How to make macOS installers for JUCE with pkgbuild and productbuild](https://moonbase.sh/articles/how-to-make-macos-installers-for-juce-projects-with-pkgbuild-and-productbuild/)

### 2.2 Package Builder (GUI - Comercial)

**O que é:**
- Ferramenta GUI para criar instaladores .pkg sem linha de comando
- Desenvolvida pela Araelium
- Atualizada em Janeiro/2026

**Vantagens:**
- ✅ **Interface gráfica intuitiva** - drag-and-drop
- ✅ **Customização visual** fácil (backgrounds light/dark mode)
- ✅ **Suporte a code signing** e notarização integrado
- ✅ **Integração com DMG Canvas** para criar DMGs
- ✅ **Preview** do instalador antes de compilar

**Desvantagens:**
- ❌ **Pago** (valor não especificado na pesquisa)
- ❌ Menos ideal para automação/CI/CD

**Quando usar:**
- Preferência por interface gráfica
- Prototipagem rápida
- Equipe sem experiência em linha de comando

**Links:**
- [Package Builder Official Site](https://www.araelium.com/packagebuilder)
- [How to Make a Mac Installer Package Fast](https://www.araelium.com/packagebuilder/how-to-make-mac-installer-package)

### 2.3 Packages (GUI - Gratuito)

**O que é:**
- Ferramenta GUI gratuita (freeware) para criar instaladores
- Uma das mais populares entre desenvolvedores macOS
- Versão atual: 1.2.9

**Vantagens:**
- ✅ **Gratuito** (freeware)
- ✅ **Interface gráfica** amigável
- ✅ **Amplamente usado** e testado
- ✅ **Suporte completo** a recursos avançados

**Desvantagens:**
- ❌ Interface mais antiga/datada
- ❌ Menos polido que Package Builder

**Quando usar:**
- Orçamento limitado
- Necessidade de GUI sem custo
- Projeto open-source ou pessoal

**Links:**
- [Using Packages to create an installer for distributing macOS apps](https://www.appcoda.com/packages-macos-apps-distribution/)

### 2.4 create-dmg (Linha de Comando)

**O que é:**
- Script shell para criar DMGs com customização visual
- Duas versões populares no GitHub

**Versões:**

**1. create-dmg/create-dmg:**
- Shell script puro
- Funciona em OS X 10.6+
- Requer apenas macOS padrão

**2. sindresorhus/create-dmg:**
- Ferramenta Node.js
- Requer Node.js 20+
- Mais moderna e automatizada

**Recursos:**
- ✅ Background customizado
- ✅ Posicionamento de ícones
- ✅ Tamanho e posição da janela
- ✅ Ícone do volume
- ✅ Suporte APFS (macOS 10.13+)
- ✅ Criptografia (AES-256/128)
- ✅ Code signing

**Instalação (versão sindresorhus):**
```bash
npm install --global create-dmg
```

**Uso básico:**
```bash
create-dmg SleepAgent.app
# Gera: Sleep Agent 1.0.0.dmg
```

**Links:**
- [create-dmg/create-dmg GitHub](https://github.com/create-dmg/create-dmg)
- [sindresorhus/create-dmg GitHub](https://github.com/sindresorhus/create-dmg)

### 2.5 DMG Canvas (GUI - Comercial)

**O que é:**
- Ferramenta profissional para criar DMGs com layouts customizados
- Interface visual drag-and-drop
- Suporte a branding e code signing

**Vantagens:**
- ✅ **WYSIWYG editor** - vê exatamente como ficará
- ✅ **Templates profissionais**
- ✅ **Automação** via linha de comando
- ✅ **Code signing** integrado

**Desvantagens:**
- ❌ **Pago**

**Links:**
- [DMG Canvas GitHub](https://github.com/DMG-Canvas-Mac/dmg-canvas-osx)

### 2.6 DropDMG (Comercial)

**O que é:**
- Ferramenta da C-Command para criar DMGs profissionais
- Última versão: 3.7.1 (Novembro/2025)

**Vantagens:**
- ✅ **Layouts customizados**
- ✅ **Integração com Finder**
- ✅ **Automação**

**Links:**
- [DropDMG Official Site](https://c-command.com/dropdmg/)

### 2.7 macos-pkg-builder (Python)

**O que é:**
- Módulo Python para criar pacotes macOS
- Wrapper para pkgbuild/productbuild
- Foco em CI/CD

**Instalação:**
```bash
pip install macos-pkg-builder
```

**Vantagens:**
- ✅ **Integração Python**
- ✅ **Ideal para CI/CD**
- ✅ **Abstração dos comandos nativos**

**Links:**
- [macos-pkg-builder PyPI](https://pypi.org/project/macos-pkg-builder/)

### 2.8 Homebrew (Alternativa)

**O que é:**
- Gerenciador de pacotes para macOS
- Distribuição via "cask" (fórmula)
- Usuário instala via `brew install --cask sleepagent`

**Vantagens:**
- ✅ **Familiar** para desenvolvedores
- ✅ **Atualização automática** via brew
- ✅ **Instalação silenciosa** nativa
- ✅ **Desinstalação fácil**

**Desvantagens:**
- ❌ Requer Homebrew instalado
- ❌ Processo de submissão ao repositório
- ❌ Menos controle sobre instalação

**Quando usar:**
- Distribuição para desenvolvedores
- Como alternativa ao instalador tradicional
- Apps de linha de comando

### 2.9 Comparação de Ferramentas

| Ferramenta | Tipo | Custo | Curva de Aprendizado | CI/CD | Recomendado para |
|------------|------|-------|---------------------|-------|------------------|
| **pkgbuild/productbuild** | CLI | Grátis | Média | ✅✅✅ | Automação, profissionais |
| **Package Builder** | GUI | Pago | Baixa | ❌ | Prototipagem, iniciantes |
| **Packages** | GUI | Grátis | Baixa | ❌ | Orçamento limitado |
| **create-dmg** | CLI | Grátis | Baixa | ✅✅ | DMGs automatizados |
| **DMG Canvas** | GUI | Pago | Baixa | ✅ | DMGs profissionais |
| **macos-pkg-builder** | Python | Grátis | Média | ✅✅✅ | Projetos Python |
| **Homebrew Cask** | CLI | Grátis | Baixa | ✅✅ | Desenvolvedores |

### 2.10 Recomendação para Sleep Agent

**Abordagem Recomendada:**

1. **Instalador PKG** (pkgbuild/productbuild):
   - Instalação de dependências
   - Scripts de configuração
   - Cópia de arquivos

2. **DMG Container** (create-dmg):
   - Visual profissional
   - README incluído
   - PKG dentro

3. **Homebrew Cask** (opcional):
   - Como alternativa para desenvolvedores
   - `brew install --cask sleepagent`

**Justificativa:**
- PKG é necessário para instalação complexa (equivalente ao Inno Setup)
- DMG melhora apresentação visual
- Homebrew oferece canal alternativo familiar

---

## 3. Instalação de Dependências no macOS

### 3.1 Visão Geral

No Windows, o Inno Setup pode executar instaladores .exe silenciosamente. No macOS, a abordagem é diferente:

**Duas estratégias principais:**
1. **Homebrew** (recomendado)
2. **Instaladores diretos** (.pkg oficiais)

### 3.2 Instalação via Homebrew (Recomendado)

**Por que Homebrew:**
- ✅ **Padrão de facto** para gerenciamento de pacotes no macOS
- ✅ **Instalação silenciosa** nativa
- ✅ **Gerenciamento de versões**
- ✅ **Atualizações fáceis** (`brew upgrade`)
- ✅ **Desinstalação limpa** (`brew uninstall`)
- ✅ **Amplamente confiável** pela comunidade

**Instalação do Homebrew:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Instalação não-interativa (para scripts):**
```bash
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Localizações de instalação:**
- **Apple Silicon (M1/M2/M3):** `/opt/homebrew`
- **Intel:** `/usr/local`

**Requisitos de sistema:**
- **Melhor suporte:** macOS 14 (Sonoma) ou superior
- **Não suportado mas pode funcionar:** macOS 10.15 (Catalina) - 13 (Ventura)

### 3.3 Instalando Node.js

**Via Homebrew (Recomendado):**
```bash
# Instalar Node.js (inclui npm)
brew install node

# Verificar instalação
node --version
npm --version
```

**Via Instalador Oficial (.pkg):**
```bash
# 1. Download
curl -O https://nodejs.org/dist/v20.11.0/node-v20.11.0.pkg

# 2. Instalar silenciosamente
sudo installer -pkg node-v20.11.0.pkg -target /
```

**Vantagens Homebrew:**
- ✅ Gerenciamento de versões mais fácil
- ✅ Atualização via `brew upgrade node`
- ✅ Não polui o sistema

**Vantagens Instalador Oficial:**
- ✅ Não requer Homebrew
- ✅ Instalação "oficial"

### 3.4 Instalando Git

**Via Homebrew:**
```bash
brew install git
```

**Via Xcode Command Line Tools:**
```bash
xcode-select --install
```

**Nota:** Git já vem com Xcode Command Line Tools, que muitos desenvolvedores já têm instalado.

**Recomendação:** Verificar se Git já está instalado antes de instalar:
```bash
if ! command -v git &> /dev/null; then
    brew install git
fi
```

### 3.5 Instalando VS Code

**Via Homebrew Cask (Recomendado):**
```bash
brew install --cask visual-studio-code
```

**Via Instalador Oficial (.zip):**
```bash
# 1. Download
curl -L https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal -o vscode.zip

# 2. Extrair
unzip vscode.zip -d /Applications/

# 3. Limpar
rm vscode.zip
```

**Vantagens Homebrew Cask:**
- ✅ **Instalação silenciosa** completa
- ✅ **Atualização via Homebrew**
- ✅ **Comando `code` no PATH** automaticamente

**Instalação de extensão VS Code:**
```bash
# Depois que VS Code estiver instalado
code --install-extension anthropics.claude-code
```

### 3.6 Instalando Claude Code CLI

**Via npm (após Node.js instalado):**
```bash
npm install -g @anthropic-ai/claude-code
```

**Verificação:**
```bash
claude-code --version
```

### 3.7 Script Completo de Instalação de Dependências

```bash
#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🚀 Sleep Agent - Instalação de Dependências"
echo "============================================="
echo ""

# Função para verificar se comando existe
command_exists() {
    command -v "$1" &> /dev/null
}

# 1. Instalar Homebrew se não existir
echo "📦 Verificando Homebrew..."
if ! command_exists brew; then
    echo "${YELLOW}Homebrew não encontrado. Instalando...${NC}"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Adicionar ao PATH
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "${GREEN}✓ Homebrew instalado${NC}"
else
    echo "${GREEN}✓ Homebrew já instalado${NC}"
fi

# 2. Instalar Git
echo ""
echo "📝 Verificando Git..."
if ! command_exists git; then
    echo "${YELLOW}Git não encontrado. Instalando...${NC}"
    brew install git
    echo "${GREEN}✓ Git instalado${NC}"
else
    echo "${GREEN}✓ Git já instalado ($(git --version))${NC}"
fi

# 3. Instalar Node.js
echo ""
echo "⚡ Verificando Node.js..."
if ! command_exists node; then
    echo "${YELLOW}Node.js não encontrado. Instalando...${NC}"
    brew install node
    echo "${GREEN}✓ Node.js instalado${NC}"
else
    echo "${GREEN}✓ Node.js já instalado ($(node --version))${NC}"
fi

# 4. Instalar VS Code
echo ""
echo "💻 Verificando VS Code..."
if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    echo "${YELLOW}VS Code não encontrado. Instalando...${NC}"
    brew install --cask visual-studio-code
    echo "${GREEN}✓ VS Code instalado${NC}"
else
    echo "${GREEN}✓ VS Code já instalado${NC}"
fi

# 5. Instalar Claude Code CLI
echo ""
echo "🤖 Verificando Claude Code CLI..."
if ! command_exists claude-code; then
    echo "${YELLOW}Claude Code CLI não encontrado. Instalando...${NC}"
    npm install -g @anthropic-ai/claude-code
    echo "${GREEN}✓ Claude Code CLI instalado${NC}"
else
    echo "${GREEN}✓ Claude Code CLI já instalado ($(claude-code --version))${NC}"
fi

# 6. Instalar extensão VS Code
echo ""
echo "🔌 Instalando extensão Claude Code no VS Code..."
code --install-extension anthropics.claude-code --force
echo "${GREEN}✓ Extensão instalada${NC}"

echo ""
echo "============================================="
echo "${GREEN}✅ Todas as dependências foram instaladas!${NC}"
echo ""
echo "Ferramentas instaladas:"
echo "  • Homebrew: $(brew --version | head -n 1)"
echo "  • Git: $(git --version)"
echo "  • Node.js: $(node --version)"
echo "  • npm: $(npm --version)"
echo "  • VS Code: instalado"
echo "  • Claude Code CLI: $(claude-code --version)"
echo ""
```

### 3.8 Instalação Silenciosa vs Interativa

**Homebrew - Modo Não-Interativo:**
```bash
# Define variável de ambiente
export NONINTERACTIVE=1

# Ou inline
NONINTERACTIVE=1 brew install node
```

**Instalador .pkg - Sempre Silencioso:**
```bash
sudo installer -pkg arquivo.pkg -target /
```

**npm - Sempre Silencioso:**
```bash
npm install -g pacote --silent
```

### 3.9 Tratamento de Erros

```bash
#!/bin/bash
set -e  # Parar em erro

install_dependency() {
    local name=$1
    local install_cmd=$2

    echo "Instalando $name..."
    if eval "$install_cmd"; then
        echo "✓ $name instalado com sucesso"
        return 0
    else
        echo "✗ Erro ao instalar $name"
        return 1
    fi
}

# Uso
install_dependency "Node.js" "brew install node" || {
    echo "Tentando método alternativo..."
    # Fallback
}
```

### 3.10 Homebrew vs Instaladores Diretos - Comparação

| Aspecto | Homebrew | Instaladores Diretos |
|---------|----------|---------------------|
| **Instalação** | Requer Homebrew primeiro | Direto |
| **Tamanho** | Downloads separados | Pode empacotar tudo |
| **Atualizações** | `brew upgrade` | Manual |
| **Desinstalação** | `brew uninstall` | Manual complexa |
| **Versões** | Fácil gerenciar | Complexo |
| **Confiança** | Alta (comunidade) | Alta (oficial) |
| **Velocidade** | Depende da internet | Pode ser offline |
| **Manutenção** | Homebrew cuida | Manual |

### 3.11 Recomendação para Sleep Agent

**Abordagem Híbrida:**

```bash
#!/bin/bash

# 1. Detectar se Homebrew está instalado
if command -v brew &> /dev/null; then
    echo "Usando Homebrew para instalação..."
    USE_HOMEBREW=true
else
    echo "Homebrew não encontrado."
    read -p "Deseja instalar Homebrew? (Recomendado) [S/n]: " choice
    case "$choice" in
        n|N ) USE_HOMEBREW=false;;
        * )
            # Instalar Homebrew
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            USE_HOMEBREW=true
            ;;
    esac
fi

# 2. Instalar dependências baseado na escolha
if [ "$USE_HOMEBREW" = true ]; then
    # Via Homebrew (recomendado)
    brew install git node
    brew install --cask visual-studio-code
else
    # Via instaladores diretos (fallback)
    # Usar .pkg files incluídos ou download
    sudo installer -pkg node.pkg -target /
    # etc...
fi
```

**Justificativa:**
- Oferece flexibilidade ao usuário
- Usa Homebrew quando disponível (melhor experiência)
- Fallback para instaladores diretos
- Máxima compatibilidade

---

## 4. Estrutura de Diretórios macOS

### 4.1 Visão Geral

O macOS tem uma estrutura de diretórios específica, diferente do Windows. Entender isso é crucial para instalação correta.

### 4.2 Diretórios Principais

#### /Applications
**Uso:** Aplicações visíveis ao usuário
**Permissões:** Requer admin para instalar
**Instalação:** Apps principais (.app bundles)

```bash
/Applications/
├── SleepAgent.app/          # App principal (se houver)
├── Visual Studio Code.app/
└── ...
```

#### ~/Applications
**Uso:** Aplicações do usuário individual
**Permissões:** Não requer admin
**Instalação:** Apps pessoais

**Quando usar:** Apps que não precisam de privilégios de sistema

#### /Library
**Uso:** Recursos compartilhados por todos os usuários
**Permissões:** Requer admin
**Protegido:** Não protegido pelo SIP

```bash
/Library/
├── Application Support/     # Arquivos de suporte de apps
├── Caches/                  # Cache do sistema
├── Preferences/             # Preferências globais
├── LaunchDaemons/           # Daemons do sistema
├── LaunchAgents/            # Agents do sistema
└── Frameworks/              # Frameworks compartilhados
```

#### ~/Library
**Uso:** Recursos do usuário individual
**Permissões:** Usuário tem controle total
**Visibilidade:** Oculto por padrão no Finder

```bash
~/Library/
├── Application Support/     # Dados de apps do usuário
│   └── SleepAgent/          # ← Configurações do Sleep Agent
├── Caches/                  # Cache de apps do usuário
├── Preferences/             # Preferências do usuário
│   └── com.sleepagent.plist
├── LaunchAgents/            # Agents do usuário
└── Logs/                    # Logs de apps
```

#### /System
**Uso:** Sistema operacional
**Permissões:** Read-only
**Protegido:** System Integrity Protection (SIP)

**⚠️ NUNCA INSTALAR AQUI** - Protegido pelo SIP desde OS X El Capitan

#### /usr
**Uso:** Utilitários Unix
**Permissões:** Protegido pelo SIP (parcialmente)
**Instalação:** Homebrew usa /usr/local (Intel)

```bash
/usr/
├── bin/                     # Binários (protegido)
├── sbin/                    # System binaries (protegido)
└── local/                   # Homebrew Intel (não protegido)
    ├── bin/
    ├── lib/
    └── Cellar/
```

#### /opt
**Uso:** Software opcional
**Permissões:** Não protegido pelo SIP
**Instalação:** Homebrew Apple Silicon

```bash
/opt/
└── homebrew/                # Homebrew Apple Silicon
    ├── bin/
    ├── lib/
    └── Cellar/
```

#### ~/ (Home do usuário)
**Uso:** Arquivos pessoais do usuário
**Permissões:** Controle total do usuário

```bash
~/
├── Documents/               # NÃO instalar apps aqui
├── Downloads/
├── Desktop/
├── .config/                 # Configurações estilo Linux
│   └── sleepagent/          # ← Possível localização
├── .claude/                 # ← Configuração global do Claude
│   └── CLAUDE.md
└── Library/                 # Dados de aplicações
```

### 4.3 System Integrity Protection (SIP)

**O que é:**
- Proteção introduzida no OS X El Capitan
- Protege diretórios do sistema de modificação
- Protege até mesmo usuário root

**Diretórios Protegidos:**
- `/System`
- `/usr` (exceto `/usr/local`)
- `/bin`
- `/sbin`
- Apps pré-instalados em `/Applications`

**Diretórios NÃO Protegidos:**
- `/Library`
- `/usr/local`
- `/opt`
- `~/` (home do usuário)
- `/Applications` (para apps novos)

**Implicação:** Você pode instalar em `/Library`, `/usr/local`, `/opt`, mas NÃO em `/System` ou `/usr/bin`

### 4.4 Estrutura Recomendada para Sleep Agent

```
# Arquivos da Aplicação
/Applications/SleepAgent.app/               # Se houver app GUI

# Arquivos de Suporte (Sistema)
/Library/Application Support/SleepAgent/
├── core/                                   # Core do sistema
├── frameworks/                             # Frameworks
├── extensoes/                              # Extensões instaladas
└── templates/                              # Templates

# Configurações Globais
/Library/Preferences/
└── com.sleepagent.plist                   # Configurações globais

# Configurações do Usuário
~/.claude/
└── CLAUDE.md                              # Configuração Claude global

~/.config/sleepagent/
└── config.yaml                            # Configurações do usuário

# Workspace do Usuário
~/SleepAgent/
└── workspace/                             # Área de trabalho
    ├── .config/
    └── [projetos]/

# Binários
/usr/local/bin/                            # Intel Homebrew
├── sleepagent                             # Symlink ou executável

/opt/homebrew/bin/                         # Apple Silicon Homebrew
├── sleepagent                             # Symlink ou executável

# Logs
~/Library/Logs/SleepAgent/
└── sleepagent.log
```

### 4.5 Permissões e Propriedade

**Entendendo Permissões:**
```bash
drwxr-xr-x  2 user  admin  64 Feb  1 10:00 folder
-rw-r--r--  1 user  admin  256 Feb  1 10:00 file.txt
```

**Estrutura:**
- `d` = diretório, `-` = arquivo
- `rwx` = read, write, execute (proprietário)
- `r-x` = read, execute (grupo)
- `r-x` = read, execute (outros)
- `user` = proprietário
- `admin` = grupo

**Permissões Recomendadas:**

```bash
# Executáveis
chmod 755 /usr/local/bin/sleepagent
# drwxr-xr-x = proprietário: tudo, outros: ler/executar

# Arquivos de configuração (sistema)
chmod 644 /Library/Application Support/SleepAgent/config.yaml
# -rw-r--r-- = proprietário: ler/escrever, outros: ler

# Arquivos de configuração (usuário)
chmod 600 ~/.claude/CLAUDE.md
# -rw------- = apenas proprietário: ler/escrever

# Diretórios
chmod 755 /Library/Application Support/SleepAgent/
# drwxr-xr-x = proprietário: tudo, outros: ler/listar
```

**Definindo Proprietário:**
```bash
# Sistema (requer root)
sudo chown root:admin /Library/Application Support/SleepAgent/

# Usuário
chown $(whoami):staff ~/SleepAgent/
```

### 4.6 Onde Instalar Cada Componente

| Componente | Diretório | Justificativa |
|------------|-----------|---------------|
| **Aplicação principal** | `/Applications/SleepAgent.app` | Padrão para apps macOS |
| **Arquivos core** | `/Library/Application Support/SleepAgent/` | Compartilhado entre usuários |
| **Binário CLI** | `/usr/local/bin/sleepagent` | No PATH padrão |
| **Configuração global** | `~/.claude/CLAUDE.md` | Padrão do Claude Code |
| **Configuração usuário** | `~/.config/sleepagent/` | Padrão XDG Base Directory |
| **Workspace** | `~/SleepAgent/workspace/` | Área de trabalho do usuário |
| **Extensões** | `/Library/Application Support/SleepAgent/extensoes/` | Compartilhadas |
| **Logs** | `~/Library/Logs/SleepAgent/` | Por usuário |
| **Cache** | `~/Library/Caches/SleepAgent/` | Por usuário, pode ser limpo |

### 4.7 Script de Criação de Estrutura

```bash
#!/bin/bash

# Criar estrutura de diretórios do Sleep Agent

echo "📁 Criando estrutura de diretórios..."

# Diretórios do sistema (requer sudo)
sudo mkdir -p "/Library/Application Support/SleepAgent"
sudo mkdir -p "/Library/Application Support/SleepAgent/core"
sudo mkdir -p "/Library/Application Support/SleepAgent/frameworks"
sudo mkdir -p "/Library/Application Support/SleepAgent/extensoes"
sudo mkdir -p "/Library/Application Support/SleepAgent/templates"

# Definir permissões
sudo chown -R root:admin "/Library/Application Support/SleepAgent"
sudo chmod -R 755 "/Library/Application Support/SleepAgent"

# Diretórios do usuário (não requer sudo)
mkdir -p ~/.config/sleepagent
mkdir -p ~/.claude
mkdir -p ~/SleepAgent/workspace
mkdir -p ~/Library/Logs/SleepAgent
mkdir -p ~/Library/Caches/SleepAgent

# Definir permissões do usuário
chmod 700 ~/.config/sleepagent
chmod 700 ~/.claude
chmod 755 ~/SleepAgent

echo "✅ Estrutura criada com sucesso!"
```

### 4.8 Apple Silicon vs Intel - Diferenças de Diretório

**Homebrew:**
- **Intel:** `/usr/local/Homebrew`
- **Apple Silicon:** `/opt/homebrew`

**Detectar arquitetura:**
```bash
if [[ $(uname -m) == 'arm64' ]]; then
    echo "Apple Silicon (M1/M2/M3)"
    HOMEBREW_PREFIX="/opt/homebrew"
else
    echo "Intel"
    HOMEBREW_PREFIX="/usr/local"
fi
```

**Adicionar ao PATH (universal):**
```bash
# Em ~/.zprofile
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
```

### 4.9 Diretórios Ocultos

**No macOS, arquivos/diretórios começando com `.` são ocultos:**
```bash
~/.claude/         # Oculto
~/.config/         # Oculto
~/Library/         # Oculto por padrão (sem ponto!)
```

**Mostrar arquivos ocultos no Finder:**
```bash
# Via linha de comando
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# Ou: Cmd + Shift + . (ponto)
```

### 4.10 Limpeza de Diretórios Órfãos

Ao desinstalar, remover:
```bash
#!/bin/bash

# Script de desinstalação

echo "🗑️  Removendo Sleep Agent..."

# Remover aplicação
sudo rm -rf "/Applications/SleepAgent.app"

# Remover arquivos do sistema
sudo rm -rf "/Library/Application Support/SleepAgent"
sudo rm -f "/Library/Preferences/com.sleepagent.plist"

# Remover binário
sudo rm -f "/usr/local/bin/sleepagent"
sudo rm -f "/opt/homebrew/bin/sleepagent"

# Remover arquivos do usuário (perguntar)
read -p "Remover configurações do usuário? [S/n]: " choice
case "$choice" in
    n|N ) ;;
    * )
        rm -rf ~/.config/sleepagent
        rm -rf ~/.claude
        rm -rf ~/Library/Logs/SleepAgent
        rm -rf ~/Library/Caches/SleepAgent
        ;;
esac

# Não remover workspace (pode conter trabalho do usuário)
echo "⚠️  Workspace em ~/SleepAgent/ não foi removido (pode conter dados importantes)"

echo "✅ Sleep Agent desinstalado!"
```

---

## 5. Scripts de Instalação

### 5.1 Shells no macOS

**Shell Padrão Atual:** zsh (desde macOS Catalina 10.15)
**Shell Anterior:** bash (pré-Catalina)

**Arquivos de Configuração:**

| Shell | Arquivo | Quando Executado | Uso Recomendado |
|-------|---------|------------------|-----------------|
| **zsh** | `~/.zprofile` | Login shell | PATH, variáveis de ambiente |
| **zsh** | `~/.zshrc` | Shell interativo | Aliases, prompt, aparência |
| **zsh** | `~/.zshenv` | Sempre | Raramente usado |
| **bash** | `~/.bash_profile` | Login shell | PATH (bash antigo) |
| **bash** | `~/.bashrc` | Shell interativo | Aliases (bash antigo) |

**Recomendação:** Configurar tanto `.zprofile` (zsh) quanto `.bash_profile` (bash) para compatibilidade.

### 5.2 Scripts Pre-Install

**O que são:**
- Scripts executados ANTES da instalação do payload
- Úteis para: verificar requisitos, criar diretórios, backup

**Localização:** `scripts/preinstall`

**Exemplo:**
```bash
#!/bin/bash
# preinstall script para Sleep Agent

set -e  # Parar em erro

echo "🔍 Verificando requisitos..."

# Verificar versão do macOS
MACOS_VERSION=$(sw_vers -productVersion)
MACOS_MAJOR=$(echo $MACOS_VERSION | cut -d. -f1)

if [ "$MACOS_MAJOR" -lt 11 ]; then
    echo "❌ Sleep Agent requer macOS 11 (Big Sur) ou superior"
    echo "   Versão detectada: $MACOS_VERSION"
    exit 1
fi

echo "✅ macOS $MACOS_VERSION (compatível)"

# Verificar espaço em disco (mínimo 1GB = 1048576 KB)
AVAILABLE_SPACE=$(df -k /Applications | tail -1 | awk '{print $4}')
REQUIRED_SPACE=1048576

if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
    echo "❌ Espaço insuficiente em disco"
    echo "   Necessário: 1GB, Disponível: $((AVAILABLE_SPACE / 1024))MB"
    exit 1
fi

echo "✅ Espaço em disco suficiente"

# Criar backup de configurações existentes
if [ -d "$HOME/.claude" ]; then
    echo "📦 Backup de configurações existentes..."
    BACKUP_DIR="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"
    cp -r "$HOME/.claude" "$BACKUP_DIR"
    echo "   Backup criado em: $BACKUP_DIR"
fi

# Criar diretórios necessários
echo "📁 Criando diretórios..."
mkdir -p "$HOME/.config/sleepagent"
mkdir -p "$HOME/SleepAgent/workspace"

echo "✅ Pre-instalação concluída"
exit 0
```

**Permissões:**
```bash
chmod 755 scripts/preinstall
```

### 5.3 Scripts Post-Install

**O que são:**
- Scripts executados DEPOIS da instalação do payload
- Úteis para: configuração final, instalação de dependências, registro

**Localização:** `scripts/postinstall`

**⚠️ IMPORTANTE:** Scripts postinstall já rodam como root - **NÃO usar sudo**

**Exemplo Completo:**
```bash
#!/bin/bash
# postinstall script para Sleep Agent

set -e

echo "🚀 Configurando Sleep Agent..."

# Obter o usuário que iniciou o instalador (não root)
CURRENT_USER=$(stat -f "%Su" /dev/console)
USER_HOME=$(eval echo ~$CURRENT_USER)

echo "   Usuário: $CURRENT_USER"
echo "   Home: $USER_HOME"

# 1. Instalar Homebrew (se não existir)
if ! -x "/opt/homebrew/bin/brew" ] && ! [ -x "/usr/local/bin/brew" ]; then
    echo "📦 Instalando Homebrew..."
    su - $CURRENT_USER -c 'NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
fi

# Detectar caminho do Homebrew
if [ -x "/opt/homebrew/bin/brew" ]; then
    BREW="/opt/homebrew/bin/brew"
elif [ -x "/usr/local/bin/brew" ]; then
    BREW="/usr/local/bin/brew"
fi

# 2. Instalar dependências via Homebrew
echo "⚡ Instalando dependências..."

# Git
if ! command -v git &> /dev/null; then
    echo "   • Git..."
    su - $CURRENT_USER -c "$BREW install git"
fi

# Node.js
if ! command -v node &> /dev/null; then
    echo "   • Node.js..."
    su - $CURRENT_USER -c "$BREW install node"
fi

# VS Code
if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    echo "   • VS Code..."
    su - $CURRENT_USER -c "$BREW install --cask visual-studio-code"
fi

# 3. Instalar Claude Code CLI
echo "🤖 Instalando Claude Code CLI..."
su - $CURRENT_USER -c "npm install -g @anthropic-ai/claude-code"

# 4. Instalar extensão VS Code
echo "🔌 Instalando extensão VS Code..."
su - $CURRENT_USER -c "code --install-extension anthropics.claude-code --force"

# 5. Copiar arquivos de configuração
echo "📝 Configurando arquivos..."

# Copiar CLAUDE.md global
CLAUDE_DIR="$USER_HOME/.claude"
mkdir -p "$CLAUDE_DIR"
cp "/Library/Application Support/SleepAgent/core/CLAUDE.md" "$CLAUDE_DIR/"
chown -R $CURRENT_USER:staff "$CLAUDE_DIR"
chmod 700 "$CLAUDE_DIR"

# Copiar configuração padrão
CONFIG_DIR="$USER_HOME/.config/sleepagent"
mkdir -p "$CONFIG_DIR"
cp "/Library/Application Support/SleepAgent/core/templates/config.yaml" "$CONFIG_DIR/"
chown -R $CURRENT_USER:staff "$CONFIG_DIR"

# 6. Criar symlink para binário (se houver)
if [ -f "/Library/Application Support/SleepAgent/bin/sleepagent" ]; then
    echo "🔗 Criando symlink..."
    if [ -x "$BREW" ]; then
        BREW_PREFIX=$($BREW --prefix)
        ln -sf "/Library/Application Support/SleepAgent/bin/sleepagent" "$BREW_PREFIX/bin/sleepagent"
    fi
fi

# 7. Adicionar ao PATH (zsh)
echo "🛤️  Configurando PATH..."
ZPROFILE="$USER_HOME/.zprofile"

# Verificar se PATH já está configurado
if ! grep -q "SleepAgent" "$ZPROFILE" 2>/dev/null; then
    su - $CURRENT_USER -c "cat >> $ZPROFILE" << 'EOF'

# Sleep Agent
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
EOF
fi

# 8. Configurar permissões finais
echo "🔒 Configurando permissões..."
chown -R root:admin "/Library/Application Support/SleepAgent"
chmod -R 755 "/Library/Application Support/SleepAgent"

# Diretórios do usuário
chown -R $CURRENT_USER:staff "$USER_HOME/SleepAgent"
chown -R $CURRENT_USER:staff "$USER_HOME/Library/Logs/SleepAgent"

# 9. Limpar cache
echo "🧹 Limpando cache..."
rm -rf /tmp/sleepagent-*

echo "✅ Sleep Agent instalado com sucesso!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Para começar:"
echo "  1. Abra um novo Terminal"
echo "  2. Execute: sleepagent --help"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

exit 0
```

**Permissões:**
```bash
chmod 755 scripts/postinstall
```

### 5.4 Executando Comandos com Privilégios

**❌ ERRADO (não usar sudo em postinstall):**
```bash
#!/bin/bash
# postinstall já roda como root!

sudo npm install -g pacote  # ❌ Desnecessário e pode causar erro
```

**✅ CORRETO:**
```bash
#!/bin/bash

# Para comandos do SISTEMA (já é root)
npm install -g pacote  # ✅ Roda como root

# Para comandos do USUÁRIO
CURRENT_USER=$(stat -f "%Su" /dev/console)
su - $CURRENT_USER -c "npm install -g pacote"  # ✅ Roda como usuário
```

**Obter usuário real:**
```bash
# Método 1: Console owner
CURRENT_USER=$(stat -f "%Su" /dev/console)

# Método 2: Variável de ambiente (se disponível)
CURRENT_USER=${USER}

# Método 3: Quem invocou sudo
CURRENT_USER=${SUDO_USER}
```

### 5.5 Atualizar PATH e Variáveis de Ambiente

**Adicionar ao PATH (zsh):**
```bash
# No postinstall
CURRENT_USER=$(stat -f "%Su" /dev/console)
USER_HOME=$(eval echo ~$CURRENT_USER)

# Adicionar ao .zprofile
cat >> "$USER_HOME/.zprofile" << 'EOF'

# Sleep Agent
export PATH="/Library/Application Support/SleepAgent/bin:$PATH"
EOF

# Ajustar permissões
chown $CURRENT_USER:staff "$USER_HOME/.zprofile"
```

**Adicionar variável de ambiente:**
```bash
cat >> "$USER_HOME/.zprofile" << 'EOF'

# Sleep Agent Environment
export SLEEPAGENT_HOME="$HOME/SleepAgent"
export SLEEPAGENT_CONFIG="$HOME/.config/sleepagent"
EOF
```

**Compatibilidade bash:**
```bash
# Adicionar também ao .bash_profile para usuários bash
if [ -f "$USER_HOME/.bash_profile" ] || [ ! -f "$USER_HOME/.zprofile" ]; then
    cat >> "$USER_HOME/.bash_profile" << 'EOF'

# Sleep Agent
export PATH="/Library/Application Support/SleepAgent/bin:$PATH"
EOF
fi
```

### 5.6 Tratamento de Erros em Scripts

**Boas práticas:**
```bash
#!/bin/bash

# Parar em erro
set -e

# Função de erro
error_exit() {
    echo "❌ Erro: $1" >&2
    exit 1
}

# Função de log
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Uso
log "Iniciando instalação..."

command_that_might_fail || error_exit "Falha ao executar comando"

log "Instalação concluída"
```

**Try-catch em bash:**
```bash
#!/bin/bash

# Não parar em erro
set +e

install_homebrew() {
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ $? -ne 0 ]; then
        echo "⚠️  Falha ao instalar Homebrew"
        return 1
    fi

    return 0
}

# Tentar instalar
if install_homebrew; then
    echo "✅ Homebrew instalado"
else
    echo "⚠️  Continuando sem Homebrew..."
fi
```

### 5.7 Logs de Instalação

**Criar log detalhado:**
```bash
#!/bin/bash

# Arquivo de log
LOG_FILE="/tmp/sleepagent-install-$(date +%Y%m%d_%H%M%S).log"

# Redirecionar tudo para log
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

echo "Sleep Agent Installation Log"
echo "============================"
echo "Date: $(date)"
echo "User: $(whoami)"
echo "macOS: $(sw_vers -productVersion)"
echo ""

# Resto do script...

echo ""
echo "Log salvo em: $LOG_FILE"
```

### 5.8 Detectar Arquitetura (Apple Silicon vs Intel)

```bash
#!/bin/bash

# Detectar arquitetura
ARCH=$(uname -m)

if [ "$ARCH" = "arm64" ]; then
    echo "🍎 Apple Silicon detectado"
    HOMEBREW_PREFIX="/opt/homebrew"
elif [ "$ARCH" = "x86_64" ]; then
    echo "💻 Intel detectado"
    HOMEBREW_PREFIX="/usr/local"
else
    echo "⚠️  Arquitetura desconhecida: $ARCH"
    exit 1
fi

echo "Homebrew prefix: $HOMEBREW_PREFIX"
```

### 5.9 Verificar Versão do macOS

```bash
#!/bin/bash

# Obter versão
MACOS_VERSION=$(sw_vers -productVersion)
MACOS_MAJOR=$(echo $MACOS_VERSION | cut -d. -f1)
MACOS_MINOR=$(echo $MACOS_VERSION | cut -d. -f2)

echo "macOS: $MACOS_VERSION (Major: $MACOS_MAJOR, Minor: $MACOS_MINOR)"

# Verificar compatibilidade
if [ "$MACOS_MAJOR" -lt 11 ]; then
    echo "❌ Sleep Agent requer macOS 11+ (Big Sur ou superior)"
    exit 1
fi

# Verificar recursos específicos
if [ "$MACOS_MAJOR" -ge 13 ]; then
    echo "✅ Suporte a APFS completo"
fi
```

### 5.10 Script de Verificação Pós-Instalação

```bash
#!/bin/bash
# verify-install.sh

echo "🔍 Verificando instalação do Sleep Agent..."
echo ""

ERRORS=0

# Função de verificação
check() {
    if [ $1 -eq 0 ]; then
        echo "✅ $2"
    else
        echo "❌ $2"
        ((ERRORS++))
    fi
}

# Verificar instalação de dependências
command -v git &> /dev/null
check $? "Git instalado"

command -v node &> /dev/null
check $? "Node.js instalado"

command -v npm &> /dev/null
check $? "npm instalado"

[ -d "/Applications/Visual Studio Code.app" ]
check $? "VS Code instalado"

command -v claude-code &> /dev/null
check $? "Claude Code CLI instalado"

# Verificar estrutura de diretórios
[ -d "/Library/Application Support/SleepAgent" ]
check $? "Diretório do sistema criado"

[ -d "$HOME/.claude" ]
check $? "Diretório de configuração criado"

[ -f "$HOME/.claude/CLAUDE.md" ]
check $? "Arquivo CLAUDE.md presente"

[ -d "$HOME/SleepAgent/workspace" ]
check $? "Workspace criado"

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ Instalação verificada com sucesso!"
    exit 0
else
    echo "❌ $ERRORS erro(s) encontrado(s)"
    exit 1
fi
```

---

## 6. Interface do Usuário

### 6.1 Wizard de Instalação macOS

O macOS tem um wizard de instalação nativo (Installer.app) que é acionado quando o usuário clica duas vezes em um arquivo .pkg.

**Telas Padrão:**
1. **Introduction** - Apresentação
2. **Read Me** - Informações importantes
3. **License** - Acordo de licença
4. **Destination Select** - Escolher disco de instalação
5. **Installation Type** - Componentes a instalar (customizado)
6. **Installation** - Progresso
7. **Summary** - Conclusão

### 6.2 Customização via distribution.xml

**Arquivo de distribuição:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
    <!-- Título da instalação -->
    <title>Sleep Agent</title>

    <!-- Organização -->
    <organization>com.sleepagent</organization>

    <!-- Background (dark mode e light mode) -->
    <background file="background.png"
                alignment="bottomleft"
                scaling="proportional"/>
    <background-darkAqua file="background-dark.png"
                         alignment="bottomleft"
                         scaling="proportional"/>

    <!-- Mensagem de boas-vindas -->
    <welcome file="welcome.html"
             mime-type="text/html"/>

    <!-- Read Me -->
    <readme file="readme.html"
            mime-type="text/html"/>

    <!-- Licença -->
    <license file="license.html"
             mime-type="text/html"/>

    <!-- Conclusão -->
    <conclusion file="conclusion.html"
                mime-type="text/html"/>

    <!-- Requisitos do sistema -->
    <os-version min="11.0"/>

    <!-- Opções de instalação -->
    <options
        customize="always"
        require-scripts="true"
        hostArchitectures="x86_64,arm64"/>

    <!-- Escolhas (componentes) -->
    <choices-outline>
        <line choice="default">
            <line choice="core"/>
            <line choice="frameworks"/>
            <line choice="extensions"/>
        </line>
    </choices-outline>

    <!-- Definição de escolhas -->
    <choice
        id="default"
        title="Sleep Agent"
        description="Instalar Sleep Agent completo"
        start_selected="true"
        start_enabled="false"
        start_visible="true">
        <pkg-ref id="com.sleepagent"/>
    </choice>

    <choice
        id="core"
        title="Core"
        description="Motor central do Sleep Agent (obrigatório)"
        start_selected="true"
        enabled="false">
        <pkg-ref id="com.sleepagent.core"/>
    </choice>

    <choice
        id="frameworks"
        title="Frameworks"
        description="Frameworks de execução"
        start_selected="true">
        <pkg-ref id="com.sleepagent.frameworks"/>
    </choice>

    <choice
        id="extensions"
        title="Extensões"
        description="Extensões pré-instaladas"
        start_selected="true">
        <pkg-ref id="com.sleepagent.extensions"/>
    </choice>

    <!-- Referências aos pacotes -->
    <pkg-ref id="com.sleepagent.core">
        <bundle-version>
            <bundle id="com.sleepagent.core"/>
        </bundle-version>
    </pkg-ref>

    <pkg-ref id="com.sleepagent.frameworks">
        <bundle-version>
            <bundle id="com.sleepagent.frameworks"/>
        </bundle-version>
    </pkg-ref>

    <pkg-ref id="com.sleepagent.extensions">
        <bundle-version>
            <bundle id="com.sleepagent.extensions"/>
        </bundle-version>
    </pkg-ref>

</installer-gui-script>
```

### 6.3 Páginas HTML Customizadas

**welcome.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            font-size: 13px;
            line-height: 1.5;
        }
        h1 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .feature {
            margin: 12px 0;
            padding-left: 24px;
        }
        .feature::before {
            content: "✓";
            color: #34C759;
            font-weight: bold;
            margin-left: -24px;
            margin-right: 12px;
        }
    </style>
</head>
<body>
    <h1>Bem-vindo ao Sleep Agent</h1>

    <p>Sleep Agent é um framework de agentes especializados que ajuda profissionais não-técnicos a realizarem tarefas complexas de forma simples.</p>

    <p><strong>Esta instalação irá:</strong></p>

    <div class="feature">Instalar Node.js, Git e VS Code (se necessário)</div>
    <div class="feature">Configurar Claude Code CLI</div>
    <div class="feature">Instalar extensão do VS Code</div>
    <div class="feature">Configurar estrutura de diretórios</div>
    <div class="feature">Copiar arquivos de configuração</div>

    <p style="margin-top: 24px;"><strong>Requisitos:</strong></p>
    <ul>
        <li>macOS 11 (Big Sur) ou superior</li>
        <li>1GB de espaço em disco</li>
        <li>Conexão com internet</li>
    </ul>

    <p style="margin-top: 24px;">Clique em <strong>Continuar</strong> para prosseguir.</p>
</body>
</html>
```

**conclusion.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            font-size: 13px;
            line-height: 1.5;
        }
        h1 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 16px;
            color: #34C759;
        }
        .box {
            background: #F5F5F7;
            border-radius: 8px;
            padding: 16px;
            margin: 16px 0;
            font-family: "SF Mono", Monaco, Menlo, monospace;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <h1>✓ Instalação Concluída!</h1>

    <p>Sleep Agent foi instalado com sucesso em seu Mac.</p>

    <p><strong>Para começar:</strong></p>

    <ol>
        <li>Abra um novo Terminal</li>
        <li>Execute o comando:</li>
    </ol>

    <div class="box">sleepagent --help</div>

    <p><strong>Ou abra o VS Code e:</strong></p>

    <ol>
        <li>Pressione <code>Cmd+Shift+P</code></li>
        <li>Digite "Claude Code"</li>
        <li>Selecione "Claude Code: Start"</li>
    </ol>

    <p style="margin-top: 24px;"><strong>Documentação:</strong><br>
    Acesse <a href="https://github.com/sleepagent/docs">https://github.com/sleepagent/docs</a></p>

    <p style="margin-top: 24px;">Obrigado por instalar o Sleep Agent!</p>
</body>
</html>
```

### 6.4 Background Images

**Especificações:**
- **Formato:** PNG com transparência
- **Tamanho:** 620x418 pixels (recomendado)
- **Posicionamento:** `alignment="bottomleft"` (canto inferior esquerdo)
- **Scaling:** `proportional` (manter proporção)

**Light Mode (background.png):**
- Cores claras
- Branco/cinza claro como base

**Dark Mode (background-dark.png):**
- Cores escuras
- Preto/cinza escuro como base

**Criar background no Photoshop/Figma:**
```
Canvas: 620x418px
Elementos:
  - Logo no canto inferior esquerdo
  - Gradiente sutil
  - Ícones representativos (engrenagens, código)

Exportar:
  - background.png (light)
  - background-dark.png (dark)
```

### 6.5 Ícones

**Ícone do Volume (DMG):**
- **Arquivo:** `.VolumeIcon.icns`
- **Formato:** Apple Icon Image (.icns)
- **Tamanhos:** 16x16 até 512x512 @ 2x
- **Criar:** Usar Icns Composer ou img2icns

**Criar .icns a partir de PNG:**
```bash
# 1. Criar estrutura
mkdir SleepAgent.iconset

# 2. Criar múltiplas versões
sips -z 16 16     icon.png --out SleepAgent.iconset/icon_16x16.png
sips -z 32 32     icon.png --out SleepAgent.iconset/icon_16x16@2x.png
sips -z 32 32     icon.png --out SleepAgent.iconset/icon_32x32.png
sips -z 64 64     icon.png --out SleepAgent.iconset/icon_32x32@2x.png
sips -z 128 128   icon.png --out SleepAgent.iconset/icon_128x128.png
sips -z 256 256   icon.png --out SleepAgent.iconset/icon_128x128@2x.png
sips -z 256 256   icon.png --out SleepAgent.iconset/icon_256x256.png
sips -z 512 512   icon.png --out SleepAgent.iconset/icon_256x256@2x.png
sips -z 512 512   icon.png --out SleepAgent.iconset/icon_512x512.png
sips -z 1024 1024 icon.png --out SleepAgent.iconset/icon_512x512@2x.png

# 3. Converter para .icns
iconutil -c icns SleepAgent.iconset

# Resultado: SleepAgent.icns
```

### 6.6 Customização do DMG

**Layout visual com create-dmg:**
```bash
create-dmg \
  --volname "Sleep Agent" \
  --volicon "SleepAgent.icns" \
  --background "dmg-background.png" \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "SleepAgent-Installer.pkg" 175 190 \
  --hide-extension "SleepAgent-Installer.pkg" \
  --app-drop-link 425 190 \
  "SleepAgent-v1.0.0.dmg" \
  "dist/"
```

**Parâmetros:**
- `--volname`: Nome do volume quando montado
- `--volicon`: Ícone do volume
- `--background`: Imagem de fundo (600x400px recomendado)
- `--window-pos`: Posição da janela (x, y)
- `--window-size`: Tamanho da janela (largura, altura)
- `--icon-size`: Tamanho dos ícones em pixels
- `--icon "arquivo" x y`: Posição do ícone
- `--app-drop-link x y`: Link para /Applications (drag-and-drop)

**Background do DMG (dmg-background.png):**
```
Tamanho: 600x400px (ou 1200x800px @2x)
Elementos:
  - Setas indicando "Arraste aqui" (se houver .app)
  - Instruções "Clique duas vezes para instalar"
  - Branding (logo, cores)

Exportar: PNG
```

### 6.7 Exemplo Visual de DMG

```
┌─────────────────────────────────────────────────────────┐
│ Sleep Agent                                    🟢 🟡 🔴 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│                    [Background Image]                   │
│                                                         │
│         📦                          📁                  │
│  SleepAgent-Installer.pkg      Applications            │
│                                                         │
│   ┌──────────────────────────────────────┐            │
│   │ Clique duas vezes no instalador      │            │
│   │ para começar                         │            │
│   └──────────────────────────────────────┘            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 6.8 Mensagens e Textos

**Tom de voz:**
- ✅ Profissional mas acessível
- ✅ Direto e claro
- ✅ Sem jargões técnicos desnecessários
- ✅ Focado em benefícios, não em features

**Exemplos:**

**Ruim:**
> "O instalador irá executar scripts de pré e pós-instalação que configurarão symlinks e variáveis de ambiente no shell zsh."

**Bom:**
> "Esta instalação irá configurar seu sistema automaticamente para que você possa começar a usar o Sleep Agent imediatamente."

### 6.9 Ferramentas GUI para Customização

**Package Builder:**
- Interface visual para background images
- Preview em tempo real
- Suporte a light/dark mode
- Editor WYSIWYG para HTML

**Packages:**
- Editor de distribution.xml integrado
- Seletor de background
- Preview do instalador

**DMG Canvas:**
- Editor visual drag-and-drop para DMG
- Templates profissionais
- Preview 3D do DMG

---

## 7. Distribuição

### 7.1 Code Signing (Assinatura de Código)

**Por que é necessário:**
- ✅ Gatekeeper verifica assinatura antes de executar
- ✅ Usuários veem "desenvolvedor verificado" em vez de "desenvolvedor não identificado"
- ✅ Notarização pela Apple requer code signing
- ✅ Distribuição fora da Mac App Store requer Developer ID

**Tipos de Certificados:**

| Certificado | Uso | Custo |
|-------------|-----|-------|
| **Developer ID Application** | Assinar apps (.app) | $99/ano |
| **Developer ID Installer** | Assinar instaladores (.pkg) | $99/ano |
| **Mac App Store** | Apps na Mac App Store | $99/ano |

**Nota:** Developer ID (Application + Installer) vem no Apple Developer Program ($99/ano).

**Obter Developer ID:**
1. Inscrever-se no [Apple Developer Program](https://developer.apple.com/programs/) ($99/ano)
2. Acessar [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list)
3. Criar certificado "Developer ID Installer"
4. Baixar e instalar no Keychain Access

**Assinar PKG:**
```bash
# Listar certificados disponíveis
security find-identity -v -p basic

# Assinar instalador
productsign --sign "Developer ID Installer: Your Name (TEAM_ID)" \
            SleepAgent-Installer.pkg \
            SleepAgent-Installer-Signed.pkg

# Verificar assinatura
pkgutil --check-signature SleepAgent-Installer-Signed.pkg
```

**Assinar DMG:**
```bash
codesign --sign "Developer ID Application: Your Name (TEAM_ID)" \
         --timestamp \
         SleepAgent-v1.0.0.dmg

# Verificar
codesign --verify --verbose SleepAgent-v1.0.0.dmg
```

### 7.2 Notarização

**O que é:**
- Processo automático da Apple que escaneia software em busca de malware
- Obrigatório desde macOS 10.15 (Catalina) para software distribuído fora da Mac App Store
- Requer code signing prévio

**Ferramentas:**
- **notarytool** (atual - desde Nov 2023)
- ~~altool~~ (depreciado - não usar)

**Pré-requisitos:**
- Xcode 14 ou superior (ou Command Line Tools)
- Apple ID com autenticação de dois fatores
- App-specific password ou chave API

**Criar App-Specific Password:**
1. Acessar [appleid.apple.com](https://appleid.apple.com)
2. Segurança → App-Specific Passwords
3. Gerar nova senha
4. Salvar (não será exibida novamente)

**Salvar credenciais no Keychain:**
```bash
xcrun notarytool store-credentials "AC_PASSWORD" \
                    --apple-id "seu@email.com" \
                    --team-id "TEAM_ID" \
                    --password "xxxx-xxxx-xxxx-xxxx"
```

**Processo de Notarização:**
```bash
# 1. Assinar (se ainda não fez)
productsign --sign "Developer ID Installer: Your Name" \
            SleepAgent-Installer.pkg \
            SleepAgent-Installer-Signed.pkg

# 2. Enviar para notarização
xcrun notarytool submit SleepAgent-Installer-Signed.pkg \
                        --keychain-profile "AC_PASSWORD" \
                        --wait

# Saída:
# Conducting pre-submission checks for SleepAgent-Installer-Signed.pkg and initiating connection to the Apple notary service...
# Submission ID received
#   id: 2efe2717-52ef-43a5-96dc-0797e4ca1041
# Successfully uploaded file
#   id: 2efe2717-52ef-43a5-96dc-0797e4ca1041
#   path: SleepAgent-Installer-Signed.pkg
# Waiting for processing to complete.
# Current status: Accepted........
# Processing complete
#   id: 2efe2717-52ef-43a5-96dc-0797e4ca1041
#   status: Accepted

# 3. Staple (anexar ticket de notarização)
xcrun stapler staple SleepAgent-Installer-Signed.pkg

# 4. Verificar
xcrun stapler validate SleepAgent-Installer-Signed.pkg
spctl -a -v --type install SleepAgent-Installer-Signed.pkg
```

**Verificar status de notarização:**
```bash
# Obter log
xcrun notarytool log 2efe2717-52ef-43a5-96dc-0797e4ca1041 \
                     --keychain-profile "AC_PASSWORD" \
                     developer_log.json

# Ver resultado
cat developer_log.json | jq
```

**Se notarização falhar:**
- Verificar logs com `notarytool log`
- Problemas comuns:
  - Code signing inválido
  - Binários não assinados dentro do pacote
  - Hardened Runtime não habilitado
  - Binários com arquiteturas inválidas

**Stapling (Grampeamento):**
- Anexa o ticket de notarização ao arquivo
- Permite que arquivo seja verificado offline
- Sempre fazer staple após notarização bem-sucedida

### 7.3 Gatekeeper

**O que é:**
- Sistema de segurança do macOS
- Verifica apps antes de executar pela primeira vez
- Desde macOS Catalina, verifica notarização

**Níveis de Gatekeeper:**
1. **Mac App Store**: Apenas apps da Mac App Store
2. **Mac App Store e Desenvolvedores Identificados**: Apps assinados com Developer ID
3. **Anywhere** (removido no macOS Sierra)

**Como Gatekeeper Funciona:**

**1. Usuário baixa e abre app/instalador:**
```
Usuário → Clica duas vezes no .pkg
    ↓
Gatekeeper verifica:
    1. Assinatura válida? (Code signing)
    2. Notarizado pela Apple?
    3. Revogado?
    ↓
Se tudo OK → Executa
Se não → Exibe aviso
```

**2. Avisos do Gatekeeper:**

**✅ App Notarizado:**
> "SleepAgent-Installer.pkg" foi baixado da internet. Tem certeza que deseja abri-lo?
>
> [Cancelar] [Abrir]

**⚠️ App NÃO Notarizado (mas assinado):**
> "SleepAgent-Installer.pkg" não pode ser aberto porque é de um desenvolvedor não identificado.
>
> [OK]

**❌ App NÃO Assinado:**
> "SleepAgent-Installer.pkg" não pode ser aberto porque foi baixado da internet.
>
> [Mover para Lixeira] [OK]

### 7.4 Contornar Gatekeeper (Usuário Final)

**⚠️ Importante:** Estas instruções são para usuários finais que desejam instalar software não-notarizado. **Não recomende isso** - sempre notarize seu software.

**Método 1: System Settings (macOS Sequoia 15+):**
1. Tentar abrir o app/instalador
2. Receber mensagem de bloqueio
3. Abrir System Settings → Privacy & Security
4. Clicar em "Open Anyway"
5. Confirmar com senha de administrador

**Método 2: Control-click (removido no macOS Sequoia):**
- Control-click (ou Right-click) no arquivo
- Selecionar "Open"
- Confirmar no diálogo

**Método 3: Linha de Comando:**
```bash
# Remover atributo de quarentena
xattr -d com.apple.quarantine SleepAgent-Installer.pkg

# Verificar atributos
xattr -l SleepAgent-Installer.pkg
```

**Método 4: Desabilitar Gatekeeper (não recomendado):**
```bash
# Desabilitar (requer SIP desabilitado)
sudo spctl --master-disable

# Reabilitar
sudo spctl --master-enable
```

### 7.5 Distribuição fora da Mac App Store

**Canais de Distribuição:**

1. **Download direto (site próprio):**
   - ✅ Controle total
   - ✅ Sem taxa de plataforma
   - ✅ Atualizações independentes
   - ❌ Requer infraestrutura própria
   - ❌ Menos descoberta

2. **Homebrew Cask:**
   - ✅ Familiar para desenvolvedores
   - ✅ Atualizações automáticas
   - ✅ Fácil instalação (`brew install`)
   - ❌ Processo de submissão ao repositório
   - ❌ Público limitado (desenvolvedores)

3. **Setapp, MacUpdate, etc.:**
   - ✅ Plataforma estabelecida
   - ✅ Descoberta de usuários
   - ❌ Taxa de plataforma
   - ❌ Processo de aprovação

4. **GitHub Releases:**
   - ✅ Gratuito
   - ✅ Versionamento automático
   - ✅ Changelog integrado
   - ❌ Menos descoberta
   - ❌ Público técnico

**Recomendação para Sleep Agent:**
- **Principal:** Download direto (site)
- **Secundário:** GitHub Releases
- **Alternativa:** Homebrew Cask

### 7.6 Estrutura de Distribuição

```
releases/
├── v1.0.0/
│   ├── SleepAgent-v1.0.0-macos-universal.dmg  # DMG notarizado
│   ├── SleepAgent-v1.0.0-macos-universal.pkg  # PKG notarizado
│   ├── checksums.txt                           # SHA256
│   └── RELEASE_NOTES.md                        # Changelog
├── v1.0.1/
│   └── ...
└── latest -> v1.0.1                            # Symlink para última versão
```

**checksums.txt:**
```
# SHA256 Checksums

ecf6e21b7c674b0a6bde97f5e8cfcd3e1b2a84a4  SleepAgent-v1.0.0-macos-universal.dmg
9f86d081884c7d659a2feaa0c55ad015a3bf4f1b  SleepAgent-v1.0.0-macos-universal.pkg
```

**Gerar checksums:**
```bash
shasum -a 256 SleepAgent-v1.0.0-macos-universal.dmg > checksums.txt
shasum -a 256 SleepAgent-v1.0.0-macos-universal.pkg >> checksums.txt
```

### 7.7 Versionamento

**Formato Recomendado:** Semantic Versioning (SemVer)
```
MAJOR.MINOR.PATCH
1.0.0
```

**Onde definir versão:**

**1. No PKG (Info.plist):**
```xml
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
<key>CFBundleVersion</key>
<string>1</string>
```

**2. No pkgbuild:**
```bash
pkgbuild --version 1.0.0 \
         --identifier com.sleepagent.app \
         ...
```

**3. No distribution.xml:**
```xml
<pkg-ref id="com.sleepagent">
    <bundle-version>
        <bundle CFBundleShortVersionString="1.0.0"
                CFBundleVersion="1"
                id="com.sleepagent"/>
    </bundle-version>
</pkg-ref>
```

**4. No nome do arquivo:**
```
SleepAgent-v1.0.0-macos-universal.dmg
```

### 7.8 Build Universal (Intel + Apple Silicon)

**O que é:**
- Binário que funciona tanto em Intel quanto Apple Silicon
- Também chamado de "Universal Binary" ou "Fat Binary"

**Criar Universal Binary:**
```bash
# Compilar para ambas arquiteturas
gcc -arch x86_64 -arch arm64 -o sleepagent sleepagent.c

# Verificar arquiteturas
lipo -archs sleepagent
# Output: x86_64 arm64

# Informações detalhadas
file sleepagent
# Output: Mach-O universal binary with 2 architectures
```

**Node.js/Electron:**
- Usar `electron-builder` com `target: "universal"`
- Ou criar builds separados e combinar com `lipo`

**Nomenclatura:**
```
SleepAgent-v1.0.0-macos-universal.dmg      # Intel + Apple Silicon
SleepAgent-v1.0.0-macos-x86_64.dmg         # Apenas Intel
SleepAgent-v1.0.0-macos-arm64.dmg          # Apenas Apple Silicon
```

### 7.9 Hospedagem e CDN

**Opções:**

**1. GitHub Releases (Gratuito):**
```bash
# Criar release
gh release create v1.0.0 \
    SleepAgent-v1.0.0-macos-universal.dmg \
    SleepAgent-v1.0.0-macos-universal.pkg \
    checksums.txt \
    --title "Sleep Agent v1.0.0" \
    --notes-file RELEASE_NOTES.md
```

**2. S3 + CloudFront (AWS):**
- Bucket S3 para armazenamento
- CloudFront para CDN
- Controle total sobre distribuição

**3. Self-hosted (servidor próprio):**
- Nginx/Apache
- HTTPS obrigatório
- Logs de download

**Requisitos:**
- ✅ HTTPS obrigatório (segurança)
- ✅ Versionamento de URLs
- ✅ Redirect de `/latest` para versão atual
- ✅ Checksums disponíveis

### 7.10 Página de Download

**Elementos essenciais:**

```html
<!DOCTYPE html>
<html>
<head>
    <title>Download - Sleep Agent</title>
</head>
<body>
    <h1>Download Sleep Agent</h1>

    <!-- Versão -->
    <p><strong>Versão:</strong> 1.0.0 (01/02/2026)</p>

    <!-- Botão principal -->
    <a href="/releases/latest/SleepAgent-macos-universal.dmg"
       class="download-button">
        Baixar para macOS
        <small>Intel + Apple Silicon | 45 MB</small>
    </a>

    <!-- Requisitos -->
    <h2>Requisitos</h2>
    <ul>
        <li>macOS 11 (Big Sur) ou superior</li>
        <li>1 GB de espaço em disco</li>
        <li>Conexão com internet (para instalação de dependências)</li>
    </ul>

    <!-- Instruções -->
    <h2>Instalação</h2>
    <ol>
        <li>Baixe o arquivo .dmg acima</li>
        <li>Abra o arquivo baixado</li>
        <li>Clique duas vezes em "SleepAgent-Installer.pkg"</li>
        <li>Siga o assistente de instalação</li>
    </ol>

    <!-- Verificação -->
    <h2>Verificação (Opcional)</h2>
    <p>Para verificar a integridade do download:</p>
    <pre>shasum -a 256 SleepAgent-v1.0.0-macos-universal.dmg</pre>
    <p>Deve corresponder a: <code>ecf6e21b7c674b0a6bde97f5e8cfcd3e1b2a84a4</code></p>

    <!-- Versões anteriores -->
    <h2>Versões Anteriores</h2>
    <p><a href="/releases/">Ver todas as versões</a></p>
</body>
</html>
```

---

## 8. Best Practices

### 8.1 Como Usuários Esperam Instalar Apps no macOS

**Pesquisa de expectativas:**

**Cenário 1: App Simples (ex: Chrome, Spotify)**
- ✅ Download .dmg
- ✅ Drag-and-drop para /Applications
- ✅ Ejetar DMG
- ✅ Abrir app

**Cenário 2: App com Instalação Complexa (ex: Adobe, Microsoft Office)**
- ✅ Download .dmg ou .pkg
- ✅ Clicar duas vezes no instalador
- ✅ Seguir wizard (Next > Next > Install)
- ✅ App instalado automaticamente

**Cenário 3: Developer Tools (ex: Xcode, Docker)**
- ✅ Download direto ou via Homebrew
- ✅ Instalação via .pkg ou `brew install`
- ✅ Configuração pós-instalação

**Sleep Agent se encaixa no Cenário 2:**
- Instalação complexa (dependências, configuração)
- PKG com wizard é apropriado
- DMG para apresentação visual

### 8.2 Drag-and-Drop vs PKG Installers

**Quando usar Drag-and-Drop (DMG com .app):**
- ✅ App autocontido
- ✅ Sem dependências externas
- ✅ Sem configuração do sistema
- ✅ Público casual

**Exemplos:** Chrome, Spotify, Slack, Notion

**Quando usar PKG Installer:**
- ✅ Instalação em múltiplos diretórios
- ✅ Dependências a instalar
- ✅ Scripts de configuração
- ✅ Componentes do sistema
- ✅ Enterprise deployment

**Exemplos:** Adobe Creative Cloud, Microsoft Office, Docker, Xcode

**Sleep Agent:** PKG Installer (dentro de DMG para visual)

### 8.3 Experiência do Usuário

**Princípios:**

1. **Transparência:**
   - ✅ Informar o que será instalado
   - ✅ Mostrar progresso claramente
   - ✅ Explicar o que aconteceu após instalação

2. **Simplicidade:**
   - ✅ Menos cliques possível
   - ✅ Defaults sensatos
   - ✅ Não sobrecarregar com opções

3. **Confiança:**
   - ✅ Code signing + notarização
   - ✅ Mensagens claras
   - ✅ Sem surpresas

4. **Feedback:**
   - ✅ Progresso visível
   - ✅ Confirmação de conclusão
   - ✅ Próximos passos claros

**Exemplo de fluxo ideal:**
```
1. Usuário baixa DMG (1 clique)
   ↓
2. Abre DMG (1 clique duplo)
   ↓
3. Vê instruções visuais claras
   ↓
4. Clica no instalador (1 clique duplo)
   ↓
5. Wizard guia passo-a-passo
   ↓
6. Instalação automática (sem intervenção)
   ↓
7. Conclusão com próximos passos
   ↓
8. Usuário pode começar a usar
```

### 8.4 Desinstalação

**Problema:** macOS não tem desinstalador padrão

**Soluções:**

**1. Script de Desinstalação Incluído:**
```bash
# Criar uninstall.sh
#!/bin/bash

echo "🗑️  Desinstalando Sleep Agent..."

# Remover aplicação
sudo rm -rf "/Applications/SleepAgent.app"

# Remover arquivos do sistema
sudo rm -rf "/Library/Application Support/SleepAgent"
sudo rm -f "/Library/Preferences/com.sleepagent.plist"

# Remover binário
sudo rm -f "/usr/local/bin/sleepagent"
sudo rm -f "/opt/homebrew/bin/sleepagent"

# Perguntar sobre configurações do usuário
read -p "Remover configurações do usuário? [s/N]: " choice
case "$choice" in
    s|S )
        rm -rf ~/.config/sleepagent
        rm -rf ~/.claude
        rm -rf ~/Library/Logs/SleepAgent
        rm -rf ~/Library/Caches/SleepAgent
        echo "✅ Configurações removidas"
        ;;
    * )
        echo "⏩ Configurações mantidas"
        ;;
esac

echo "✅ Sleep Agent desinstalado!"
```

**2. Incluir no DMG:**
```
SleepAgent-v1.0.0.dmg
├── SleepAgent-Installer.pkg
├── Uninstall Sleep Agent.tool    # Script de desinstalação
└── README.html
```

**3. Documentar desinstalação manual:**
```markdown
# Desinstalar Sleep Agent

## Via Script
1. Abrir `Uninstall Sleep Agent.tool` (incluído no DMG)
2. Confirmar remoção

## Manualmente
1. Remover aplicação:
   ```bash
   sudo rm -rf "/Applications/SleepAgent.app"
   ```
2. Remover arquivos do sistema:
   ```bash
   sudo rm -rf "/Library/Application Support/SleepAgent"
   ```
3. Remover configurações (opcional):
   ```bash
   rm -rf ~/.config/sleepagent
   ```
```

**4. Suporte a ferramentas de desinstalação:**
- CleanMyMac, AppCleaner, etc. detectam automaticamente:
  - `/Applications/SleepAgent.app`
  - `~/Library/Application Support/SleepAgent`
  - `~/Library/Preferences/com.sleepagent.plist`

### 8.5 Atualizações

**Estratégias:**

**1. Sparkle Framework (mais popular):**
```bash
# Adicionar Sparkle ao app
# Sparkle verifica automaticamente atualizações
```

**2. Homebrew (se distribuído via Homebrew):**
```bash
brew upgrade sleepagent
```

**3. Auto-update interno:**
```bash
sleepagent update
# Baixa e instala nova versão
```

**4. Manual:**
- Usuário baixa nova versão
- Instala por cima da antiga
- PKG deve detectar e atualizar

**Recomendação para Sleep Agent:**
- Inicialmente: Atualizações manuais (documentadas)
- Futuro: Integrar Sparkle ou sistema próprio

### 8.6 Testes

**O que testar:**

**1. Instalação limpa:**
- ✅ Máquina virtual macOS sem Sleep Agent
- ✅ Seguir fluxo completo de instalação
- ✅ Verificar todos os componentes instalados

**2. Upgrade:**
- ✅ Instalar versão antiga
- ✅ Instalar versão nova por cima
- ✅ Verificar que configurações foram preservadas

**3. Desinstalação:**
- ✅ Instalar
- ✅ Desinstalar
- ✅ Verificar que tudo foi removido

**4. Diferentes versões macOS:**
- ✅ macOS 11 (Big Sur)
- ✅ macOS 12 (Monterey)
- ✅ macOS 13 (Ventura)
- ✅ macOS 14 (Sonoma)
- ✅ macOS 15 (Sequoia)

**5. Diferentes arquiteturas:**
- ✅ Intel (x86_64)
- ✅ Apple Silicon (arm64)

**6. Cenários de erro:**
- ✅ Espaço em disco insuficiente
- ✅ Sem conexão internet (se aplicável)
- ✅ Permissões negadas
- ✅ Dependência já instalada

**Ferramentas:**
- VMware Fusion ou Parallels (VMs macOS)
- GitHub Actions (CI/CD)
- TestFlight (para apps com GUI)

### 8.7 Documentação

**Essencial:**

1. **README.md no repositório:**
   - Como compilar
   - Como criar instalador
   - Como assinar e notarizar

2. **Instruções de instalação (site/docs):**
   - Requisitos
   - Passo-a-passo
   - Solução de problemas

3. **Changelog:**
   - O que mudou em cada versão
   - Breaking changes
   - Novas features

4. **FAQ:**
   - "Não consigo abrir o instalador" → Gatekeeper
   - "Como desinstalar?" → Script
   - "Como atualizar?" → Processo

### 8.8 Segurança

**Checklist:**

- ✅ **Code signing:** Todos os binários assinados
- ✅ **Notarização:** Instalador notarizado pela Apple
- ✅ **HTTPS:** Download apenas via HTTPS
- ✅ **Checksums:** SHA256 disponível para verificação
- ✅ **Permissions:** Mínimo necessário (princípio do menor privilégio)
- ✅ **Scripts:** Validação de entrada, caminhos absolutos
- ✅ **Secrets:** Nunca incluir API keys ou senhas
- ✅ **Dependencies:** Usar fontes confiáveis (Homebrew oficial)

**Hardened Runtime:**
```bash
# Ao assinar, incluir hardened runtime
codesign --sign "Developer ID Application" \
         --options runtime \
         --timestamp \
         SleepAgent.app
```

### 8.9 Suporte e Feedback

**Canais:**

1. **GitHub Issues:**
   - Bug reports
   - Feature requests
   - Questões técnicas

2. **Documentação:**
   - Troubleshooting guide
   - FAQ

3. **Email/Support:**
   - Suporte direto

**Informações úteis para debug:**
```bash
# Script de diagnóstico
cat > diagnose.sh << 'EOF'
#!/bin/bash
echo "Sleep Agent - Diagnóstico"
echo "========================"
echo ""
echo "macOS: $(sw_vers -productVersion)"
echo "Arquitetura: $(uname -m)"
echo ""
echo "Homebrew: $(brew --version | head -n 1 || echo 'não instalado')"
echo "Git: $(git --version || echo 'não instalado')"
echo "Node.js: $(node --version || echo 'não instalado')"
echo "npm: $(npm --version || echo 'não instalado')"
echo "Claude Code: $(claude-code --version || echo 'não instalado')"
echo ""
echo "Estrutura de diretórios:"
ls -la "/Library/Application Support/SleepAgent" 2>/dev/null || echo "Não encontrado"
ls -la ~/.claude 2>/dev/null || echo "Não encontrado"
ls -la ~/SleepAgent 2>/dev/null || echo "Não encontrado"
EOF

chmod +x diagnose.sh
```

### 8.10 Localização (i18n)

**Idiomas prioritários:**
1. Inglês (padrão)
2. Português (Brasil)
3. Espanhol

**O que localizar:**
- ✅ Textos do wizard (welcome.html, readme.html, etc.)
- ✅ Mensagens de erro
- ✅ Documentação

**Estrutura:**
```
resources/
├── en.lproj/
│   ├── welcome.html
│   ├── readme.html
│   └── conclusion.html
├── pt-BR.lproj/
│   ├── welcome.html
│   ├── readme.html
│   └── conclusion.html
└── es.lproj/
    ├── welcome.html
    ├── readme.html
    └── conclusion.html
```

**No distribution.xml:**
```xml
<welcome file="welcome.html" mime-type="text/html"/>
```

O macOS escolhe automaticamente baseado no idioma do sistema.

---

## 9. Recomendações Finais

### 9.1 Stack Recomendado para Sleep Agent

**Baseado na pesquisa, a melhor abordagem é:**

```
┌─────────────────────────────────────────┐
│   DMG Container (Visual + Organização)  │
│  ┌───────────────────────────────────┐  │
│  │  PKG Installer (Instalação Real)  │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  • Scripts postinstall      │  │  │
│  │  │  • Homebrew + dependências  │  │  │
│  │  │  • Cópia de arquivos        │  │  │
│  │  │  • Configuração PATH        │  │  │
│  │  └─────────────────────────────┘  │  │
│  └───────────────────────────────────┘  │
│  README.html                            │
│  Uninstall.tool                         │
└─────────────────────────────────────────┘
```

**Ferramentas:**
- **pkgbuild + productbuild** (criar PKG)
- **create-dmg** (sindresorhus/create-dmg via Node.js)
- **notarytool** (notarização)
- **Homebrew** (instalação de dependências)

**Justificativa:**
- ✅ PKG permite instalação complexa (equivalente ao Inno Setup)
- ✅ DMG oferece apresentação visual profissional
- ✅ Homebrew é padrão de facto para dependências
- ✅ Ferramentas nativas = zero custo, máxima compatibilidade
- ✅ Automação via scripts = CI/CD friendly

### 9.2 Fluxo de Build Automatizado

```bash
#!/bin/bash
# build-installer.sh

set -e

VERSION="1.0.0"
APP_NAME="SleepAgent"
IDENTIFIER="com.sleepagent"

echo "🔨 Building $APP_NAME v$VERSION..."

# 1. Preparar estrutura
echo "📁 Preparando estrutura..."
mkdir -p build/payload/Library/Application\ Support/$APP_NAME
mkdir -p build/payload/usr/local/bin
mkdir -p build/scripts
mkdir -p build/resources
mkdir -p dist

# 2. Copiar arquivos
echo "📋 Copiando arquivos..."
cp -r core build/payload/Library/Application\ Support/$APP_NAME/
cp -r frameworks build/payload/Library/Application\ Support/$APP_NAME/
cp -r extensoes build/payload/Library/Application\ Support/$APP_NAME/

# 3. Copiar scripts
cp scripts/postinstall build/scripts/
chmod 755 build/scripts/postinstall

# 4. Copiar recursos (HTML, imagens)
cp resources/*.html build/resources/
cp resources/*.png build/resources/

# 5. Criar component package
echo "📦 Criando component package..."
pkgbuild --root build/payload \
         --identifier $IDENTIFIER.app \
         --version $VERSION \
         --install-location / \
         --scripts build/scripts \
         build/$APP_NAME-component.pkg

# 6. Criar distribution.xml
echo "📝 Criando distribution.xml..."
productbuild --synthesize \
             --package build/$APP_NAME-component.pkg \
             build/distribution.xml

# Customizar distribution.xml (inserir background, welcome, etc.)
# ... (edição via sed ou template)

# 7. Criar product archive
echo "📦 Criando product archive..."
productbuild --distribution build/distribution.xml \
             --resources build/resources \
             --package-path build \
             build/$APP_NAME-Installer-Unsigned.pkg

# 8. Assinar
echo "✍️  Assinando..."
productsign --sign "Developer ID Installer: Your Name (TEAM_ID)" \
            build/$APP_NAME-Installer-Unsigned.pkg \
            build/$APP_NAME-Installer.pkg

# 9. Notarizar
echo "📮 Enviando para notarização..."
xcrun notarytool submit build/$APP_NAME-Installer.pkg \
                        --keychain-profile "AC_PASSWORD" \
                        --wait

# 10. Staple
echo "📎 Stapling..."
xcrun stapler staple build/$APP_NAME-Installer.pkg

# 11. Criar DMG
echo "💿 Criando DMG..."
create-dmg build/$APP_NAME-Installer.pkg \
    --overwrite \
    --dmg-title "$APP_NAME" \
    dist/$APP_NAME-v$VERSION-macos-universal.dmg

# 12. Assinar DMG
echo "✍️  Assinando DMG..."
codesign --sign "Developer ID Application: Your Name (TEAM_ID)" \
         --timestamp \
         dist/$APP_NAME-v$VERSION-macos-universal.dmg

# 13. Gerar checksums
echo "🔐 Gerando checksums..."
cd dist
shasum -a 256 $APP_NAME-v$VERSION-macos-universal.dmg > checksums.txt
cd ..

echo "✅ Build concluído!"
echo ""
echo "Arquivo gerado: dist/$APP_NAME-v$VERSION-macos-universal.dmg"
echo "Checksum: dist/checksums.txt"
```

### 9.3 Estrutura de Arquivos Final

```
sleep_agent_macos_installer/
├── README.md                      # Documentação do build
├── build-installer.sh             # Script principal de build
├── core/                          # Arquivos do Sleep Agent
│   ├── CLAUDE.md
│   ├── orquestrador/
│   ├── templates/
│   └── comandos/
├── frameworks/                    # Frameworks
│   └── ralph/
├── extensoes/                     # Extensões
│   └── [extensoes]/
├── scripts/                       # Scripts de instalação
│   ├── preinstall
│   └── postinstall
├── resources/                     # Recursos do instalador
│   ├── welcome.html
│   ├── readme.html
│   ├── conclusion.html
│   ├── background.png
│   ├── background-dark.png
│   └── icon.icns
├── build/                         # Diretório de build (gitignore)
│   └── ...
└── dist/                          # Distribuição final (gitignore)
    └── SleepAgent-v1.0.0-macos-universal.dmg
```

### 9.4 Checklist Pré-Release

**Antes de distribuir:**

- [ ] Code signing configurado
- [ ] Notarização testada e funcionando
- [ ] Instalação testada em macOS limpo
- [ ] Instalação testada em Intel E Apple Silicon
- [ ] Desinstalação testada
- [ ] Documentação completa
- [ ] Changelog atualizado
- [ ] Checksums gerados
- [ ] Release notes escritas
- [ ] Screenshots/demo preparados
- [ ] Página de download atualizada

### 9.5 Roadmap de Implementação

**Fase 1: MVP (Minimal Viable Package)**
1. Criar PKG básico com pkgbuild
2. Script postinstall que instala dependências via Homebrew
3. Assinar e notarizar
4. Testar em máquina limpa

**Fase 2: Visual**
1. Criar DMG com create-dmg
2. Adicionar background customizado
3. Incluir README.html

**Fase 3: Polish**
1. Customizar wizard com distribution.xml
2. Adicionar welcome/conclusion.html
3. Criar uninstaller

**Fase 4: Automação**
1. Script de build automatizado
2. CI/CD (GitHub Actions)
3. Releases automáticas

**Fase 5: Distribuição**
1. Página de download
2. Homebrew Cask
3. Sistema de atualizações

### 9.6 Diferenças-Chave: Windows (Inno Setup) vs macOS

| Aspecto | Windows (Inno Setup) | macOS (pkgbuild + DMG) |
|---------|---------------------|------------------------|
| **Formato** | .exe (executável) | .pkg (pacote) + .dmg (imagem) |
| **Ferramenta** | Inno Setup (GUI) | pkgbuild (CLI) ou Package Builder (GUI) |
| **Wizard** | Customizável via script | distribution.xml + HTML |
| **Assinatura** | Code signing certificate | Developer ID + notarização |
| **Instalação silenciosa** | `/SILENT` flag | `installer -pkg` |
| **Dependências** | Incluir executáveis | Homebrew ou .pkg separados |
| **Estrutura de diretórios** | C:\Program Files\ | /Library/Application Support/ |
| **Configuração global** | Registry ou AppData | ~/.config/ ou ~/Library/ |
| **PATH** | Modificar via script | ~/.zprofile ou ~/.bash_profile |
| **Desinstalação** | Uninstaller automático | Script manual |
| **Distribuição** | .exe direto | .dmg com visual |
| **Custo** | Grátis (Inno Setup) | $99/ano (Developer ID) |

### 9.7 Recursos Adicionais

**Documentação Oficial:**
- [Apple Developer - Packaging and Distribution](https://developer.apple.com/documentation/xcode/packaging-and-distributing-apps)
- [Notarizing macOS Software](https://developer.apple.com/documentation/security/notarizing-macos-software-before-distribution)
- [pkgbuild Man Page](https://keith.github.io/xcode-man-pages/pkgbuild.1.html)

**Ferramentas:**
- [create-dmg (sindresorhus)](https://github.com/sindresorhus/create-dmg)
- [Package Builder](https://www.araelium.com/packagebuilder)
- [Packages (freeware)](http://s.sudre.free.fr/Software/Packages/about.html)

**Tutoriais:**
- [How to make macOS installers with pkgbuild and productbuild](https://moonbase.sh/articles/how-to-make-macos-installers-for-juce-projects-with-pkgbuild-and-productbuild/)
- [The Easiest Way to Build macOS Installer](https://medium.com/swlh/the-easiest-way-to-build-macos-installer-for-your-application-34a11dd08744)

**Comunidade:**
- Apple Developer Forums
- Stack Overflow (tag: macos-installer)
- Reddit: r/macOSApps

---

## Conclusão

Criar um instalador para macOS equivalente ao Inno Setup do Windows envolve:

1. **Usar PKG** para instalação complexa (equivalente ao .exe)
2. **Embalar em DMG** para apresentação visual
3. **Homebrew** para instalação de dependências
4. **Code signing + Notarização** (obrigatório)
5. **distribution.xml** para customizar wizard
6. **Scripts postinstall** para configuração automática

**O processo é mais complexo que no Windows**, principalmente devido à:
- Necessidade de Developer ID ($99/ano)
- Notarização obrigatória
- Duas ferramentas (PKG + DMG) em vez de uma
- CLI em vez de GUI (para build automatizado)

**Mas o resultado é mais profissional**, com:
- Instalador nativo do macOS
- Verificação de segurança pela Apple
- Experiência consistente com outros apps Mac
- Distribuição confiável fora da Mac App Store

**Para o Sleep Agent especificamente:**
- PKG que instala via Homebrew é a melhor abordagem
- DMG com visual bonito para primeira impressão
- Scripts automatizados para CI/CD
- Documentação clara para usuários finais

---

**Próximos Passos Sugeridos:**

1. Configurar Apple Developer Program
2. Criar protótipo de PKG com pkgbuild
3. Testar notarização
4. Criar DMG visual
5. Automatizar build
6. Testar em diferentes versões macOS
7. Documentar processo
8. Lançar versão beta

---

## Sources

**Formatos de Instaladores:**
- [Application Packaging and Deploying for macOS in Simple Words](https://apptimized.com/en/news/application-packaging-and-deploying-for-macos-in-simple-words/)
- [DMG vs PKG: Why DMGs Aren't Enterprise-Ready](https://apptimized.com/en/news/dmg-vs-pkg-why-dmgs-arent-enterprise-ready/)
- [Apple IT Essentials: PKGs and Software Deployment](https://the-sequence.com/packages-pkgs)
- [.PKG vs .DMG Files: Understanding the Differences on macOS](https://www.allinthedifference.com/difference-between-pkg-and-dmg/)

**Ferramentas de Criação:**
- [Pkgbuild and productbuild tutorial](https://forum.juce.com/t/pkgbuild-and-productbuild-a-tutorial-pamplejuce-example/64977)
- [How to make macOS installers with pkgbuild and productbuild](https://moonbase.sh/articles/how-to-make-macos-installers-for-juce-projects-with-pkgbuild-and-productbuild/)
- [The Easiest Way to Build macOS Installer](https://medium.com/swlh/the-easiest-way-to-build-macos-installer-for-your-application-34a11dd08744)
- [Package Builder Official Site](https://www.araelium.com/packagebuilder)
- [Using Packages to create an installer](https://www.appcoda.com/packages-macos-apps-distribution/)

**create-dmg:**
- [create-dmg/create-dmg GitHub](https://github.com/create-dmg/create-dmg)
- [sindresorhus/create-dmg GitHub](https://github.com/sindresorhus/create-dmg)
- [DMG Canvas GitHub](https://github.com/DMG-Canvas-Mac/dmg-canvas-osx)
- [DropDMG Official Site](https://c-command.com/dropdmg/)

**Instalação de Dependências:**
- [Mac Web Developer Setup](https://dev.to/ceceliacreates/mac-web-developer-setup-terminal-zsh-git-node-vs-code-homebrew-and-github-cli-1p5b)
- [macOS Scripted Setup](https://swissmacuser.ch/macos-scripted-setup-automate-user-settings-app-installations/)
- [macOS setup automation with Homebrew](https://www.lotharschulz.info/2021/05/11/macos-setup-automation-with-homebrew/)

**Homebrew:**
- [Homebrew Official Site](https://brew.sh/)
- [Homebrew Documentation](https://docs.brew.sh/Installation)
- [Automating your macOS setup with Homebrew and Cask](https://medium.com/macoclock/automating-your-macos-setup-with-homebrew-and-cask-e2a103b51af1)
- [GitHub - Homebrew/homebrew-cask](https://github.com/Homebrew/homebrew-cask)

**Code Signing e Notarização:**
- [Signing Mac Software with Developer ID](https://developer.apple.com/developer-id/)
- [Notarizing macOS software before distribution](https://developer.apple.com/documentation/security/notarizing-macos-software-before-distribution)
- [macOS Code Signing | Tauri](https://v2.tauri.app/distribute/sign/macos/)
- [Code Signing and Notarization on macOS](https://www.msweet.org/blog/2020-12-10-macos-notarization.html)

**Gatekeeper:**
- [Gatekeeper and runtime protection in macOS](https://support.apple.com/guide/security/gatekeeper-and-runtime-protection-sec5599b66df/web)
- [Safely open apps on your Mac](https://support.apple.com/en-us/102445)
- [macOS Sequoia removes the Control-click method to bypass Gatekeeper](https://www.idownloadblog.com/2024/08/07/apple-macos-sequoia-gatekeeper-change-install-unsigned-apps-mac/)

**Scripts e Configuração:**
- [Understand pre-install and post-install scripts for macOS](https://techcommunity.microsoft.com/blog/intunecustomersuccess/understand-pre-install-and-post-install-scripts-for-macos-in-microsoft-intune/4377799)
- [Complete Guide to macOS Shell Configuration](https://osxhub.com/macos-shell-configuration-zsh-environment-variables/)
- [Shell Configuration · Zsh Mac · 2026](https://mac.install.guide/terminal/configuration)

**Estrutura de Diretórios:**
- [macOS Library Directory Details](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/MacOSXDirectories/MacOSXDirectories.html)
- [Where to Put Application Files](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFileSystem/Articles/WhereToPutFiles.html)

**Best Practices:**
- [DMG vs PKG File Formats: Key Differences](https://85ideas.com/blog/dmg-vs-pkg-file-formats-key-differences-and-how-to-use-them-on-mac/)
- [macOS Application Packaging Best Practices](https://developer.jamf.com/developer-guide/docs/macos-application-packaging-best-practices)

**Desinstalação:**
- [Best Mac uninstaller in 2026](https://macpaw.com/reviews/best-uninstallers-for-mac)
- [How to completely uninstall programs on a Mac](https://setapp.com/how-to/how-to-uninstall-apps-on-mac)
- [How to uninstall apps on Mac: 2025 complete guide](https://macpaw.com/how-to/uninstall-apps-on-mac-os-x)
