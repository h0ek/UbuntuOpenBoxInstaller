cat << "EOF"
 _____ ______  _____  _   _ ______  _____ __   __
|  _  || ___ \|  ___|| \ | || ___ \|  _  |\ \ / /
| | | || |_/ /| |__  |  \| || |_/ /| | | | \ V / 
| | | ||  __/ |  __| | . ` || ___ \| | | | /   \ 
\ \_/ /| |    | |___ | |\  || |_/ /\ \_/ // /^\ \
 \___/ \_|    \____/ \_| \_/\____/  \___/ \/   \/
 _____  _   _  _____  _____  ___   _      _      _____ ______ 
|_   _|| \ | |/  ___||_   _|/ _ \ | |    | |    |  ___|| ___ \
  | |  |  \| |\ `--.   | | / /_\ \| |    | |    | |__  | |_/ /
  | |  | . ` | `--. \  | | |  _  || |    | |    |  __| |    / 
 _| |_ | |\  |/\__/ /  | | | | | || |____| |____| |___ | |\ \ 
 \___/ \_| \_/\____/   \_/ \_| |_/\_____/\_____/\____/ \_| \_| v.0.1
                                                              
EOF
echo "This script will install and configure OpenBox window manager 
with some software and customized configuration files. It works 
only with clean and minimal Ubuntu installation. After all it will be
light and clean OpenBox machine."
echo
#Check root
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
#Install packages
mkdir /media/vbox
mount /dev/cdrom /media/vbox/
sh /media/vbox/VBoxLinuxAdditions.run
eject
usermod -aG vboxsf $user
apt get install nano mc htop wget curl sakura git net-tools bash-completion openbox obmenu rofi xinit install libpam0g-dev libxcb1-dev xorg xauth compton firefox geany flameshot lxappearance tint2 conky i3lock-fancy nomacs zip unzip unrar p7zip neofetch
