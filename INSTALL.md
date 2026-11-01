---

#formating_partition
- lsblk
- cfdisk /dev/nvme0n1
- mkfs.btrfs /dev/nvme(root part)
- mount /dev/nvme(root part) /mnt
- cd /mnt
- btrfs subvolume create @
- btrfs subvolume create @home
- cd
- pwd
- umount /mnt
- mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/nvme(root part) /mnt
- mkdir /mnt/home
- mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/nvme(root part) /mnt/home
- btrfs subvolume list /mnt
- mkfs.fat -F32 /dev/nvme(efi part)
- mkswap /dev/nvme(swap part)
- swapon /dev/nvme(swap part)
- mkdir /mnt/boot
- mount /dev/nvme(efi part) /mnt/boot
- lsblk
- lsblk -f

#connect_to_wifi
- iwctl station wlan0 scan
- iwctl station wlan0 get-networks
- iwctl --passphrase 'password' station wlan0 connect 'wifi ssid'

#linux_firmware
- pacstrap /mnt base linux linux-firmware
- genfstab -U /mnt > /mnt/etc/fstab
- arch-chroot /mnt

#arch_chrooting
- passwd
- ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime
- hwclock --systohc
- echo "KEYMAP=us" > /etc/vconsole.conf
- pacman -S nvim
- nvim /etc/locale.gen
- uncomment: en_US.UTF-8 UTF-8
- locale-gen
- echo "LANG=en_US.UTF-8" > /etc/locale.conf
- echo "user name" > /etc/hostname
- pacman -S grub efibootmgr sudo nvim  networkmanager git base-devel os-prober
- systemctl enable NetworkManager.service

#grub
- grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
- nvim /etc/default/grub
- GRUB_TIMEOUT=5 from 5 to 7
- add this line:
- GRUB_DISABLE_OS_PROBER=false
- grub-mkconfig -o /boot/grub/grub.cfg

#final_touches
- useradd -m -G wheel -s /bin/bash user name
- passwd user name
- EDITOR=nvim visudo
- uncomment this line: %wheel ALL=(ALL:ALL) ALL, its under: uncomment to allow members of group wheel to execute any commande
- usermod -aG audio,video,storage user name
- su user name
- sudo pacman -Syyu
- exit
- exit
- umount -R /mnt
- reboot 

---
- [?] whats required:
- ==🟣a working minimal arch installation with these packages: ==

```
sudo pacman -S nvim networkmanager git base-devel rust cargo python
```
- see the installation steps in: [[manual installation]]
# ==🟠connecting to wifi==
```
nmcli device wifi connect "wifi ssid" password "password"
```
# ==🟠enabling multilib==
```
sudo nvim /etc/pacman.conf
```
 - uncomment these two lines:
 ```
[multilib]
Include = /etc/pacman.d/mirrorlist
 ```

```
sudo pcman -Syu
```

# ==🟠compiling paru from source==
```
git clone https://aur.archlinux.org/paru.git
```

```
cd paru
```

```
makepkg -si
```

# ==🟠installing essential packages for a working hyprland==
```
sudo pacman -S pipewire pipewire-pulse pipewire-jack pipewire-alsa wireplumber pavucontrol wiremix lib32-mesa lib32-vulkan-icd-loader lib32-libglvnd lib32-alsa-plugins lib32-libpulse hyprland uwsm sddm hyprlock hyprsunset hyprpolkitagent qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-user-dirs swaync grim slurp satty wl-clipboard cliphist bluez bluez-utils bluetui impala brightnessctl swayosd power-profiles-daemon nautilus gvfs-mtp dolphin kitty btrfs-progs cava fuse3 noto-fonts noto-fonts-emoji ttf-nerd-fonts-symbols ttf-font-awesome ttf-jetbrains-mono-nerd cava network-manager-applet tumbler playerctl python-colorthief syncthing jq hypridle hyprpm qt5ct qt6ct kvantum 
```

```
paru -S vicinae-bin zen-browser-bin whatsapp-linux-desktop-bin waybar-cava mpvpaper wttrbar wlogout waypaper libinput-gestures obsidian-bin linux-wallpaperengine-git
```
# ==🟠starting essential services==
```
sudo systemctl enable sddm
```

``` 
sudo systemctl enable bluetooth
```

```
sudo systemctl enable power-profiles-daemon
```

