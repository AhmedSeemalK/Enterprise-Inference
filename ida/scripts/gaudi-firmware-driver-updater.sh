#!/bin/bash

# ©2024 Intel Corporation
# Permission is granted for recipient to internally use and modify this software for purposes of benchmarking and testing on Intel architectures. 
# This software is provided "AS IS" possibly with faults, bugs or errors; it is not intended for production use, and recipient uses this design at their own risk with no liability to Intel.
# Intel disclaims all warranties, express or implied, including warranties of merchantability, fitness for a particular purpose, and non-infringement. 
# Recipient agrees that any feedback it provides to Intel about this software is licensed to Intel for any purpose worldwide. No permission is granted to use Intel’s trademarks.
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the code.

#
# Gaudi Driver, Firmware Update Automation
#
# Description:
# This script updates the Gaudi drivers and firmware version.
#
# Requirements:
# - Ubuntu or compatible Linux distribution
# - Root privileges (for package installation and driver management)
# - Internet connection (for downloading the installer and packages)
#
# Usage:
# 1. Save this script to a file (e.g., update_habana.sh)
# 2. Make the script executable: chmod +x update_habana.sh
# 3. Run the script as root: 
#    To update both drivers and firmwares bash gaudi-firmware-driver-updater.sh --both
#    To update only drivers: sudo bash gaudi-firmware-driver-updater.sh --drivers
#    To update only firmware: sudo bash gaudi-firmware-driver-updater.sh --firmware
#
# Output:
# The script provides colored output for better visibility and readability:
# - Yellow: Informational messages
# - Green: Success messages
# - Red: Error messages
#
# Error Handling:
# The script includes robust error handling and checks at each step. If any
# command fails, the script will print an error message and exit with a
# non-zero status code.
#

set -e
# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Function to update Gaudi drivers
update_drivers() {
    # Download the base Gaudi installer
    echo -e "${YELLOW}Downloading Gaudi installer...${NC}"
    echo -e "${YELLOW}Unloading Gaudi drivers...${NC}"
    sudo modprobe -r habanalabs &>/dev/null || true
    sudo modprobe -r habanalabs_cn &>/dev/null || true
    sudo modprobe -r habanalabs_ib &>/dev/null || true
    sudo modprobe -r habanalabs_en &>/dev/null || true
    echo -e "${GREEN}Gaudi drivers unloaded successfully.${NC}"
    echo -e "${YELLOW}Loading Gaudi drivers...${NC}"
    sudo modprobe habanalabs
    sudo modprobe habanalabs_cn
    sudo modprobe habanalabs_ib
    sudo modprobe habanalabs_en
    echo -e "${GREEN}Gaudi drivers loaded successfully.${NC}"
}

# Function to update Gaudi firmware
update_firmware() {
    echo -e "${YELLOW}Downloading Gaudi installer...${NC}"
    wget -nv https://vault.habana.ai/artifactory/gaudi-installer/1.18.0/habanalabs-installer.sh
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to download Gaudi installer.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Gaudi installer downloaded successfully.${NC}"
    echo -e "${YELLOW}Installing Gaudi base components...${NC}"
    chmod +x habanalabs-installer.sh
    ./habanalabs-installer.sh install --type base -y
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to install Gaudi base components.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Gaudi base components installed successfully.${NC}"
    echo -e "${YELLOW}Installing Gaudi container runtime...${NC}"
    sudo apt install -y habanalabs-container-runtime=1.18.0-524
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to install Gaudi container runtime.${NC}"
        #exit 1
    fi
    echo -e "${GREEN}Gaudi container runtime installed successfully.${NC}"
    echo -e "${YELLOW}Checking FW version...${NC}"
    FW_VERSION=$(hl-smi -L | grep "Firmware \[SPI\] Version" | awk 'NR==1 {sub(/^.*gaudi2-/,""); sub(/-.*$/,""); print}')
    if [ -z "$FW_VERSION" ]; then
        echo -e "${RED}Failed to retrieve FW version.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Current FW version: $FW_VERSION${NC}"
    if [ "$FW_VERSION" != "1.18.0" ]; then
        echo -e "${YELLOW}Updating FW version...${NC}"
        echo -e "${YELLOW}Updating the downloader package...${NC}"
        sudo apt update
        sudo apt install -y --allow-downgrades habanalabs-firmware-odm=1.18.0-524
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to install the downloader package.${NC}"
            exit 1
        fi
        echo -e "${GREEN}Downloader package updated successfully.${NC}"
        echo -e "${YELLOW}Updating the FW...${NC}"
        sudo hl-fw-loader
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to update the FW.${NC}"
            exit 1
        fi
        echo -e "${GREEN}FW updated successfully.${NC}"
        echo -e "${YELLOW}Confirming the FW version...${NC}"
        FW_VERSION=$(hl-smi -L | grep "SPI Version" | awk '{print $3}')
        if [ -z "$FW_VERSION" ]; then
            echo -e "${RED}Failed to retrieve FW version.${NC}"
            exit 1
        fi
        echo -e "${GREEN}Updated FW version: $FW_VERSION${NC}"
    else
        echo -e "${GREEN}FW version is already 1.18${NC}"
    fi
}
# Parse command-line arguments
if [ "$1" == "--drivers" ]; then
    update_drivers
elif [ "$1" == "--firmware" ]; then
    update_firmware
elif [ "$1" == "--both" ]; then    
    update_firmware
    update_drivers
else
    echo "Undefined Selection, please select a parameter --firmware or --drivers or --both"
fi