#!/bin/bash
# install.sh - Installation script to clone repository and install cron jobs automatically

# Update this variable to match your repository URL, if needed.
REPO_URL="https://github.com/sadrazkh/server_corn_setup.git"
INSTALL_DIR="$HOME/cron-setup"

echo "Cloning repository from $REPO_URL..."
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists. Pulling latest changes."
    cd "$INSTALL_DIR" || { echo "Failed to change directory"; exit 1; }
    git pull
else
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR" || { echo "Failed to change directory"; exit 1; }
fi

echo "Making setup script executable..."
chmod +x setup_cron.sh

echo "Running setup script..."
sudo ./setup_cron.sh

echo "Installation complete."
