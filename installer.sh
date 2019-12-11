#!/bin/bash
set -e
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
light and clean OpenBox machine. More info on GITHUB.
https://github.com/h0ek/UbuntuOpenBoxInstaller/blob/master/README.md"
read -rsn1 -p "Press any key to continue";echo
#Check root
#[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
#Install the packages required to build the VirtualBox Guest Additions
#read -r -p "Do you want to install VirtualBox Guest Additions? [y/N] " response
#if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
#then
echo "Checking if this is virtual environment"
VBOXCHECK="sudo dmidecode -s system-product-name"
if ["${VBOXCHECK}" = VirtualBox];
then echo "This is a VirtualBox! Installing the packages required to build the VirtualBox Guest Additions"
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
else echo "This is not a virtual machine, going to the next step"; 
fi;
#Updating repositories and packages
echo "Updating repositories and packages"
sudo apt update && sudo apt -y dist-upgrade
#Installing all packages
echo "Installing all packages"
read -rsn1 -p "Press any key to continue";echo
sudo apt -y install nano mc htop wget curl sakura git net-tools bash-completion openbox obmenu rofi xinit libpam0g-dev libxcb1-dev xorg xauth compton firefox geany flameshot lxappearance tint2 conky i3lock-fancy nomacs zip unzip unrar p7zip neofetch feh
fi
echo "Installing obmenu-generator"
read -rsn1 -p "Press any key to continue";echo
wget https://download.opensuse.org/repositories/home:/Head_on_a_Stick:/obmenu-generator/Debian_Unstable/all/obmenu-generator_0.85-3_all.deb
sudo apt -y install ./obmenu-generator_0.85-3_all.deb
echo "Installing Papirus Icons Pack"
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
echo "Installing ly diplay manager"
sudo git clone https://github.com/cylgom/ly.git /opt/ly/
sudo make github -C /opt/ly/ 
sudo make -C /opt/ly/
sudo make install -C /opt/ly/
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service
sudo rm ./obmenu-generator_0.85-3_all.deb
#Removing unnecessary packages
echo "Removing unnecessary packages"
sudo apt -y purge vim*
#Package cleanup
echo "apt cleanup"
sudo apt -y autoremove && sudo apt autoclean
#All done! Reboot.
read -rsn1 -p "All done! Press any key to reboot";echo
sudo shutdown -r now