```
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

```
systemctl --user enable syncthing
```

```
systemctl --user start syncthing
```

```
fc-cache -fv
```

```
sudo loginctl enable-linger $USER
```

`reboot`

# ==🟠setuping a working obsidian vault==
- copy or clone the ==🟣hypr, kitty, nvim, waybar, wlogout== folders to the ==🟣~/.config== dir
- `reboot`
- type ==🟣syncthing== in the terminal
- copy the obsidian vault folder from my phone to the laptop storage
- set up the obsidian folder syncthing settings
- test its working in send/receive
- proceed the following
# ==🟠installing additional apps and packages==
```
sudo pacman -S ffmpeg mpv awww fzf yazi zoxide rclone btop ffmpegthumbnailer speech-dispatcher python-pipx python-pip man-db man-pages gdb clang testdisk android-tools unzip tree flatpak kdeconnect docker docker-compose imv sushi ollama nodejs npm lsd veracrypt steam timeshift gparted cmatrix nvtop mpv obs-studio scrcpy torbrowser-launcher mangohud baobab qbittorrent wine winetricks libvirt qemu-full virt-manager virt-viewer libvirt dnsmasq ebtables iptables-nft swtpm edk2-ovmf virt-install qemu-img libosinfo guestfs-tools tauon-music-box gimp gnome-software flatpak nwg-look qt5ct qt6ct gnome-themes-extra dconf xdg-desktop-portal-gtk adw-gtk-theme gnome-tweaks gnome-control-center extension-manager gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav sushi zsh zsh-autosuggestions zsh-completions zsh-doc zsh-history-substring-search zsh-lovers zsh-syntax-highlighting zshdb discord
```

```
paru -S rclone fuse3 syncthingtray metadata-cleaner hypnotix waydroid freedownloadmanager ventoy-bin neofetch fastfetch mission-center angrysearch cpu-x kdiskmark geforcenow-electron-bin an-anime-game-launcher-bin goverlay peaclock localsend-bin lutris sklauncher-bin xclicker pacseek-bin qdiskinfo cpio cmake meson gcc lavat-git fetch-git vencord-installer telegram-desktop-bin pipes.sh ryzenadj wine brokkr-flash-appimage
```

```
pipx ensurepath
```

```
pipx install norminette
```

```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

```
flatpak update
```

`reboot`

```
flatpak install flathub -y io.github.kolunmi.Bazaar org.gnome.Maps org.vinegarhq.Sober com.usebottles.bottles com.github.tchx84.Flatseal org.gnome.Loupe com.jeffser.Alpaca com.github.tenderowl.frog de.schmidhuberj.tubefeeder com.rafaelmardojai.Blanket io.bassi.Amberol io.github.seadve.Mousai org.gnome.Music org.gnome.Showtime org.gnome.clocks org.gnome.Snapshot org.gnome.Calendar org.gnome.Calculator org.nickvision.tubeconverter app.twintaillauncher.ttl org.kde.kdenlive io.github.zarestia_dev.rclone-manager

```

# ==🟠installing hyprexpo==
```
hyprpm update
```

```
hyprpm add https://github.com/sandwichfarm/hyprexpo
```

```
hyprpm enable hyprexpo
```

```
hyprpm reload
```

# ==🟠applying dark theme and mac os tahoe dark theme==

- [!] run them in the right order
### ==🟣mac os tahoe dark theme==
```
git clone https://github.com/kayozxo/GNOME-macOS-Tahoe
```

```
cd GNOME-macOS-Tahoe
```

```
./install.sh
```

- choose the dark orange theme

### ==🟣dark theme==
```
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

```
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
```

```
mkdir -p ~/.config/xdg-desktop-portal
```

```
nvim ~/.config/xdg-desktop-portal/hyprland-portals.conf
```

- add these lines:
```
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.Settings=gtk
```

# ==🟠twilight cursor==
- download: `https://www.gnome-look.org/p/1607387`
- unzip it
- sudo cp -r ~/Downloads/Twilight-cursors /usr/share/icons/
- hyprctl setcursor Twilight-cursors 24
```
sudo nvim /etc/environment
```
- add these lines:
```
XCURSOR_THEME=Twilight-cursors 
XCURSOR_SIZE=24
```

```
gsettings set org.gnome.desktop.interface cursor-theme 'Twilight-cursors'
```

`reboot`

# ==🟠oh my zsh==
```
sudo usermod -s /usr/bin/zsh $USER
```

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```
nvim ~/.zshrc
```

- paste these at the very bottom:
```
# --- Load Arch System Plugins & Functions ---
fpath=(/usr/share/zsh/site-functions $fpath)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax Highlighting MUST be loaded last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

```
zsh
```

```
source ~/.zshrc
```

`reboot`

# ==🟠powerlevel10k==
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

# ==🟠cachy os repo==
```
/lib/ld-linux-x86-64.so.2 --help | grep supported
```

```
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
```

```
tar xvf cachyos-repo.tar.xz
```

```
cd cachyos-repo
```

```
sudo ./cachyos-repo.sh
```

```
cd
```

```
rm -rf cachyos-repo cachyos-repo.tar.xz
```

```
sudo pacman -Syu
```

```
grep -n "^\[" /etc/pacman.conf
```

# ==🟠cachy os kernel and scheduler==

### ==🟣kernel==
```
sudo pacman -S linux-cachyos linux-cachyos-headers
```

### ==🟣scheduler==
```
sudo pacman -S scx-scheds scx-tools
```

```
sudo mkdir -p /etc/scx_loader
```

```
sudo cp /usr/share/scx_loader/config.toml /etc/scx_loader/config.toml
```

```
sudo nvim /etc/scx_loader/config.toml
```

- paste these two lines:
```
default_sched = "scx_bpfland"
default_mode = "Gaming"
```

```
sudo systemctl enable --now scx_loader.service
```

### ==🟣grub default cachy os kernel==
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

- locate the cachy os kernel boot menu entry first:
```
grep menuentry /boot/grub/grub.cfg
```

```
sudo nvim /etc/default/grub
```

- delete these 2 lines if there any:
```
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

