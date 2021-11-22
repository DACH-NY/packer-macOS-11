#!/usr/bin/env bash
# Copyright (c) 2021 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

echo "nix" > "$1/private/etc/synthetic.conf"

# Increase shared memory allocation for PostGresQL on MacOS
cat > "$1/private/etc/sysctl.conf" <<END
kern.sysv.shmmax=16777216
kern.sysv.shmmin=1
kern.sysv.shmmni=128
kern.sysv.shmseg=32
kern.sysv.shmall=4096
END

sudo dscl . -create /Users/vagrant
sudo dscl . -create /Users/vagrant UserShell /bin/bash
sudo dscl . -create /Users/vagrant RealName vagrant
sudo dscl . -create /Users/vagrant UniqueID 1001
sudo dscl . -create /Users/vagrant PrimaryGroupID 1000
sudo dscl . -create /Users/vagrant NFSHomeDirectory /Users/vagrant
sudo dscl . -passwd /Users/vagrant vagrant
sudo dscl . -append /Groups/admin GroupMembership vagrant

cat > /etc/sudoers.d/vagrant <<END
vagrant ALL=(ALL) NOPASSWD: ALL
END

mkdir /Users/vagrant
chown vagrant:staff /Users/vagrant
chmod 0700 /Users/vagrant

mkdir /Users/vagrant/.ssh
chown vagrant:staff /Users/vagrant/.ssh
chmod 0710 /Users/vagrant/.ssh

cat > /Users/vagrant/.ssh/authorized_keys <<END
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
END

chown vagrant:staff /Users/vagrant/.ssh/authorized_keys
chmod 0600 /Users/vagrant/.ssh/authorized_keys

dseditgroup -o edit -a admin -t group com.apple.access_ssh
