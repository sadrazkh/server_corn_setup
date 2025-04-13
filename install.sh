#!/bin/bash
# install.sh - Force installation of the latest cron setup scripts

# Set your repository URL and installation directory
REPO_URL="https://github.com/sadrazkh/cron-setup.git"
INSTALL_DIR="$HOME/cron-setup"

echo "Checking for existing installation in $INSTALL_DIR..."

if [ -d "$INSTALL_DIR" ]; then
    echo "Existing installation found. Removing old version..."
    rm -rf "$INSTALL_DIR"
fi

echo "Cloning repository from $REPO_URL into $INSTALL_DIR..."
git clone "$REPO_URL" "$INSTALL_DIR"

if [ $? -ne 0 ]; then
    echo "Error cloning repository. Aborting."
    exit 1
fi

cd "$INSTALL_DIR"
chmod +x setup_cron.sh

echo "Executing the new setup script..."
sudo ./setup_cron.sh

echo "Installation complete. The latest version of the scripts has been applied."
