#!/usr/bin/env bash

SCRIPT_VERSION="1.1.0"
SCRIPT_NAME=$(basename "$0")

PAYLOAD_TYPE='mdatp_onboard'
BLOB_PAYLOAD='{
  "onboardingInfo": "{\"body\":\"{\\\"previousOrgIds\\\":[],\\\"orgId\\\":\\\"70737176-2fa7-4101-a5f2-d8e5f88179c4\\\",\\\"geoLocationUrl\\\":\\\"https://edr-eus3.us.endpoint.security.microsoft.com/edr/\\\",\\\"datacenter\\\":\\\"EastUs3\\\",\\\"vortexGeoLocation\\\":\\\"US\\\",\\\"vortexServerUrl\\\":\\\"https://us-v20.events.endpoint.security.microsoft.com/OneCollector/1.0\\\",\\\"vortexTicketUrl\\\":\\\"https://events.data.microsoft.com\\\",\\\"partnerGeoLocation\\\":\\\"GW_US\\\",\\\"version\\\":\\\"2.06\\\",\\\"deviceType\\\":\\\"Server\\\",\\\"packageGuid\\\":\\\"e74d01a1-72ba-4cb6-af79-8bdb549ad9e3\\\"}\",\"sig\":\"tOmrir/8kRX6mPSDlU/48+VguN6Le/Ww50LY3Uei/A1ZmesHo94ik20tgoqk25A5i6691bWm3X/LPmdyuRb0wAgHj9YsIqjJvgfEUa+nZIRtBVHmzQ+uPC5+TZPGMF0dl1IdYtyPOnioMBIax0VSgexV0S3aCT5e5A2me1g5+ZLsHKGG6mH7H287hHetGMYwdvjzjJZToGBeuT0CKTO28V/cuKoTctSegcaS9SBpRUtkyTpSbDCeXMH8hZ6c8jg8wjkhSbThV07OKDL0ofssTzXUlvZyNic3+CkZvVMOndOKU26diChr0C5mrH6DNjrDir98oXs1Q0itGX+CVm+SXA==\",\"sha256sig\":\"tOmrir/8kRX6mPSDlU/48+VguN6Le/Ww50LY3Uei/A1ZmesHo94ik20tgoqk25A5i6691bWm3X/LPmdyuRb0wAgHj9YsIqjJvgfEUa+nZIRtBVHmzQ+uPC5+TZPGMF0dl1IdYtyPOnioMBIax0VSgexV0S3aCT5e5A2me1g5+ZLsHKGG6mH7H287hHetGMYwdvjzjJZToGBeuT0CKTO28V/cuKoTctSegcaS9SBpRUtkyTpSbDCeXMH8hZ6c8jg8wjkhSbThV07OKDL0ofssTzXUlvZyNic3+CkZvVMOndOKU26diChr0C5mrH6DNjrDir98oXs1Q0itGX+CVm+SXA==\",\"cert\":\"MIIFgzCCA2ugAwIBAgITMwAAA8Vqrrw389R9QQAAAAADxTANBgkqhkiG9w0BAQsFADB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQgU2VjdXJlIFNlcnZlciBDQSAyMDExMB4XDTI1MDYwNTE4Mzg1NFoXDTI2MDYwNTE4Mzg1NFowHjEcMBoGA1UEAxMTU2V2aWxsZS5XaW5kb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALK407Yzv1CrrRCmkrHXFYg5j7vzDAAZtqXahgSj1HToqTBzL+rResXlGCEGRlVSpzD9GmuTivt/Xg8zgA/tg8YQOg6xC35TNM9CdtGI5Wpy0YZrs7OvbiHjUte+qQyUQMVyrjxgdgAKtBoMv8dThe27Io2hIpmoIwgVbJxe9x/Spyxz4gkjU/yiCUjYnLb/AbSEbwdppS6lAw7gEJmRNF4DYTgGlH2cFWjlhPqF4K+LqLrG2o58yg/cGs8XUYf4fYjqt2al119uJffFDy8ZPmdgYue1dgu8e/h13MDyO/3x7mcEYSlR+rjye9cIzcpR7UsQ3NoSud7fPrWCIh1GAPkCAwEAAaOCAVgwggFUMA4GA1UdDwEB/wQEAwIFIDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAeBgNVHREEFzAVghNTZXZpbGxlLldpbmRvd3MuY29tMB0GA1UdDgQWBBS1rRJqL3LT8ZgsEbqMk1zmWCe6KDAfBgNVHSMEGDAWgBQ2VollSctbmy88rEIWUE2RuTPXkTBTBgNVHR8ETDBKMEigRqBEhkJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNTZWNTZXJDQTIwMTFfMjAxMS0xMC0xOC5jcmwwYAYIKwYBBQUHAQEEVDBSMFAGCCsGAQUFBzAChkRodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY1NlY1NlckNBMjAxMV8yMDExLTEwLTE4LmNydDANBgkqhkiG9w0BAQsFAAOCAgEArhr6txmaDq+hPJiUnT6qorceW2jL1Du2nsHpQ5aCqHQw9tUpqBfhlZPy4bF0XTuxmhB5sdPYbeLYwTKdfMtfnP5Xd1MPprrhNfBEvc0LdUbSd5pusxQujdlQcXdrmsmaCybPTRQjGxCZT8fNiq18g8OF49Cn+OWrcCDjw8eCSyb1yItoBwCE+KaJg+VeEk3PPALfQdwh2GfayCruF40o1r9xLa1QOPK9jEpUIXZf7eJ48oq5gVgmX8tCch7JKX4c8VDfQtklmO9D9k6F6oSgC0enc0Tekzxr2t7Q9Gfa+gqsy6BXzikD5kaIoz0AOX4U83wZFPC7D0/Yarh3LkgfpXBUPmGv6ZGEtuGHT94eYpe7huZDeuOvSaUatiNEgrJu/jJ+94UHx6MjrkqEfxTHS2byBSLfZ7N98u7QYz78d9gtbdhJaOv0PCDDiafnO0tOjVxsumRnJfb4zhaT2FBhlPNCBU6Wayq/U3Xk/I7p/VFUcKPOP+U0rcvis9yX4npsZQ8VBhugLkWOqbIq08gduycXtnaICG8vDGuE6uWEhypkEF39bFIcEjlWaNAvG8hgaDElVAyDAeCpHVoW3xlccYCR3O6D+rMltRp7M9dg2bUPg5UJFEczcmyRfKb3LwJ2+IvCHEi7F9NDMP9Df3P3QnOvTGwRpFubuPrx/DJ6ERc=\",\"chain\":[\"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\"]}"
}'

