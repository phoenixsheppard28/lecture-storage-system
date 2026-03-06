# # Lecture S3 Mount

Store lecture recordings in S3 and access them locally via a mounted directory (`~/lectures`).

---

## Load it (enable at login with `-w`)

```
launchctl load -w ~/Library/LaunchAgents/com.phoenixs.rclone.lectures.plist
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
launchctl unload ~/Library/LaunchAgents/com.phoenixs.rclone.lectures.plist
launchctl load -w ~/Library/LaunchAgents/com.phoenixs.rclone.lectures.plist
```

## Check Status:

`launchctl list | grep phoenix`

Check if the mount exists:
`mount | grep lectures`

logs stored in ~/codestuff/lecture-s3/logs