- paste the cachy os kernel boot menu entry u found:
```
GRUB_DEFAULT="Advanced options for Arch Linux>Arch Linux, with Linux linux-cachyos"
```

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

# ==🟠hibernation==
```
SWAP_UUID=$(lsblk -rno UUID,FSTYPE | awk '$2=="swap"{print $1}')
```

```
echo "$SWAP_UUID"
```

```
sudo sed -i "s|^\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"|\1 resume=UUID=$SWAP_UUID\"|" /etc/default/grub
```

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

`reboot`

# ==🟠systemd==
- copy ==🔴== to ==🟣vicinae-suspend@.service== to ==🟣/etc/systemd/system==

```
sudo systemctl daemon-reload
```

```
sudo systemctl enable vicinae-suspend@$USER.service
```

```
nvim /etc/systemd/logind.conf 
```

- uncomment or add these lines:
```
HandlePowerKey=ignore
HandlePowerKeyLongPress=ignore
HandleLidSwitch=ignore
```

`reboot`

# ==🟠additional configs==
### ==🔴aliases==
```
echo 'alias tdp1="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=1000 --fast-limit=1000 --slow-limit=1000"' >> ~/.zshrc
echo 'alias tdp2="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000"' >> ~/.zshrc
echo 'alias tdp3="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=3000 --fast-limit=3000 --slow-limit=3000"' >> ~/.zshrc
echo 'alias tdp4="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000"' >> ~/.zshrc
echo 'alias tdp5="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=5000 --fast-limit=5000 --slow-limit=5000"' >> ~/.zshrc
echo 'alias tdp6="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=6000 --fast-limit=6000 --slow-limit=6000"' >> ~/.zshrc
echo 'alias tdp7="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000"' >> ~/.zshrc
echo 'alias tdp8="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=8000 --fast-limit=8000 --slow-limit=8000"' >> ~/.zshrc
echo 'alias tdpreset="sudo ryzenadj --stapm-limit=28000 --fast-limit=64000 --slow-limit=28000 && sudo systemctl start power-profiles-daemon"' >> ~/.zshrc
source ~/.zshrc
echo 'alias ls="lsd"' >> ~/.zshrc
echo 'eval "$(zoxide init --cmd cd zsh)"' >> ~/.zshrc
```

```
source ~/.zshrc
```

### ==🔴libinput 4 fingers down to mute==
```
sudo gpasswd -a $USER input
```

```
nvim ~/.config/libinput-gestures.conf
```

- paste this:
```
gesture swipe down 4 pactl set-sink-mute @DEFAULT_SINK@ toggle
gesture swipe left 4 swaync-client -op -sw
gesture swipe right 4 swaync-client -cp -sw
```

```
libinput-gestures-setup autostart
```

```
libinput-gestures-setup start
```

`reboot`

### ==🔴bluetooth==
```
sudo rfkill unblock bluetooth
```

```
sudo systemctl start bluetooth
```

```
bluetoothctl power on
```

```
sudo systemctl enable bluetooth
```

```
sudo nvim /etc/bluetooth/main.conf
```

under ==🔴[policy]== paste:
```
AutoEnable=true
```

```
sudo nvim /etc/udev/rules.d/50-bluetooth.rules
```

paste:
```
SUBSYSTEM=="rfkill", ATTR{type}=="bluetooth", ATTR{state}="1"
```


### ==🔴open folders in gtk==
```
mkdir -p ~/.config/xdg-desktop-portal
```

```
nvim ~/.config/xdg-desktop-portal/hyprland-portals.conf
```

- add this line:
```
org.freedesktop.impl.portal.FileChooser=gtk
```

```
systemctl --user restart xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
```

```
xdg-mime default org.gnome.Nautilus.desktop inode/directory
```

### ==🔴openmouse permission==
```
   echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1d57", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/70-attackshark.rules
   sudo udevadm control --reload-rules
   sudo udevadm trigger
```

### ==🔴waydroid wifi==
```
sudo systemctl start waydroid-container
```

```
sudo systemctl enable iptables
```

```
sudo iptables -I FORWARD -i waydroid0 -j ACCEPT
```

```
sudo iptables -I FORWARD -o waydroid0 -j ACCEPT
```

```
sudo iptables -t nat -I POSTROUTING -s 192.168.240.0/24 -j MASQUERADE
```

```
sudo iptables-save | sudo tee /etc/iptables/iptables.rules
```

### ==🔴brokkr==
```
sudo tee /etc/udev/rules.d/51-brokkr-samsung.rules <<'EOF'
SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0660", TAG+="uaccess"
EOF
```

```
sudo udevadm control --reload-rules
```

```
sudo udevadm trigger
```
