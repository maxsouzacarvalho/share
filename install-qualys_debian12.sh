#!/bin/bash

# ================================================
# Script de instalação do Qualys Cloud Agent
# Compatível com Debian/Ubuntu e CentOS/Rocky Linux
# ================================================

# Dados de instalação
QUALYS_URL_DEB="https://raw.githubusercontent.com/maxsouzacarvalho/share/refs/heads/main/QualysCloudAgent.deb"
ACTIVATION_ID="0f01d689-bd5d-4f81-897b-a35092eedec4"
CUSTOMER_ID="e591ced3-984d-4076-82dd-4d7e36c79036"
SERVER_URI="https://qagpublic.qg2.apps.qualys.com/CloudAgent"


    wget -O QualysCloudAgent.deb "$QUALYS_URL_DEB"
    sudo dpkg --install QualysCloudAgent.deb


# Ativação
sudo /usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
    ActivationId="$ACTIVATION_ID" \
    CustomerId="$CUSTOMER_ID" \
    ServerUri="$SERVER_URI"

# Ativar no boot e iniciar
sudo systemctl enable qualys-cloud-agent
sudo systemctl start qualys-cloud-agent

# Verifica status
echo "[INFO] Verificando status do Qualys Cloud Agent..."
sudo systemctl status qualys-cloud-agent --no-pager

# Confirma se o binário está acessível
if [ -x "/usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh" ]; then
    echo "[OK] Qualys instalado e ativo."
else
    echo "[ERRO] Qualys não foi instalado corretamente."
    exit 2
fi
