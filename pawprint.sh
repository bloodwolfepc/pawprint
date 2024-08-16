#initalize packages units
nix_directory_service="
[Unit]
Description=Create a /nix directory to be used for bind mounting
PropagatesStopTo=nix-daemon.service
PropagatesStopTo=nix.mount
DefaultDependencies=no
After=grub-recordfail.service
After=steamos-finish-oobe-migration.service

[Service]
Type=oneshot
ExecStart=steamos-readonly disable
ExecStart=mkdir -vp /nix
ExecStart=chmod -v 0755 /nix
ExecStart=chown -v root /nix
ExecStart=chgrp -v root /nix
ExecStart=steamos-readonly enable
ExecStop=steamos-readonly disable
ExecStop=rmdir /nix
ExecStop=steamos-readonly enable
RemainAfterExit=true"
nix_mount="
[Unit]
Description=Mount /home/nix on /nix
PropagatesStopTo=nix-daemon.service
PropagatesStopTo=nix-directory.service
After=nix-directory.service
Requires=nix-directory.service
ConditionPathIsDirectory=/nix
DefaultDependencies=no
"
ensure_simlinked_units_resolve_service="[Unit]
Description=Ensure Nix related units which are symlinked resolve
After=nix.mount
Requires=nix-directory.service
Requires=nix.mount
PropagatesStopTo=nix-directory.service
PropagatesStopTo=nix.mount
DefaultDependencies=no

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/systemctl daemon-reload
ExecStart=/usr/bin/systemctl restart --no-block sockets.target timers.target multi-user.target

[Install]
WantedBy=sysinit.target

[Mount]
What=/home/nix
Where=/nix
Type=none
DirectoryMode=0755
Options=bind
"

#start script
passwd << EOF
1234
EOF
sudo su << EOF
1234
EOF

steamos-readonly disable
cat "$nix_directory_service" > /etc/ststemd/system/nix-directory.service
cat "$nix_mount" > /etc/ststemd/system/nix.mount
cat "$ensure_simlinked_units_resolve_service" > \
/etc/ststemd/system/ensure-symlinked-units-resolve.service

systemctl enable --now ensure-symlinked-units-resolve.service
sh <(curl -L https://nixos.org/nix/install) --daemon

echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-custom-swappiness.conf
echo 0
echo "# Disabling swap..."
swapoff -a
echo 25
echo "# Creating new 8 GB swapfile (be patient, this can take between 10 seconds and 30 minutes)..."
dd if=/dev/zero of=/home/swapfile bs=1G count="8" status=none
echo 50
echo "# Setting permissions on swapfile..."
chmod 0600 /home/swapfile
echo 75
echo "# Initializing new swapfile..."
mkswap /home/swapfile  
swapon /home/swapfile 
steamos-readonly enable
