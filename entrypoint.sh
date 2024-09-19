#!/bin/sh
set -e

echo "###########################################################################"
echo "# Running thmhoag/rclone - " `date`
echo "###########################################################################"

mkdir -p /root/.config/rclone/
[ -r /config/rclone.conf ] && ln -sf /config/rclone.conf /root/.config/rclone/rclone.conf

mkdir -p /cron

echo "Creating crontab..."
cat << EOF > /cron/root
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed

$CRON_SCHEDULE /rclone.sh
EOF

/init