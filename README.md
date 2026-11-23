# Shooting Money dedicated server

This Linux x86_64 headless build is deployed on `fr1.switched.cloud`.

## Live server

- Join address: `fr1.switched.cloud:24291`
- Game transport: UDP on port `24291`
- Server directory: `/opt/shooting-money`
- systemd unit: `shooting-money.service`
- Port allocation: public `24291` forwards to UDP/TCP `24291` inside the VPS.

The current VPS forwards the same port number through its public address. `SERVER_PORT=24291` is set in the service and the running server has been verified listening on UDP 24291. A Windows client smoke connection joined successfully and received the player roster.

## Manage the server

```sh
sudo systemctl status shooting-money
sudo systemctl restart shooting-money
sudo journalctl -u shooting-money -f
```

The unit starts automatically after reboot and restarts if the server process exits. The executable and deployment files are in `/opt/shooting-money`; persistent Godot user data is in `/var/lib/shooting-money`.

## Rebuild and update

From the Godot project, export the `Linux Dedicated Server` preset to `Site/Server/ShootingMoneyServer.x86_64`. Upload the new executable to `/tmp/ShootingMoneyServer.x86_64`, then on the VPS:

```sh
sudo systemctl stop shooting-money
sudo install -o root -g root -m 0755 /tmp/ShootingMoneyServer.x86_64 /opt/shooting-money/ShootingMoneyServer.x86_64
sudo systemctl start shooting-money
sudo systemctl status shooting-money
```

Keep `SERVER_PORT` matched to the VPS's forwarded UDP port. The client Join form should use `fr1.switched.cloud` and `24291`.
