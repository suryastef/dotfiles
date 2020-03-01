# New Fedora 31 Installation

## Essential

```
echo "fastestmirror=true" >> /etc/dnf/dnf.conf
dnf update -y kernel && reboot
dnf autoremove -y clipit # caused error on cliptboard
dnf autoremove -y dnfdragora # not needed
dnf autoremove -y leafpad # not needed
dnf autoremove -y xpad # not needed
dnf autoremove -y midori # not needed
dnf autoremove -y xpad # not needed
dnf autoremove -y sylpheed # not needed
```

## Custom Repositories

```
# RPMFusion
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

## Install ZSH, Oh-my-zsh, Powerlevel10k theme

```
# Install zsh
dnf install -y zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install plugin zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
sed -i -e 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc

# set used plugins
sed -i -e 's/(git)/(git kubectl gcloud aws python docker docker-compose ansible zsh-autosuggestions)/g' ~/.zshrc

sudo dnf install -y powerline-fonts

p10k configure
```

## Install Lightdm

```
dnf install -y lightdm numlockx slick-greeter lightdm-gtk-greeter-settings
ln -sf /usr/lib/systemd/system/lightdm.service /etc/systemd/system/display-manager.service
mv /usr/share/xsessions/openbox.desktop ~/
```

## Install Container Engine (Podman)

Fedora 31 uses cgroup v2 which is not supported by docker

```
dnf install -y podman
```

## Install Various App

```
dnf install -y terminator # another terminal emulator
dnf install -y remmina # best remote desktop client
dnf install -y compton # enable transparancy
dnf install -y vim # terminal text editor
dnf install -y persepolis # download manager
dnf install -y ghostwriter # markdown editor
dnf install -y pluma # text editor
dnf install -y gparted # partition editor
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

dnf install -y codium
```

## Install Chromium

Make sure RPMFusion repositories (free and non-free) are installed

```
dnf install -y chromium-freeworld
```

## Install PlayonLinux

```
dnf config-manager --add-repo http://rpm.playonlinux.com/playonlinux.repo
curl http://rpm.playonlinux.com/public.gpg | gpg --import
dnf install playonlinux
```

## Install VirtualBox

```
dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
dnf install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras libxkbcommon
dnf install VirtualBox-6.1
```