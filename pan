#!/usr/bin/env bash

####################################################
#        Cloudreve Service Management Script       #
#  Written by Eric Liu (PixelWine), under GPL 3.0. #
####################################################

## Load Script Config

source ./panConfig
panScriptConfigLoader

## End: Load Script Config

greetingAndTips(){
    echo "[=== Cloudreve Service Management Script ===]"
    echo "[=== You are at: $(pwd) ===]"
    # echo "[=== Read parameters: $* ===]"
    echo "[=== Now is $(date), hello! ===]"
    echo "[=== Help ===]"
    echo "[=== exit: Exit the script. ===]"
    echo "[=== start: Start the service. ===]"
    echo "[=== stop: Stop the service. ===]"
    echo "[=== dconf: Edit the daemon config. ===]"
    echo "[=== pconf: Edit the PAN config. ===]"
    echo "[=== cconf: Edit the Cloudreve config file (conf.ini). ===]"
    echo "[=== status: Show the service status. ===]"
    echo "[=== restart: Restart the service. ===]"
    echo "[=== enable: Enable the service. ===]"
    echo "[===========================================]"
}

getPrompt(){
    echo -e "> \c"
    read argument
    case $argument in
        "exit")
            echo "[error] Exit by action of user."
            return ${PAN_exitPrompt}
            exit
        ;;
        "start")
            echo "[info] Starting Cloudreve Service..."
            echo "[info] Executing ${PAN_managementTool}..."
            return ${PAN_startCloudreve}
        ;;
        "stop")
            echo "[info] Stoping Cloudreve Service..."
            echo "[info] Executing ${PAN_managementTool}..."
            return ${PAN_stopCloudreve}
        ;;
        "dconf") # config daemon
            echo "[info] Configuring Daemon using ${PAN_editor}..."
            echo "[info] Executing ${PAN_editor}"
            return ${PAN_editDaemonConfig}
        ;;
        "pconf") # config PAN
            echo "[info] Executing PANConf..."
            return ${PAN_editPANConfig}
        ;;
        "cconf") # config cloudreve (conf.ini)
            echo "[info] Configuring Cloudreve using ${PAN_editor}..."
            echo "[info] Executing ${PAN_editor}"
            return ${PAN_editCloudreveConfig}
        ;;
        "status")
            echo "[info] Show Cloudreve Status..."
            echo "[info] Executing ${PAN_managementTool}..."
            return ${PAN_showStatus}
        ;;
        "restart")
            echo "[info] Restarting Cloudreve Service..."
            echo "[info] Executing ${PAN_managementTool}..."
            return ${PAN_restartCloudreve}
        ;;
        "enable")
            echo "[info] Enable Cloudreve Service..."
            echo "[info] Executing ${PAN_managementTool}..."
            return ${PAN_enableService}
        ;;
        *)
            echo "[error] I can't understand what you entered."
        ;;
    esac
}

# configPAN(){
#     echo "[info] You can use the command \"config xxx\" to config PANScript."
#     echo "[info] Or you can just use \"default\" to use default config."
#     echo -e "config> \c"

# }

processor(){
    case $1 in
        ${PAN_editCloudreveConfig})
            ${PAN_editor} ${PAN_pathToCloudreve}/conf.ini
        ;;
    esac
}

greetingAndTips

# if [ ! -f "${PAN_isConfigured}" ]
if (( ${PAN_test} == 0 ))
then
    echo "[warn] ${PAN_isConfigured} FILE NOT FOUND."
    echo "[warn] It means that you have not configured the PANScript."
    # echo "[info] Let's configure it."
    loadPanScriptDefaultConfig
    echo "[info] I have configured it using default config."
    touch ${PAN_isConfigured}
    
    # echo "[info] Taking you to the config prompt..."
    # configPAN
fi


until (( $? == ${PAN_exitPrompt} ))
do
    getPrompt
    processor $?
done
