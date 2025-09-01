#!/bin/bash
set -euo pipefail

# =============================================
# Script de instalação Auditd + Sysmon + Rsyslog
# Compatível com Debian/Ubuntu e CentOS/RHEL/Rocky/AlmaLinux
# =============================================

LOG_SERVER_IP="172.18.16.5"
LOG_SERVER_PORT="6515"   # Porta para Linux
TMP_DIR="/tmp"

# Função para erros
fail() {
    echo "[ERRO] $1"
    exit 1
}

# Detectando sistema operacional
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
else
    fail "Não foi possível identificar o sistema operacional!"
fi

# Determinando gerenciador de pacotes
if [[ "$OS_ID" =~ (debian|ubuntu) ]]; then
    PKG_MGR="apt"
elif [[ "$OS_ID" =~ (rhel|centos|rocky|almalinux) ]]; then
    PKG_MGR="yum"
else
    fail "Distribuição $OS_ID não suportada!"
fi

# ================================
# Instalação do AUDITD
# ================================
echo "--------------------------------------------"
echo "[2/4] Instalando Auditd..."
echo "--------------------------------------------"

if [ "$PKG_MGR" = "apt" ]; then
    apt install -y auditd audispd-plugins || fail "Erro ao instalar auditd!"
elif [ "$PKG_MGR" = "yum" ]; then
    yum install -y audit audit-libs audispd-plugins || fail "Erro ao instalar auditd!"
fi

systemctl enable auditd
systemctl start auditd
systemctl status auditd --no-pager

echo "[OK] Auditd instalado e em execução!"
sleep 2

# ================================
# Instalação do SYSMON
# ================================
echo "--------------------------------------------"
echo "[3/4] Instalando Sysmon..."
echo "--------------------------------------------"

if [ "$PKG_MGR" = "apt" ]; then
    # Adicionar repositório Microsoft
    wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O $TMP_DIR/packages-microsoft-prod.deb
    dpkg -i $TMP_DIR/packages-microsoft-prod.deb 2>/dev/null
    apt update -y

    if apt install -y sysmonforlinux 2>/dev/null; then
        echo "[OK] Sysmon instalado via apt!"
    else
        echo "[INFO] Instalando Sysmon manualmente..."
        rm -f /etc/apt/sources.list.d/microsoft-prod.list
        apt update -y
        cd $TMP_DIR
        LATEST_URL=$(curl -s https://api.github.com/repos/Sysinternals/SysmonForLinux/releases/latest | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4)
        wget "$LATEST_URL" -O sysmonforlinux_amd64.deb || fail "Erro ao baixar Sysmon!"
        apt install -y libxml2 libcap2
        dpkg -i sysmonforlinux_amd64.deb || fail "Erro ao instalar Sysmon manualmente!"
    fi

elif [ "$PKG_MGR" = "yum" ]; then
    yum install -y libxml2 libcap || fail "Erro ao instalar dependências do Sysmon!"
    cd $TMP_DIR
    LATEST_URL=$(curl -s https://api.github.com/repos/Sysinternals/SysmonForLinux/releases/latest | grep browser_download_url | grep x86_64.rpm | cut -d '"' -f 4)
    wget "$LATEST_URL" -O sysmonforlinux_x86_64.rpm || fail "Erro ao baixar Sysmon!"
    yum localinstall -y sysmonforlinux_x86_64.rpm || fail "Erro ao instalar Sysmon!"
fi

# Ativar Sysmon
sysmon -i || echo "[AVISO] Configuração padrão aplicada ao Sysmon."
systemctl enable sysmon
systemctl start sysmon
systemctl status sysmon --no-pager

echo "[OK] Sysmon instalado e em execução!"
sleep 2

# ================================
# Configuração do RSYSLOG
# ================================
echo "--------------------------------------------"
echo "[4/4] Configurando Rsyslog para enviar logs..."
echo "--------------------------------------------"

RSYSLOG_CONF="/etc/rsyslog.d/99-remote.conf"
echo "*.* @$LOG_SERVER_IP:$LOG_SERVER_PORT" > "$RSYSLOG_CONF"
systemctl restart rsyslog

echo "[OK] Rsyslog configurado para enviar logs para $LOG_SERVER_IP:$LOG_SERVER_PORT"

echo "--------------------------------------------"
echo "Instalação finalizada com sucesso!"
echo "--------------------------------------------"
echo "➡ Auditd logs: /var/log/audit/audit.log"
echo "➡ Sysmon status: systemctl status sysmon"
echo "➡ Rsyslog status: systemctl status rsyslog"

