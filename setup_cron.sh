#!/bin/bash
# Script to automatically add required cron jobs to crontab

# 1. Backup current crontab
CRON_BACKUP="$HOME/crontab_backup_$(date +%Y%m%d_%H%M%S).txt"
echo "Backing up current crontab to: $CRON_BACKUP"
crontab -l 2>/dev/null > "$CRON_BACKUP"

# 2. Define desired cron jobs
CRON_XUI="*/15 * * * * /usr/bin/env bash -c 'x-ui restart'"
CRON_REBOOT="0 0 * * * /usr/bin/env bash -c '/sbin/reboot'"

# 3. Read current crontab (if not set, it will be empty)
current_cron=$(crontab -l 2>/dev/null)

# 4. Append cron jobs if they are not already present
new_cron="$current_cron"
if ! echo "$current_cron" | grep -Fq "$CRON_XUI"; then
    new_cron="$new_cron"$'\n'"$CRON_XUI"
fi
if ! echo "$current_cron" | grep -Fq "$CRON_REBOOT"; then
    new_cron="$new_cron"$'\n'"$CRON_REBOOT"
fi

# 5. Install the new crontab
echo "$new_cron" | crontab -

echo "Cron jobs have been successfully updated."
