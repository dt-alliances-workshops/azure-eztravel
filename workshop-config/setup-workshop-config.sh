#!/bin/bash

source ./_workshop-config.lib

MONACO_PROJECT_BASE_PATH=./monaco/projects
MONACO_PROJECT=workshop
MONACO_ENVIONMENT_FILE=./monaco/environments.yaml
MONACO_CONFIG_FOLDER="$MONACO_PROJECT_BASE_PATH/$MONACO_PROJECT"

create_service_principal_monaco_config() {

    AZURE_SP_JSON_FILE="/tmp/workshop-azure-service-principal.json"

    mkdir -p "$MONACO_CONFIG_FOLDER/azure-credentials"
    MONACO_JSON_FILE="$MONACO_CONFIG_FOLDER/azure-credentials/azure-credentials.json"
    MONACO_CONFIG_FILE="$MONACO_CONFIG_FOLDER/azure-credentials/config.yaml"

    AZURE_SP_APP_ID=$(cat $AZURE_SP_JSON_FILE | jq -r '.appId')
    AZURE_SP_DIRECTORY_ID=$(cat $AZURE_SP_JSON_FILE | jq -r '.tenant')
    AZURE_SP_KEY=$(cat $AZURE_SP_JSON_FILE | jq -r '.password')

    echo "*** Generating $MONACO_CONFIG_FILE file used by monaco ***"
    echo "config:" > $MONACO_CONFIG_FILE
    echo "- credentials: \"azure-credentials.json\"" >> $MONACO_CONFIG_FILE
    echo "" >> $MONACO_CONFIG_FILE
    echo "credentials:" >> $MONACO_CONFIG_FILE
    echo "- name: \"azure-modernize-workshop\"" >> $MONACO_CONFIG_FILE
    echo "- appId: \"$AZURE_SP_APP_ID\"" >> $MONACO_CONFIG_FILE
    echo "- directoryId: \"$AZURE_SP_DIRECTORY_ID\"" >> $MONACO_CONFIG_FILE
    echo "- key: \"$AZURE_SP_KEY\"" >> $MONACO_CONFIG_FILE
    
    echo ""
    echo "*** Generated $MONACO_CONFIG_FILE file contents ***"
    cat $MONACO_CONFIG_FILE

    echo "*** Generating $MONACO_JSON_FILE file used by monaco ***"
    echo "{" > $MONACO_JSON_FILE
    echo "\"label\": \"{{ .name }}\"," >> $MONACO_JSON_FILE
    echo "\"appId\": \"{{ .appId }}\"," >> $MONACO_JSON_FILE
    echo "\"directoryId\": \"{{ .directoryId }}\"," >> $MONACO_JSON_FILE
    echo "\"active\": true," >> $MONACO_JSON_FILE
    echo "\"key\": \"{{ .key }}\"," >> $MONACO_JSON_FILE
    echo "\"autoTagging\": true," >> $MONACO_JSON_FILE
    echo "\"monitorOnlyTaggedEntities\": false," >> $MONACO_JSON_FILE
    echo "\"monitorOnlyTagPairs\": []" >> $MONACO_JSON_FILE
    echo "}" >> $MONACO_JSON_FILE

    echo ""
    echo "*** Generated $MONACO_JSON_FILE file contents ***"
    cat $MONACO_JSON_FILE
}

download_monaco() {
    if [ $(uname -s) == "Darwin" ]
    then
        MONACO_BINARY="v1.5.0/monaco-darwin-10.6-amd64"
    else
        MONACO_BINARY="v1.5.0/monaco-linux-amd64"
    fi
    echo "Getting MONACO_BINARY = $MONACO_BINARY"
    rm -f monaco-binary
    wget -q -O monaco-binary https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/$MONACO_BINARY
    chmod +x monaco-binary
    echo "Installed monaco version: $(monaco --version)"
}

run_monaco() {
    # run monaco configuration
    # add the -dry-run argument to test
    export NEW_CLI=1
    export DT_BASEURL=$DT_BASEURL && export DT_API_TOKEN=$DT_API_TOKEN && ./monaco-binary deploy -v --environments $MONACO_ENVIONMENT_FILE --project $MONACO_PROJECT $MONACO_PROJECT_BASE_PATH
}

run_custom_dynatrace_config() {
    setFrequentIssueDetectionOff
    setServiceAnomalyDetection ./custom/service-anomalydetection.json
}

echo ""
echo "-----------------------------------------------------------------------------------"
echo "Setting up Workshop config on $DT_BASEURL"
echo "Starting: $(date)"
echo "-----------------------------------------------------------------------------------"
echo ""

download_monaco
create_service_principal_monaco_config
run_monaco
run_custom_dynatrace_config

echo ""
echo "-----------------------------------------------------------------------------------"
echo "Done Setting up Workshop config"
echo "End: $(date)"
echo "-----------------------------------------------------------------------------------"
