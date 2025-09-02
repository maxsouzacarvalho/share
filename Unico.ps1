# =================================================================================
# SCRIPT COMPLETO v3: DESINSTALA��O, INSTALA��O E CONFIGURA��O DO QUALYS AGENT E QGS
#
# Descri��o:
# - Vers�o com corre��es de compatibilidade para cria��o de arquivo tempor�rio
#   e importa��o de certificado.
# =================================================================================

# ============================ IN�CIO DA CONFIGURA��O ============================

# --- Configura��es do Instalador ---
$installerPath = "\\SRV-AD-FUNDAO\netlogon\Softwares\QualysCloudAgent.exe"
$installerArgs = "CustomerId={e591ced3-984d-4076-82dd-4d7e36c79036} ActivationId={0f01d689-bd5d-4f81-897b-a35092eedec4} WebServiceUri=https://qagpublic.qg2.apps.qualys.com/CloudAgent/"

# --- Configura��es do Qualys Gateway Server (QGS) ---
$QGS = "10.0.64.24:8080"
$PEM = @"
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
"@

# ============================ FIM DA CONFIGURA��O =============================

# ------------------------------------------------------------------------------
## FASE 1: Verifica��o e Remo��o (Sem altera��es)
# ------------------------------------------------------------------------------
Write-Host "[FASE 1] Preparando o ambiente para o Agente Qualys..." -ForegroundColor Yellow
$uninstallerPath = @("C:\Program Files\Qualys\QualysAgent\Uninstall.exe", "C:\Program Files (x86)\Qualys\QualysAgent\Uninstall.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($uninstallerPath) {
    Write-Host "[INFO] Instala��o anterior do Qualys encontrada em '$uninstallerPath'." -ForegroundColor Cyan
    Write-Host "[A��O] Parando o servi�o QualysAgent..."
    try { Get-Service -Name "QualysAgent" -ErrorAction Stop | Stop-Service -Force -ErrorAction Stop; Write-Host "[SUCESSO] Servi�o parado." -ForegroundColor Green; Start-Sleep -Seconds 5 } catch { Write-Host "[AVISO] Servi�o n�o estava ativo ou n�o foi encontrado." -ForegroundColor Yellow }
    Write-Host "[A��O] Executando desinstalador e aguardando..."
    try { Start-Process -FilePath $uninstallerPath -Wait -ErrorAction Stop; Write-Host "[SUCESSO] Desinstalador conclu�do." -ForegroundColor Green; Start-Sleep -Seconds 10 } catch { Write-Host "[ERRO] Falha ao executar o desinstalador." -ForegroundColor Red }
} else { Write-Host "[INFO] Nenhuma instala��o anterior do Qualys foi encontrada." -ForegroundColor Cyan }

# ------------------------------------------------------------------------------
## FASE 2: Instala��o (Sem altera��es)
# ------------------------------------------------------------------------------
Write-Host "`n[FASE 2] Instalando o Agente Qualys..." -ForegroundColor Yellow
if (-not (Test-Path -Path $installerPath)) {
    Write-Host "[ERRO] O instalador n�o foi encontrado em '$installerPath'." -ForegroundColor Red
} else {
    Write-Host "[A��O] Iniciando a instala��o a partir da rede..."
    try {
        Start-Process -FilePath $installerPath -ArgumentList $installerArgs -ErrorAction Stop
        Write-Host "[SUCESSO] Comando de instala��o enviado. Aguardando 20 segundos para inicializa��o..." -ForegroundColor Green
        Start-Sleep -Seconds 20
    } catch { Write-Host "[ERRO] Falha ao iniciar o processo de instala��o: $($_.Exception.Message)" -ForegroundColor Red }
}

# ------------------------------------------------------------------------------
## FASE 3: Configura��o do Gateway (QGS) - VERS�O CORRIGIDA
# ------------------------------------------------------------------------------
Write-Host "`n[FASE 3] Configurando o Certificado e Proxy do Gateway (QGS)..." -ForegroundColor Yellow

# --- 3.1: Instala��o do Certificado ---
$certExists = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*qgs.proxy*" }
if (-not $certExists) {
    Write-Host "[A��O] Certificado do QGS n�o encontrado. Instalando..."
    
    # ***** ALTERA��O 1: Usar C:\Windows\Temp como local do arquivo *****
    $tempCertFile = "C:\Windows\Temp\Qualys-QGS-Cert.pem"
    
    try {
        $PEM | Out-File -FilePath $tempCertFile -Encoding ascii -Force
        
        # ***** ALTERA��O 2: Usar certutil.exe para m�xima compatibilidade *****
        certutil.exe -addstore -f "Root" $tempCertFile
        
        Write-Host "[SUCESSO] Certificado do QGS instalado na m�quina local." -ForegroundColor Green
    } catch {
        Write-Host "[ERRO] Falha ao instalar o certificado: $($_.Exception.Message)" -ForegroundColor Red
    } finally {
        # Limpeza do arquivo tempor�rio
        if (Test-Path $tempCertFile) { Remove-Item $tempCertFile -Force }
    }
} else { Write-Host "[INFO] Certificado do QGS j� est� instalado." -ForegroundColor Cyan }

# --- 3.2: Configura��o do Proxy (Sem altera��es) ---
$qualysProxyPath = @("C:\Program Files\Qualys\QualysAgent\QualysProxy.exe", "C:\Program Files (x86)\Qualys\QualysAgent\QualysProxy.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($qualysProxyPath) {
    $proxyConfigured = & $qualysProxyPath /c | Select-String -Pattern $QGS -Quiet
    if (-not $proxyConfigured) {
        Write-Host "[A��O] Configurando o agente para usar o proxy QGS: $QGS"
        try { & $qualysProxyPath /u $QGS; Write-Host "[SUCESSO] Proxy QGS configurado." -ForegroundColor Green } catch { Write-Host "[ERRO] Falha ao configurar o proxy: $($_.Exception.Message)" -ForegroundColor Red }
    } else { Write-Host "[INFO] Proxy QGS j� est� configurado corretamente." -ForegroundColor Cyan }
} else { Write-Host "[AVISO] 'QualysProxy.exe' n�o foi encontrado. A instala��o pode ter falhado." -ForegroundColor Yellow }

# ------------------------------------------------------------------------------
## FIM: Pausa para Verifica��o
# ------------------------------------------------------------------------------
Write-Host "`n[FIM] Processo conclu�do." -ForegroundColor Green
Read-Host -Prompt "Pressione ENTER para fechar esta janela..."