DEBUG=0
CHANNEL=
TEMPDIR=
BLOB_PAYLOAD_FILE=
INSTALLER_SCRIPT=
DEFAULT_INSTALL=1
ONLY_ONBOARD=
PRINT_HELP=
INSTALLER_SCRIPT_URL=
ORG_ID=

SUCCESS=0
ERR_INTERNAL=1
ERR_INVALID_ARGUMENTS=2
ERR_INSUFFICIENT_PRIVILAGES=3
ERR_INSUFFICIENT_REQUIREMENTS=12
ERR_INVALID_CHANNEL=25
ERR_ONBOARDING_NOT_FOUND=30
ERR_ONBOARDING_FAILED=31

clean_up()
{
    #unset variables
    unset ORG_ID
    if [ -d "$TEMPDIR" ]; then
        rm -rf $TEMPDIR
        if [[ $? -ne 0 ]]; then
            echo "[x] Error: Unable to delete $TEMPDIR"
            echo "[*] exiting ($ERR_INSUFFICIENT_PRIVILAGES)"
            exit $ERR_INSUFFICIENT_PRIVILAGES
        fi
    fi
}

trap clean_up EXIT

usage()
{

    echo "usage: ./$0 [OPTIONS]"
    echo "Incase no option given: default install and onboard"
    echo "Options:"
    echo " --only-onboard    onboard the device (MDE should already be installed)"
}

exit_script()
{
    clean_up
    if [ -n "$2" ]; then
        echo "[x] $2"
    fi

    exit_code=$1
    if [ "$exit_code" -ne 0 ]; then
        echo "[*] exiting ($1)"
    fi
    echo "--- $SCRIPT_NAME ended. ---"
    exit $1
}

