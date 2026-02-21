# # Lecture S3 Mount

Store lecture recordings in S3 and access them locally via a mounted directory (`~/lectures`).

---

## Bootstrap + Enable it

```
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.phoenixs.rclone.lectures.plist
launchctl enable gui/$(id -u)/com.phoenixs.rclone.lectures
```

## Start it:

`launchctl kickstart -k gui/$(id -u)/com.phoenixs.rclone.lectures`

## Stop It (Temporarily):

```
launchctl disable gui/$(id -u)/com.phoenixs.rclone.lectures
launchctl kickstart -k gui/$(id -u)/com.phoenixs.rclone.lectures  # if it’s stuck, this restarts; so instead:
launchctl kill SIGTERM gui/$(id -u)/com.phoenixs.rclone.lectures
```

## Restart It:

```
launchctl bootout gui/$(id -u)/com.phoenixs.rclone.lectures
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.phoenixs.rclone.lectures.plist
launchctl kickstart -k gui/$(id -u)/com.phoenixs.rclone.lectures
```

## Check Status:

`launchctl list | grep phoenix`

Check if the mount exists:
`mount | grep lectures`

logs stored in ~/codestuff/lecture-s3/logs
