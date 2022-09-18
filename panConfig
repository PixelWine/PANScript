#!/usr/bin/env sh

####################################################
#        Cloudreve Service Management Script       #
#  Written by Eric Liu (PixelWine), under GPL 3.0. #
####################################################

## Load Script Config

source ./panConfig


## End: Load Script Config

greetingAndTips(){
    echo "[=== Cloudreve Service Management Script ===]"
    echo "[=== You are at: $(pwd) ===]"
    echo "[=== Read parameters: $* ===]"
    echo "[=== Now is $(date), hello! ===]"
    echo "[=== Help ===]"
    echo "[===========================================]"
}

getPrompt(){
    echo -e "script> \c"
    read argument
    return argument;
}

greetingAndTips