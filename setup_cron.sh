#!/bin/bash
# Interactive cron setup script

# Prompt to clear existing cron jobs
read -p "Do you want to clear all existing cron jobs before setting up? (yes/no): " clear_cron

if [[ "$clear_cron" =~ ^[Yy](es)?$ ]]; then
    echo "Clearing all existing cron jobs..."
    # Backup current crontab (if any)
    crontab -l > "$HOME/crontab_backup_$(date +%Y%m%d_%H%M%S).txt" 2>/dev/null
    crontab -r
    current_cron=""
else
    current_cron=$(crontab -l 2>/dev/null)
fi

# Prompt for x-ui restart interval
read -p "Enter interval for x-ui restart command (e.g., 15m, 1h, 1d): " xui_input
# Extract number and unit (last character assumed to be the unit)
xui_unit="${xui_input: -1}"
xui_value="${xui_input%$xui_unit}"

# Determine cron schedule for x-ui restart based on unit
case "$xui_unit" in
    m|M)
        cron_xui="*/${xui_value} * * * *"
        ;;
    h|H)
        cron_xui="0 */${xui_value} * * *"
        ;;
    d|D)
        cron_xui="0 0 */${xui_value} * *"
        ;;
    *)
        echo "Invalid input for x-ui restart interval. Using default (15m)."
        cron_xui="*/15 * * * *"
        ;;
esac

xui_cmd="/usr/bin/env bash -c 'x-ui restart'"

# Prompt for server reboot interval
read -p "Enter interval for server reboot command (e.g., 1d, 12h, etc): " reboot_input
reboot_unit="${reboot_input: -1}"
reboot_value="${reboot_input%$reboot_unit}"

case "$reboot_unit" in
    m|M)
        cron_reboot="*/${reboot_value} * * * *"
        ;;
    h|H)
        cron_reboot="0 */${reboot_value} * * *"
        ;;
    d|D)
        cron_reboot="0 0 */${reboot_value} * *"
        ;;
    *)
        echo "Invalid input for server reboot interval. Using default (1d)."
        cron_reboot="0 0 * * *"
        ;;
esac

reboot_cmd="/usr/bin/env bash -c '/sbin/reboot'"

# Combine new cron entries with existing ones (if any)
new_cron=""
if [[ -n "$current_cron" ]]; then
    new_cron="${current_cron}"$'\n'
fi
new_cron="${new_cron}${cron_xui} ${xui_cmd}"$'\n'"${cron_reboot} ${reboot_cmd}"

# Install the new crontab
echo "$new_cron" | crontab -

echo "Cron jobs have been successfully updated. Here are the current cron entries:"
crontab -l