run_quietly()
{
    # run_quietly <command> <error_msg> [<error_code>]
    # use error_code for exit_script

    if [ $# -lt 2 ] || [ $# -gt 3 ]; then
        echo "[!] INTERNAL ERROR. run_quietly requires 2 or 3 arguments"
        exit_script 1 "[!] INTERNAL ERROR"
    fi
    local out exit_code

    out=$(eval $1 2>&1; echo "$?")
    exit_code=$(echo "$out" | tail -n1)

    if [ -n "$VERBOSE" ]; then
        echo "$out"
    fi
    
    if [ "$exit_code" != "0" ]; then
        if [ "$DEBUG" != "0" ]; then             
            echo "[>] Running command: $1"
            echo "[>] Command output: $out"
            echo "[>] Command exit_code: $exit_code"
        fi

        if [ $# -eq 2 ]; then
            echo $2
        else
            exit_script "$3" "$2"
        fi
    fi

    return $exit_code
}

is_mdatp_installed() {
    if command -v mdatp >/dev/null 2>&1; then
        return 0  # mdatp is installed
    else
        return 1  # mdatp is not installed
    fi
}

is_root_user() {
    if [ "$EUID" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

extract_org_id() 
{    
    if [ -z "$BLOB_PAYLOAD" ]; then
        # BLOB_PAYLOAD EMPTY
        return
    fi

    local org_id
    # Extract orgId from BLOB_PAYLOAD using sed and grep 
    org_id="$(echo "$BLOB_PAYLOAD" | sed 's/\\"/"/g' | sed 's/\\"/"/g' | sed 's/\\"/"/g' | grep -o '"orgId":"[^"]*"' | sed 's/"orgId":"\([^"]*\)"/\1/')"

    if [ -n "$org_id" ]; then
        # orgId found in blob payload.
        export ORG_ID=$org_id
    fi
}

extract_geo()
{
    if [ -z "$BLOB_PAYLOAD" ]; then
        # BLOB_PAYLOAD EMPTY
        return
    fi

    local geo
    # Extract geo from BLOB_PAYLOAD using sed and grep
    geo="$(echo "$BLOB_PAYLOAD" | sed 's/\\"/"/g' | sed 's/\\"/"/g' | sed 's/\\"/"/g' | grep -o '"vortexGeoLocation":"[^"]*"' | sed 's/"vortexGeoLocation":"\([^"]*\)"/\1/')"

    if [ -n "$geo" ]; then
        export MDE_GEO="$geo"
    fi
}

onboard_device()
{
    if ! is_root_user; then
        exit_script $ERR_INSUFFICIENT_PRIVILAGES "root privileges required to onboard MDE"
    fi

    if ! is_mdatp_installed; then
        exit_script $ERR_ONBOARDING_FAILED "error: mdatp is not installed."
    fi
    
    local onboarded
    onboarded=$(mdatp health --field licensed 2>/dev/null)
    if [ $? -eq 0 ] && [ "$onboarded" = "true" ]; then
        local org_id
        org_id=$(mdatp health --field org_id 2>/dev/null)
        echo "[S] Already onboarded with org id: $org_id"
        return
    fi

    echo "[>] Onboarding MDE"

    if [ ! -f $BLOB_PAYLOAD_FILE ]; then
        exit_script $ERR_ONBOARDING_NOT_FOUND "error: onboarding script not found."
    fi

    #remove mdatp_offboard.json if present
    mdatp_offboard_file=/etc/opt/microsoft/mdatp/mdatp_offboard.json
    if [ -f "$mdatp_offboard_file" ]; then
        echo "[i] found mdatp_offboard file, removing the file"
        run_quietly "rm -f $mdatp_offboard_file" "error: failed to remove offboarding blob" $ERR_ONBOARDING_FAILED
        if [ ! -f "$mdatp_offboard_file" ]; then
            echo "[i] removed mdatp_offboard file"
        else
            exit_script $ERR_ONBOARDING_FAILED "error: failed to remove offboarding blob"
        fi
    fi

    local onboarding_dir=/etc/opt/microsoft/mdatp/
    if [ -d "$onboarding_dir" ]; then
        run_quietly "cp $BLOB_PAYLOAD_FILE $onboarding_dir/mdatp_onboard.json" "error: JSON onboarding failed" $ERR_ONBOARDING_FAILED
    else
        exit_script $ERR_ONBOARDING_FAILED "error: JSON onboarding failed. mdatp is not installed or installation failed."
    fi

    # validate onboarding
    license_found=false

    for ((i = 1; i <= 8; i++)); do
        sleep 10 # Delay for 10 seconds before checking the license status

        local onboarded
        onboarded=$(mdatp health --field licensed 2>/dev/null)
        if [ $? -eq 0 ] && [ "$onboarded" = "true" ]; then
            license_found=true
            break
        fi
    done

    if [[ $license_found == false ]]; then
        exit_script $ERR_ONBOARDING_FAILED "onboarding failed"
    fi

    echo "[S] Onboarded: $license_found"
}

get_mdatp_channel()
{
    local release_ring
    release_ring=$(mdatp health --field release_ring | sed '1{/^ATTENTION/d}')

    if [[ "$release_ring" == *"Production"* ]]; then
        CHANNEL="prod"
    elif [[ "$release_ring" == *"InsiderFast"* ]]; then
        CHANNEL="insiders-fast"
    elif [[ "$release_ring" == *"External"* ]]; then
        CHANNEL="insiders-slow"
    else
        CHANNEL="dogfood"
    fi
}

get_installer_url()
{
    if [ $CHANNEL == "insiders-fast" ]; then
        INSTALLER_SCRIPT_URL="https://go.microsoft.com/fwlink/?linkid=2313016"
    elif [ $CHANNEL == "insiders-slow" ]; then
        INSTALLER_SCRIPT_URL="https://go.microsoft.com/fwlink/?linkid=2313111"
    else
        INSTALLER_SCRIPT_URL="https://go.microsoft.com/fwlink/?linkid=2313015"
    fi
}

ARGS_LIST=()
ARGS_LIST+=("--install_source")
ARGS_LIST+=("ddt")
ARGS_LIST+=("--install")
ARGS_LIST+=("--pre-req")

if is_mdatp_installed; then
    get_mdatp_channel
fi

while [ $# -ne 0 ];
do
    case "$1" in
        -c|--channel)
            if [ -z "$2" ]; then
                exit_script $ERR_INVALID_ARGUMENTS "$1 option requires an argument."
            fi

            if [ ! -z $CHANNEL ]; then
                if [ "$2" != "$CHANNEL" ]; then
                    echo "[i] MDE Installed with $CHANNEL. Cannot switch channel to $2. Channel is being set to $CHANNEL"
                fi
            else
                CHANNEL=$2
            fi

            if [ "$CHANNEL" != "prod" ] && [ "$CHANNEL" != "insiders-fast" ] && [ "$CHANNEL" != "insiders-slow" ]; then
                exit_script $ERR_INVALID_CHANNEL "Invalid channel: $CHANNEL. Please provide valid channel. Available channels are prod, insiders-fast, insiders-slow"
            fi
            ARGS_LIST+=("$1")
            ARGS_LIST+=("$CHANNEL")
            shift 2
            ;;
        -s|--script)
            if [ -z "$2" ]; then
                exit_script $ERR_INVALID_ARGUMENTS "$1 option requires an argument for script path."
            fi
            INSTALLER_SCRIPT=$2
            shift 2
            ;;
        -i|--install|-o|--onboard)
            echo "use -h or --help for details"
            exit_script $ERR_INVALID_ARGUMENTS "unknown argument $1"
            ;;
        -f|--offboard)
            if [ -z "$2" ]; then
                exit_script $ERR_INVALID_ARGUMENTS "$1 option requires an argument for script path."
            fi
            PAYLOAD_TYPE="mdatp_offboard"
            BLOB_PAYLOAD_FILE="$2"
            DEFAULT_INSTALL=0
            shift 2
            ;;
        --only-onboard)
            DEFAULT_INSTALL=0
            ONLY_ONBOARD=1
            shift
            ;;
        -u|--upgrade|--update|-l|--downgrade|-r|--remove|-w|--clean)
            PAYLOAD_TYPE=
            BLOB_PAYLOAD_FILE=
            DEFAULT_INSTALL=0
            ARGS_LIST+=("$1")
            shift
            ;;
        -h|--help)
            PRINT_HELP=1
            PAYLOAD_TYPE=
            BLOB_PAYLOAD_FILE=
            DEFAULT_INSTALL=0
            ARGS_LIST+=("$1")
            shift
            ;;
        -v|--version)
            echo "[i] SCRIPT VERSION: $SCRIPT_VERSION"
            exit $SUCCESS
            ;;
        -d|--debug)
            DEBUG=1
            ARGS_LIST+=("$1")
            shift
            ;;
        --http-proxy)
            if [[ -z "$2" ]]; then
                script_exit "$1 option requires two arguments" $ERR_INVALID_ARGUMENTS
            fi
            export http_proxy=$2
            ARGS_LIST+=("$1")
            ARGS_LIST+=("$2")
            shift 2
            ;;
        --https-proxy)
            if [[ -z "$2" ]]; then
                script_exit "$1 option requires two arguments" $ERR_INVALID_ARGUMENTS
            fi
            export https_proxy=$2
            ARGS_LIST+=("$1")
            ARGS_LIST+=("$2")
            shift 2
            ;;
        --get-blob)
            echo "$BLOB_PAYLOAD"
            exit $SUCCESS
            ;;
        *)
            ARGS_LIST+=("$1")
            shift
            ;;
    esac
