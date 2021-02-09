# New Fedora 31 Installation

## Essential

```
sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf
sudo dnf update -y kernel && reboot
sudo dnf autoremove -y clipit # caused error on cliptboard
sudo dnf autoremove -y dnfdragora # not needed
sudo dnf autoremove -y leafpad # not needed
sudo dnf autoremove -y xpad # not needed
sudo dnf autoremove -y midori # not needed
sudo dnf autoremove -y xpad # not needed
sudo dnf autoremove -y sylpheed # not needed
```

## Custom Repositories

```
# RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# RPM Sphere, make sure to install RPM Fusion first
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-30-1.noarch.rpm

# Vivaldi Repo
sudo dnf install -y dnf-utils
sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
```

## Install ZSH, Oh-my-zsh, Powerlevel10k theme

```
# Install zsh
sudo dnf install -y zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Add mkcd command
cat >> ~/.zshrc << EOF
mkcd() {
    mkdir -p -- "\$1" && cd -P -- "\$1"
}
EOF

# Install plugin zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
sed -i -e 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc

# Install powerlevel10k recommended font
sudo mkdir /usr/share/fonts/meslo-lgs-nf && cd /usr/share/fonts/meslo-lgs-nf && sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20{Regular,Bold,Italic,Bold%20Italic}.ttf

# Install Hack NF font, need bsdtar package
sudo mkdir /usr/share/fonts/hack-nf
wget -qO- https://github.com/ryanoasis/nerd-fonts/releases/download/v$`curl -sSL https://github.com/ryanoasis/nerd-fonts/releases | sed -n '/Latest release<\/a>/,$p' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1 | cut -c2-`/Hack.zip | sudo bsdtar -xvf- -C /usr/share/fonts/hack-nf
sudo fc-cache -v

# set used plugins
sed -i -e 's/(git)/(git kubectl gcloud aws python docker docker-compose ansible zsh-autosuggestions zsh-interactive-cd tmux firewalld mosh nmap dnf sudo systemd adb pip zsh_reload)/g' ~/.zshrc

sudo dnf install -y powerline-fonts

p10k configure
```

## Install Lightdm

```
sudo dnf install -y lightdm numlockx slick-greeter lightdm-gtk-greeter-settings
sudo ln -sf /usr/lib/systemd/system/lightdm.service /etc/systemd/system/display-manager.service
sudo mv /usr/share/xsessions/openbox.desktop ~/
```

## Install Various App

```
sudo dnf install -y terminator # another terminal emulator
sudo dnf install -y firefox # web browser from mozilla
sudo dnf install -y chromium-freeworld # web browser from google (from RPMFusion-free repo)
sudo dnf install -y vivaldi-stable # web browser based on chromium (from vivaldi repo)
sudo dnf install -y remmina # best remote desktop client
sudo dnf install -y compton # enable transparancy
sudo dnf install -y vim # terminal text editor
sudo dnf install -y mosh # ssh alternative, make sure open port 60000-61000/udp
sudo dnf install -y persepolis # download manager
sudo dnf install -y ghostwriter # markdown editor
sudo dnf install -y pluma # text editor
sudo dnf install -y gparted gnome-disk-utility # partition editor
sudo dnf install -y xfce4-power-manager # power manager and brightness shortcut enable
sudo dnf install -y pinta # MS. Paint like picture editor
sudo dnf install -y lxhotkey # hotkey manager
sudo dnf install -y blueman # bluetooth manager
sudo dnf install -y gnome-screenshot # screenshot manager
sudo dnf install -y file-roller # archive manager
sudo dnf install -y telegram-desktop # telegram messanger (from RPMFusion-free repo)
sudo dnf install -y redshift-gtk # comfort screen color during night
sudo dnf install -y gvfs-smb # smb client for pcmanfm
sudo dnf install -y bookworm # Simple e-book reader, make sure to install rpmsphere repo first
sudo dnf install -y evince # PDF reader
sudo dnf install -y nethogs # network interface monitoring
sudo dnf install -y nmap # network port scanner
sudo dnf install -y aircrack-ng # Wireless network pentest tool
sudo dnf install -y dcfldd # Improved dd, useful for forensics and security
sudo dnf install -y lsd # Colorful ls
sudo dnf install -y bat # Full feature less
sudo dnf install -y tmux # Terminal multiplexer
sudo dnf install -y paprefs # PulseAudio Preferences
sudo dnf install -y NetworkManager-l2tp-gnome.x86_64 # VPN GUI configuration
sudo dnf install -y vlc # Media player
sudo dnf install -y android-tools # fastboot & adb
sudo dnf install -y fzf # command-line fuzzy finder
```

## Install Alacritty

```
dnf copr enable pschyska/alacritty
dnf install alacritty
```

## Install VIM air-line

```
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes

# Install vim plugin for git
git clone https://tpope.io/vim/fugitive.git ~/.vim/pack/tpope/start/fugitive
```

Then run these command inside vim to generate help tags

```
:helptags ~/.vim/pack/dist/start/vim-airline/doc
:helptags ~/.vim/pack/dist/start/vim-airline-themes/doc
```

## Install VScodium

```
sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg

sudo cat >> /etc/yum.repos.d/vscodium.repo << EOF
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
EOF

sudo dnf install -y codium
```

## Install PlayonLinux

```
sudo dnf config-manager --add-repo http://rpm.playonlinux.com/playonlinux.repo
curl http://rpm.playonlinux.com/public.gpg | gpg --import
sudo dnf install -y playonlinux jq
```

## Install VirtualBox

```
sudo dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras libxkbcommon
sudo dnf install VirtualBox-6.1
```

## Install Windows fonts

```
sudo dnf install -y dnf install -y curl cabextract xorg-x11-font-utils fontconfig
# download and install the rpm package from https://downloads.sourceforge.net/project/mscorefonts2/rpms
```

## Install Podman

Fedora 31 uses cgroup v2 which is not supported by docker

```
sudo dnf install -y podman
```

## Install Docker (instead of Podman)

```
curl https://get.docker.com | sh
sudo usermod -aG docker $USER
sudo sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 systemd.unified_cgroup_hierarchy=0\"/" /etc/default/grub
sudo grub2-mkconfig -o $(sudo find /boot -name grub.cfg -print -quit) # Make sure no disk drive with another OS attached
sudo reboot
```

## Change default network interface name to clasic

```
sudo sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 net.ifnames=0 biosdevname=0\"/" /etc/default/grub
sudo grub2-mkconfig -o $(sudo find /boot -name grub.cfg -print -quit) # Make 
sudo reboot
```

## Change boot timeout to 1 second

```
sudo sed -i 's/^\(GRUB_TIMEOUT=\)[0-9]\+$/\11/' /etc/default/grub
sudo grub2-mkconfig -o $(sudo find /boot -name grub.cfg -print -quit) # Make 
sudo reboot
```

## Enable swapfile

Save as *.sh file, and run with sudo

```
#!/bin/bash
dd if=/dev/zero of=/swapfile bs=1024 count=$((1024 * 1024 * 4))
chown root:root /swapfile
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
```

## Enable Touchpad click

Create:

```
/etc/X11/xorg.conf.d/30-touchpad.conf  
```

Content:

```
Section "InputClass"   
  Identifier "touchpad"  
  Driver "libinput"  
  MatchIsTouchpad "on"  
  Option "Tapping" "on"  
EndSection
```
