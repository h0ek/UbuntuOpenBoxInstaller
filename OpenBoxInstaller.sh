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
light and clean OpenBox machine. More info on GITHUB."
echo
 read -r -p "Are you sure? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
#Check root
#[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
#Install the packages required to build the VirtualBox Guest Additions
echo "Installing the packages required to build the VirtualBox Guest Additions"
apt -y install gcc make perl dkms
#Install VBoxAdditions
echo "Please mount CD with VirtualBox Guest Additions"
 read -r -p "Mounted? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
#Create dir and mount CD
echo "Mounting CDROM"
mkdir /media/vbox
mount /dev/cdrom /media/vbox/
echo "Installing VirtualBox Guest Additions"
sh /media/vbox/VBoxLinuxAdditions.run
#Eject CD and cleanup
eject
rm -R /media/vbox/
#Adding User to vboxsf
echo "Adding User to vboxsf"
usermod -aG vboxsf $user
#Installing all packages
echo "Installing all packages"
apt -y install nano mc htop wget curl sakura git net-tools bash-completion openbox obmenu rofi xinit libpam0g-dev libxcb1-dev xorg xauth compton firefox geany flameshot lxappearance tint2 conky i3lock-fancy nomacs zip unzip unrar p7zip neofetch
 fi
 fi
