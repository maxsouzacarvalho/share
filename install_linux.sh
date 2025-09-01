#!/bin/bash

#   Variaveis Importantes
#       PEM - Cadeia Textual do certificado .pem de comunicacao Agent x QGS
#       QGS - Endereco do servidor GQS com porta (1080 - Proxy) ou (8080 - Cache)

QGS="qualys_https_proxy=http://10.0.64.24:8080"

PEM="-----BEGIN CERTIFICATE-----
MIIF+zCCA+OgAwIBAgICDJkwDQYJKoZIhvcNAQELBQAwgY0xEjAQBgNVBAMMCXFn\n
cy5wcm94eTELMAkGA1UEBhMCVVMxDzANBgNVBAoMBlF1YWx5czEPMA0GA1UECwwG\n
cXVhbHlzMRMwEQYDVQQIDApDYWxpZm9ybmlhMR0wGwYJKoZIhvcNAQkBFg5xZ3NA\n
cXVhbHlzLmNvbTEUMBIGA1UEBwwLRm9zdGVyIENpdHkwHhcNMjUwNzMxMTgzNzEx\n
WhcNMzUwNzMwMTgzNzExWjCBjTESMBAGA1UEAwwJcWdzLnByb3h5MQswCQYDVQQG\n
EwJVUzEPMA0GA1UECgwGUXVhbHlzMQ8wDQYDVQQLDAZxdWFseXMxEzARBgNVBAgM\n
CkNhbGlmb3JuaWExHTAbBgkqhkiG9w0BCQEWDnFnc0BxdWFseXMuY29tMRQwEgYD\n
VQQHDAtGb3N0ZXIgQ2l0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB\n
ALBMZB1q/jof9UG1qq+IqEXHTj1IPDv1l5BROOIHABELRDkf0P+GWHCSJ1aoX5ty\n
0rX832MZPpIuTU7M2pPaa8Fp2llfCG1c3gi/4m75/v0MwhQO4WzLrNzcZ2w6rIz+\n
CBOC69QTpxZd/lUnPfsIuJw6lxXHhkmmCxag9oEVpmDb6RfNdeGdoPtDTw4Kylms\n
Lo2s9GL4TErQ4yFxlZXV20YEBm1Y028rJEDjMhXOGhjQD7dj9y7LvOJu8anPtV5m\n
qFtFrIUCt/AhSGKXxSKc1g5LoexE2IMVWcB/gSnx62uaJ9JPLZ8Kpo4Mk/hoDb87\n
uJiPMvKwPSN0+Kw5uqnnDvyyA1Kxle/HR2TGu3DQYx88d7J3SfW8poixu5D32iOG\n
UJkfDkaG7iEWddLJ8Fncz9NXlsCYDT+zh1VbJ41WJ6KmL4hn7etHwcH10K1nAPGh\n
1P1W2PuEJcBXxHdDjxecNU9sycufne4lDVAGp7haS5Ymp9k9Xq6D1RyQX9pCyrBT\n
tQpigjd3eChqJ9eS8zWGY3hDnsFw9Id8RSNwqQsf6ObgdCTJcVJnn/6p4cxI6SSC\n
ktd6bVBnKTmraBnJ4/IF+2DriOQVohX0JIYffvJOhtB1yfeLpYKEV/v4o9lAZJJv\n
U+kP8EpJlQ6Ntp/iFVZV9WZkgXtSaZVQPaRkptfgFVbtrP+SvOHJYFGQKpq0Tvp0\n
vXNj8YX87geAsYOC1b4HPASC7ffbyHXgJklkYeeowEWw0AG5J4ydfNpvjwuFaRWO\n
hHMtFAya47o02o027Hyz1+XV+PIRfKHoK5b++ecLqnKwWV9RngQhbRcPB6WXGuAf\n
4kBS9rbg/Y/kJUKfeoBQQ+QL6z5Oyp2xUcyixaJpnMCgKW8OIXR00zU/xiVBaFA=\n
-----END CERTIFICATE-----"


if [ -d /usr/share/ca-certificates/ ]; then 
    if [ ! -f /usr/share/ca-certificates/Appliance-Certificate.pem ]; then
        echo $PEM > /usr/share/ca-certificates/Appliance-Certificate.pem

        update-ca-certificates

        grep $QGS /etc/environment || echo $QGS >> /etc/environment
                          
        source /etc/environment
    
        set | grep $GQS 1>&2 > /dev/nul || source /etc/environment
    
    fi 
fi


if [ -d /etc/pki/ca-trust/source/anchors/ ]; then 
    if [ ! -f /etc/pki/ca-trust/source/anchors/Appliance-Certificate.pem ]; then
        echo $PEM > /etc/pki/ca-trust/source/anchors/Appliance-Certificate.pem

        update-ca-trust

        grep $QGS /etc/environment || echo $QGS >> /etc/environment
        
        source /etc/environment
    
        set | grep $GQS 1>&2 > /dev/nul || source /etc/environment    
    fi 
fi
