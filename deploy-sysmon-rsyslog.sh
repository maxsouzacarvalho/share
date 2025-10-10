#!/bin/bash
# Script: deploy-sysmon-rsyslog.sh
# Função: Baixar e instalar o template Sysmon para rsyslog

# === CONFIGURAÇÕES ===
GITHUB_URL="https://raw.githubusercontent.com/<usuario>/<repositorio>/main/60-sysmon-securonix.conf"
DEST_DIR="/etc/rsyslog.d"
DEST_FILE="$DEST_DIR/60-sysmon-securonix.conf"

echo "=== Implantando configuração do Sysmon para rsyslog ==="

# 1. Verifica dependências
if ! command -v curl &>/dev/null; then
    echo "Erro: curl não encontrado. Instale com: yum install curl -y"
    exit 1
fi

# 2. Baixa o arquivo do GitHub
echo "Baixando arquivo de configuração..."
curl -fsSL "$GITHUB_URL" -o /tmp/60-sysmon-securonix.conf
if [ $? -ne 0 ]; then
    echo "Erro ao baixar arquivo do GitHub. Verifique a URL."
    exit 1
fi

# 3. Copia o arquivo para o diretório do rsyslog
echo "Copiando arquivo para $DEST_DIR..."
cp /tmp/60-sysmon-securonix.conf "$DEST_FILE"
chmod 644 "$DEST_FILE"
chown root:root "$DEST_FILE"

# 4. Testa a configuração do rsyslog
echo "Validando configuração..."
rsyslogd -N1
if [ $? -ne 0 ]; then
    echo "Erro na validação do rsyslog. Abortando."
    exit 1
fi

# 5. Reinicia o serviço rsyslog
echo "Reiniciando serviço rsyslog..."
systemctl restart rsyslog
systemctl enable rsyslog
systemctl status rsyslog --no-pager

echo "✅ Implantação concluída com sucesso!"
