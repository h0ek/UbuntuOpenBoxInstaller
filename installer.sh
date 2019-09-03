#!/bin/bash
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
read -rsn1 -p "Press any key to continue";echo
#Check root
#[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
#Install the packages required to build the VirtualBox Guest Additions
echo "Installing the packages required to build the VirtualBox Guest Additions"
sudo apt -y install gcc make perl dkms
#Install VBoxAdditions
echo "Please mount CD with VirtualBox Guest Additions"
read -rsn1 -p "Press any key to continue";echo
#Create dir and mount CD
echo "Mounting CDROM"
sudo mkdir /media/vbox
sudo mount /dev/cdrom /media/vbox/
echo "Installing VirtualBox Guest Additions"
sudo sh /media/vbox/VBoxLinuxAdditions.run
#Eject CD and cleanup
sudo eject
sudo rm -R /media/vbox/
#Adding User to vboxsf
echo "Adding User to vboxsf"
sudo usermod -aG vboxsf $user
#Installing all packages
echo "Installing all packages"
read -rsn1 -p "Press any key to continue";echo
sudo apt -y install nano mc htop wget curl sakura git net-tools bash-completion openbox obmenu rofi xinit libpam0g-dev libxcb1-dev xorg xauth compton firefox geany flameshot lxappearance tint2 conky i3lock-fancy nomacs zip unzip unrar p7zip neofetch
echo "Installing obmenu-generator"
read -rsn1 -p "Press any key to continue";echo
wget https://download.opensuse.org/repositories/home:/Head_on_a_Stick:/obmenu-generator/Debian_Unstable/all/obmenu-generator_0.85-3_all.deb
sudo apt -y install ./obmenu-generator_0.85-3_all.deb
read -r -p "Do you want to install Papirus Icons Theme? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
echo "Installing Papirus Icons Pack"
read -rsn1 -p "Press any key to continue";echo
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
else
echo "Installing ly diplay manager"
read -rsn1 -p "Press any key to reboot";echo
cd /opt/
sudo git clone https://github.com/cylgom/ly.git
cd /ly/
sudo make github
sudo make
sudo make install
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service
sudo rm ./obmenu-generator_0.85-3_all.deb
read -rsn1 -p "Press any key to reboot";echo
sudo shutdown -r now
fi
