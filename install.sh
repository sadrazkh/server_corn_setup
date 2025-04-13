#!/bin/bash
# install.sh - Force installation using updated repository URL without authentication

# Set your updated repository URL (public) and installation directory
REPO_URL="https://github.com/sadrazkh/server_corn_setup"
INSTALL_DIR="$HOME/server_corn_setup"

echo "Checking if an old installation exists in $INSTALL_DIR..."

if [ -d "$INSTALL_DIR" ]; then
    echo "Old installation found at $INSTALL_DIR. Removing it now..."
    rm -rf "$INSTALL_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to remove the old installation. Exiting."
        exit 1
    fi
fi

echo "Cloning repository from updated URL: $REPO_URL"
git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"
if [ $? -ne 0 ]; then
    echo "Error cloning repository. Aborting."
    exit 1
fi

cd "$INSTALL_DIR" || { echo "Failed to change directory to $INSTALL_DIR"; exit 1; }
chmod +x setup_cron.sh

echo "Executing the new setup script..."
./setup_cron.sh

echo "Installation complete. The latest version of the scripts has been applied."
