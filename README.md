# OpenBoxUbuntuInstaller
OpenBox windows manager installer for Minimal Ubuntu.
(Mostly tested on VirtualBox but maybe it also works on physical machine)

THIS IS JUST A TEST. DO NOT USE IT YET.
(Development version, early alpha)

1. Install [Ubuntu Minimal](http://archive.ubuntu.com/ubuntu/dists/disco/main/installer-amd64/current/images/netboot/mini.iso).
During installation select your language, time zone, keyboard layout, create user with password, do not select any additional packages. Once done, reboot machine go to step 2.

2. Login using your username and password, download and run the script. Just copy the command below to your terminal and hit enter.
```bash
bash <(wget -qO- https://raw.githubusercontent.com/h0ek/UbuntuOpenBoxInstaller/master/OpenBoxInstaller.sh)
```
3. Follow the instructions on the screen.