done

echo "--- $SCRIPT_NAME ---"

if [ ! -z $PRINT_HELP ]; then
    usage
fi

TEMPDIR=$(mktemp -d --tmpdir="$(pwd)")
if [ ! -d "$TEMPDIR" ]; then
    exit_script $ERR_INTERNAL "Unable to create temp directory"
fi

if [ -z "$BLOB_PAYLOAD_FILE" ] && [ ! -z "$BLOB_PAYLOAD" ] && [ ! -z "$PAYLOAD_TYPE" ]; then
    BLOB_PAYLOAD_FILE="$TEMPDIR/${PAYLOAD_TYPE}.json"

    cat <<EOM > "$BLOB_PAYLOAD_FILE"
$BLOB_PAYLOAD
EOM
fi

if [ -f "$BLOB_PAYLOAD_FILE" ]; then
    if  [ "$PAYLOAD_TYPE" == "mdatp_offboard" ]; then
        ARGS_LIST+=("--offboard")
        ARGS_LIST+=("$BLOB_PAYLOAD_FILE")
    elif [ "$PAYLOAD_TYPE" == "mdatp_onboard" ]; then
        ARGS_LIST+=("--onboard")
        ARGS_LIST+=("$BLOB_PAYLOAD_FILE")
    else
        exit_script $ERR_INTERNAL "Invalid payload type: $PAYLOAD_TYPE"
    fi
