#!/usr/bin/env bash
set -euo pipefail

RCLONE="/usr/local/bin/rclone" 
REMOTE="lectureS3:lecture-bucket-131424789123"
MOUNTPOINT="/Users/phoenixsheppard/lectures"
LOGDIR="/Users/phoenixsheppard/codestuff/lecture-s3/logs"
RCLONELOG="$LOGDIR/rclone.log"

mkdir -p "$MOUNTPOINT" "$LOGDIR"

# Wait for network (up to 90s)
for i in {1..90}; do
  if /usr/sbin/scutil -r "amazonaws.com" | /usr/bin/grep -q "Reachable"; then
    break
  fi
  /bin/sleep 1
done

# If already mounted, exit cleanly
if /sbin/mount | /usr/bin/grep -Fq "on $MOUNTPOINT "; then
  exit 0
fi

# Optional: quick sanity check rclone exists
if [[ ! -x "$RCLONE" ]]; then
  echo "rclone not found/executable at: $RCLONE" >&2
  exit 1
fi


exec "$RCLONE" nfsmount "$REMOTE" "$MOUNTPOINT" \
  --vfs-cache-mode full \
  --vfs-cache-max-size 10G \
  --vfs-cache-max-age 24h \
  --vfs-read-chunk-size 16M \
  --vfs-read-chunk-size-limit 256M \
  --poll-interval 0 \
  --transfers 2 \
  --checkers 4 \
  --bwlimit 8M \
  --log-file "$RCLONELOG" \
  --log-level INFO \
  --log-file-max-size 25M \
  --log-file-max-backups 3 \
  --log-file-max-age 7d \
  --log-file-compress

