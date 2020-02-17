# New Fedora 31 Installation

## Essential

```
echo "fastestmirror=trus" >> /etc/dnf/dnf.conf
dnf update -y kernel && reboot
dnf update -y
dnf autoremove clipit # caused error on cliptboard
```

### Install ZSH, Oh-my-zsh, Powerlevel10k theme

```
# Install zsh
dnf install -y zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
sed -i -e 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc
```

## Install Lightdm

```
dnf install lightdm numlockx slick-greeter lightdm-gtk-greeter-settings
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
```

## Install VScodium

```
sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg

printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo

dnf install codium
```