else
    if [ ! -z $PAYLOAD_TYPE ]; then
        exit_script $ERR_INTERNAL "Unable to generate blob file"
    fi
fi

if [ -z "$ONLY_ONBOARD" ]; then
    if [ "$DEFAULT_INSTALL" = "0" ]; then
        # do not install by default, remove the option
        if [ "${ARGS_LIST[2]}" = "--install" ]; then
            unset 'ARGS_LIST[2]'
            ARGS_LIST=("${ARGS_LIST[@]}")
        fi  
    fi
    if [ -z $INSTALLER_SCRIPT ]; then
        if [ -z $CHANNEL ]; then
            CHANNEL="prod"
        fi
        get_installer_url
        INSTALLER_SCRIPT="$TEMPDIR/mde_installer.sh"

        if command -v curl >/dev/null 2>&1; then
            curl -sSfL "$INSTALLER_SCRIPT_URL" -o "$INSTALLER_SCRIPT"
        elif command -v wget >/dev/null 2>&1; then
            wget -q --https-only --output-document="$INSTALLER_SCRIPT" "$INSTALLER_SCRIPT_URL"
        else
            exit_script $ERR_INSUFFICIENT_REQUIREMENTS "curl and wget both are missing"
        fi

        if [[ $? -ne 0 ]]; then
            exit_script $ERR_INTERNAL "Failed to download installation script."
        fi
    fi

    if [ ! -f "$INSTALLER_SCRIPT" ]; then
        exit_script $ERR_INTERNAL "Installer script not found at location $INSTALLER_SCRIPT"
    fi

    extract_org_id
    extract_geo

    chmod +x $INSTALLER_SCRIPT
    bash "$INSTALLER_SCRIPT" "${ARGS_LIST[@]}"
    INSTALLER_STATUS=$?
    if [ $INSTALLER_STATUS != $SUCCESS ]; then
        exit_script $INSTALLER_STATUS "Installer script error"
    fi
else
    onboard_device
fi

exit_script $SUCCESS