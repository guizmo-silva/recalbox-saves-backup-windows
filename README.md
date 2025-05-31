# 🎮 Recalbox Backup Script for Windows

<div align="center">

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Batch](https://img.shields.io/badge/batch-%23121011.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

**Script completo em Batch para backup e restauração de saves do Recalbox no Windows**

*Complete Batch script for Recalbox saves backup and restore on Windows*

*Script completo en Batch para respaldo y restauración de saves de Recalbox en Windows*

</div>

---

## 📋 Índice / Index / Índice

### 🇧🇷 Português
- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Ferramentas Utilizadas](#-ferramentas-utilizadas)

### 🇺🇸 English
- [About the Project](#-about-the-project)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [How to Use](#-how-to-use)
- [Tools Used](#-tools-used)

### 🇪🇸 Español
- [Sobre el Proyecto](#-sobre-el-proyecto)
- [Características](#-características)
- [Prerrequisitos](#-prerrequisitos)
- [Instalación](#-instalación)
- [Cómo Usar](#-cómo-usar)
- [Herramientas Utilizadas](#-herramientas-utilizadas)

---

## 🇧🇷 Português

### 🎯 Sobre o Projeto

O **Recalbox Backup Script for Windows** é uma solução completa e intuitiva para gerenciar os saves dos seus jogos no Recalbox diretamente do Windows. Com interface multilíngue e detecção automática de ferramentas do sistema, este script oferece uma experiência simples e confiável para proteger seus progressos de jogo.

### ✨ Funcionalidades

- 🔍 **Verificação de Dependências**: Detecta automaticamente ferramentas disponíveis no Windows
- 📡 **Verificação de Conectividade**: Testa conexão com o Recalbox na rede local
- 💾 **Backup Completo**: Cria backups organizados com timestamp automático
- 🔄 **Restauração Inteligente**: Restaura saves seletivamente com múltiplos métodos
- 🌍 **Interface Multilíngue**: Português, Inglês e Espanhol
- 🎨 **Interface Colorida**: Suporte a cores no Windows 10/11 com fallback
- 🛡️ **Múltiplos Fallbacks**: Robocopy → XCOPY → Cópia manual para máxima compatibilidade

### 📋 Pré-requisitos

- Windows 7 ou superior
- Recalbox na mesma rede local
- Compartilhamento SMB habilitado no Recalbox
- Acesso ao caminho `\\RECALBOX\share\saves`

#### 🛠️ Ferramentas do Sistema

O script utiliza ferramentas nativas do Windows (nenhuma instalação adicional necessária):

| Ferramenta | Função | Disponibilidade |
|------------|--------|----------------|
| **Robocopy** | Cópia principal com suporte a estruturas complexas | Windows Vista+ |
| **XCOPY** | Fallback para cópia de arquivos | Todas as versões |
| **PowerShell** | Cores e operações avançadas | Windows 7+ |
| **NET** | Verificação de compartilhamentos SMB | Nativo |
| **PING** | Teste de conectividade | Nativo |

> **💡 Vantagem:** Todas as ferramentas já estão incluídas no Windows! Não precisa instalar nada adicional.

### 🚀 Instalação

1. **Baixe o script:**
```cmd
# Opção 1: Download direto
https://raw.githubusercontent.com/seu-usuario/recalbox-backup-windows/main/recalbox_backup.bat

# Opção 2: Clone o repositório
git clone https://github.com/seu-usuario/recalbox-backup-windows.git
```

2. **Execute o script:**
```cmd
# Duplo clique no arquivo recalbox_backup.bat
# OU execute via linha de comando:
recalbox_backup.bat
```

### 📖 Como Usar

1. **Execute o script** com duplo clique
2. **Escolha seu idioma** preferido (Português/Inglês/Espanhol)
3. **Use o menu** para suas operações:
   - **Opção 1**: Verificar dependências do sistema
   - **Opção 2**: Verificar conectividade e caminho dos saves
   - **Opção 3**: Realizar backup completo
   - **Opção 4**: Restaurar saves seletivamente
   - **Opção 5**: Sair

#### 💾 Estrutura do Backup:
```
C:\Meus Backups\
└── recalbox_saves_backup_20240101_1430\
    ├── atari2600\
    │   ├── game1.sav
    │   └── game2.sav
    ├── nes\
    │   └── saves\
    └── snes\
        ├── saves\
        └── states\
```

### 🛠️ Ferramentas Utilizadas

#### **Robocopy (Recomendado)**
- **Função**: Cópia robusta de arquivos e pastas
- **Vantagens**: Suporte a estruturas complexas, múltiplos threads, recuperação de erros
- **Parâmetros**: `/E /COPYALL /R:1 /W:1 /MT:4`

#### **XCOPY (Fallback)**
- **Função**: Cópia tradicional de arquivos
- **Vantagens**: Disponível em todas as versões do Windows
- **Parâmetros**: `/E /I /H /Y /C /Q`

#### **PowerShell (Opcional)**
- **Função**: Cores na interface e operações avançadas
- **Vantagens**: Melhor experiência visual
- **Fallback**: Interface sem cores se não disponível

### 🔧 Solução de Problemas

#### Problemas Comuns:

**❌ "Não foi possível conectar ao Recalbox"**
- Verifique se o Recalbox está ligado e conectado à rede
- Confirme que seu PC está na mesma rede
- Teste: `ping RECALBOX` no CMD

**❌ "Pasta 'saves' não encontrada"**
- Habilite o compartilhamento de rede no Recalbox
- Vá em: Sistema → Configurações de Rede → Ativar SAMBA
- Teste acessar `\\RECALBOX` no Explorer

**❌ "Erro na criação do arquivo"**
- O script usa múltiplos métodos automaticamente
- Estruturas complexas são tratadas com cópia manual
- Verifique permissões de escrita no destino

**❌ "Comando não encontrado"**
- Execute a verificação de dependências (Opção 1)
- Todas as ferramentas são nativas do Windows

---

## 🇺🇸 English

### 🎯 About the Project

The **Recalbox Backup Script for Windows** is a complete and intuitive solution for managing your Recalbox game saves directly from Windows. With multilingual interface and automatic system tools detection, this script offers a simple and reliable experience to protect your game progress.

### ✨ Features

- 🔍 **Dependency Check**: Automatically detects available Windows tools
- 📡 **Connectivity Verification**: Tests connection with Recalbox on local network
- 💾 **Complete Backup**: Creates organized backups with automatic timestamp
- 🔄 **Smart Restoration**: Selectively restores saves with multiple methods
- 🌍 **Multilingual Interface**: Portuguese, English, and Spanish
- 🎨 **Colored Interface**: Color support on Windows 10/11 with fallback
- 🛡️ **Multiple Fallbacks**: Robocopy → XCOPY → Manual copy for maximum compatibility

### 📋 Prerequisites

- Windows 7 or higher
- Recalbox on the same local network
- SMB sharing enabled on Recalbox
- Access to path `\\RECALBOX\share\saves`

#### 🛠️ System Tools

The script uses native Windows tools (no additional installation required):

| Tool | Function | Availability |
|------|----------|--------------|
| **Robocopy** | Primary copy with complex structure support | Windows Vista+ |
| **XCOPY** | Fallback for file copying | All versions |
| **PowerShell** | Colors and advanced operations | Windows 7+ |
| **NET** | SMB share verification | Native |
| **PING** | Connectivity testing | Native |

> **💡 Advantage:** All tools are already included in Windows! No additional installation needed.

### 🚀 Installation

1. **Download the script:**
```cmd
# Option 1: Direct download
https://raw.githubusercontent.com/your-username/recalbox-backup-windows/main/recalbox_backup.bat

# Option 2: Clone repository
git clone https://github.com/your-username/recalbox-backup-windows.git
```

2. **Run the script:**
```cmd
# Double-click the recalbox_backup.bat file
# OR run via command line:
recalbox_backup.bat
```

### 📖 How to Use

1. **Run the script** by double-clicking
2. **Choose your preferred language** (Portuguese/English/Spanish)
3. **Use the menu** for your operations:
   - **Option 1**: Check system dependencies
   - **Option 2**: Check connectivity and saves path
   - **Option 3**: Perform complete backup
   - **Option 4**: Restore saves selectively
   - **Option 5**: Exit

#### 💾 Backup Structure:
```
C:\My Backups\
└── recalbox_saves_backup_20240101_1430\
    ├── atari2600\
    │   ├── game1.sav
    │   └── game2.sav
    ├── nes\
    │   └── saves\
    └── snes\
        ├── saves\
        └── states\
```

### 🛠️ Tools Used

#### **Robocopy (Recommended)**
- **Function**: Robust file and folder copying
- **Advantages**: Complex structure support, multi-threading, error recovery
- **Parameters**: `/E /COPYALL /R:1 /W:1 /MT:4`

#### **XCOPY (Fallback)**
- **Function**: Traditional file copying
- **Advantages**: Available on all Windows versions
- **Parameters**: `/E /I /H /Y /C /Q`

#### **PowerShell (Optional)**
- **Function**: Interface colors and advanced operations
- **Advantages**: Better visual experience
- **Fallback**: Colorless interface if not available

### 🔧 Troubleshooting

#### Common Issues:

**❌ "Could not connect to Recalbox"**
- Check if Recalbox is powered on and connected to network
- Confirm your PC is on the same network
- Test: `ping RECALBOX` in CMD

**❌ "'saves' folder not found"**
- Enable network sharing on Recalbox
- Go to: System → Network Settings → Enable SAMBA
- Test accessing `\\RECALBOX` in Explorer

**❌ "File creation error"**
- Script uses multiple methods automatically
- Complex structures are handled with manual copying
- Check write permissions on destination

**❌ "Command not found"**
- Run dependency check (Option 1)
- All tools are native to Windows

---

## 🇪🇸 Español

### 🎯 Sobre el Proyecto

El **Recalbox Backup Script for Windows** es una solución completa e intuitiva para gestionar las partidas guardadas de tus juegos en Recalbox directamente desde Windows. Con interfaz multiidioma y detección automática de herramientas del sistema, este script ofrece una experiencia simple y confiable para proteger tu progreso de juego.

### ✨ Características

- 🔍 **Verificación de Dependencias**: Detecta automáticamente herramientas disponibles en Windows
- 📡 **Verificación de Conectividad**: Prueba conexión con Recalbox en la red local
- 💾 **Respaldo Completo**: Crea respaldos organizados con timestamp automático
- 🔄 **Restauración Inteligente**: Restaura saves selectivamente con múltiples métodos
- 🌍 **Interfaz Multiidioma**: Portugués, Inglés y Español
- 🎨 **Interfaz Colorida**: Soporte de colores en Windows 10/11 con fallback
- 🛡️ **Múltiples Fallbacks**: Robocopy → XCOPY → Copia manual para máxima compatibilidad

### 📋 Prerrequisitos

- Windows 7 o superior
- Recalbox en la misma red local
- Compartir SMB habilitado en Recalbox
- Acceso a la ruta `\\RECALBOX\share\saves`

#### 🛠️ Herramientas del Sistema

El script utiliza herramientas nativas de Windows (no requiere instalación adicional):

| Herramienta | Función | Disponibilidad |
|-------------|---------|----------------|
| **Robocopy** | Copia principal con soporte a estructuras complejas | Windows Vista+ |
| **XCOPY** | Fallback para copia de archivos | Todas las versiones |
| **PowerShell** | Colores y operaciones avanzadas | Windows 7+ |
| **NET** | Verificación de recursos compartidos SMB | Nativo |
| **PING** | Prueba de conectividad | Nativo |

> **💡 Ventaja:** ¡Todas las herramientas ya están incluidas en Windows! No necesita instalación adicional.

### 🚀 Instalación

1. **Descarga el script:**
```cmd
# Opción 1: Descarga directa
https://raw.githubusercontent.com/tu-usuario/recalbox-backup-windows/main/recalbox_backup.bat

# Opción 2: Clonar repositorio
git clone https://github.com/tu-usuario/recalbox-backup-windows.git
```

2. **Ejecuta el script:**
```cmd
# Doble clic en el archivo recalbox_backup.bat
# O ejecuta via línea de comandos:
recalbox_backup.bat
```

### 📖 Cómo Usar

1. **Ejecuta el script** con doble clic
2. **Elige tu idioma** preferido (Portugués/Inglés/Español)
3. **Usa el menú** para tus operaciones:
   - **Opción 1**: Verificar dependencias del sistema
   - **Opción 2**: Verificar conectividad y ruta de saves
   - **Opción 3**: Realizar respaldo completo
   - **Opción 4**: Restaurar saves selectivamente
   - **Opción 5**: Salir

#### 💾 Estructura del Respaldo:
```
C:\Mis Respaldos\
└── recalbox_saves_backup_20240101_1430\
    ├── atari2600\
    │   ├── game1.sav
    │   └── game2.sav
    ├── nes\
    │   └── saves\
    └── snes\
        ├── saves\
        └── states\
```

### 🛠️ Herramientas Utilizadas

#### **Robocopy (Recomendado)**
- **Función**: Copia robusta de archivos y carpetas
- **Ventajas**: Soporte a estructuras complejas, multi-threading, recuperación de errores
- **Parámetros**: `/E /COPYALL /R:1 /W:1 /MT:4`

#### **XCOPY (Fallback)**
- **Función**: Copia tradicional de archivos
- **Ventajas**: Disponible en todas las versiones de Windows
- **Parámetros**: `/E /I /H /Y /C /Q`

#### **PowerShell (Opcional)**
- **Función**: Colores en la interfaz y operaciones avanzadas
- **Ventajas**: Mejor experiencia visual
- **Fallback**: Interfaz sin colores si no está disponible

### 🔧 Solución de Problemas

#### Problemas Comunes:

**❌ "No se pudo conectar a Recalbox"**
- Verifica que Recalbox esté encendido y conectado a la red
- Confirma que tu PC está en la misma red
- Prueba: `ping RECALBOX` en CMD

**❌ "Carpeta 'saves' no encontrada"**
- Habilita el compartir de red en Recalbox
- Ve a: Sistema → Configuración de Red → Activar SAMBA
- Prueba acceder a `\\RECALBOX` en el Explorer

**❌ "Error en la creación del archivo"**
- El script usa múltiples métodos automáticamente
- Estructuras complejas se manejan con copia manual
- Verifica permisos de escritura en el destino

**❌ "Comando no encontrado"**
- Ejecuta la verificación de dependencias (Opción 1)
- Todas las herramientas son nativas de Windows

---

## 🤝 Contribuindo / Contributing / Contribuyendo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

Contributions are welcome! Feel free to open issues or pull requests.

¡Las contribuciones son bienvenidas! Siéntete libre de abrir issues o pull requests.

## 📄 Licença / License / Licencia

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

This project is under the MIT license. See the `LICENSE` file for more details.

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

## 🔗 Links Relacionados / Related Links / Enlaces Relacionados

- 🐧 [Versão Linux](https://github.com/seu-usuario/recalbox-backup-script) - Script para sistemas Linux
- 🎮 [Recalbox Official](https://www.recalbox.com/) - Site oficial do Recalbox
- 📚 [Documentação](https://wiki.recalbox.com/) - Wiki oficial do Recalbox

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela!**

**⭐ If this project was helpful, consider giving it a star!**

**⭐ ¡Si este proyecto fue útil, considera darle una estrella!**

</div>
