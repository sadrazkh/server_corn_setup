# cron-setup

Automate the configuration of essential cron jobs on your servers. This script sets up:

- **Restarting `x-ui` every 15 minutes**
- **Rebooting the server daily at midnight**

## Features

- **Automated Setup**: Quickly configure cron jobs without manual intervention.
- **Safe Execution**: Backs up existing crontab entries before making changes.
- **Idempotent**: Ensures duplicate cron jobs are not created upon multiple executions.

## Installation

To install and set up the cron jobs, run the following command:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/sadrazkh/server_corn_setup/main/install.sh)"
```

```bash
crontab -l

```
```bash
sudo systemctl status cron
```
