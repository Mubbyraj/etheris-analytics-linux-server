#!/bin/bash
# disk_check.sh
# Checks every mounted partition; appends a warning to
# /var/log/sys_alerts.log if usage exceeds the threshold.
# Intended to run hourly via cron:
#   0 * * * * /usr/local/bin/disk_check.sh

LOGFILE=/var/log/sys_alerts.log
THRESHOLD=80

df -hP | awk 'NR>1 {print $5, $6}' | while read -r usage mount; do
    pct=${usage%%%}
    if [ "$pct" -gt "$THRESHOLD" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING: $mount is at ${pct}% disk usage" \
            >> "$LOGFILE"
    fi
done
