# Arch Linux + Hyprland installation guide

My "PERSONAL" notes for a manual Arch Linux install (btrfs, GRUB, UEFI) followed by the full Hyprland setup.

1. [Part 1: Manual Arch installation](#part-1-manual-arch-installation)
2. [Part 2: Post-install setup](#part-2-post-install-setup)

---

# Part 1: Manual Arch installation

Replace `<root>`, `<efi>` and `<swap>` with your partitions (for example `nvme0n1p2`), and `<username>` / `<hostname>` with your own values.

## 1. Partition and format

```bash
lsblk
cfdisk /dev/nvme0n1
```

Create the btrfs root with `@` and `@home` subvolumes:

```bash
mkfs.btrfs /dev/<root>
mount /dev/<root> /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
cd
umount /mnt
```

Mount the subvolumes:

```bash
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/<root> /mnt
mkdir /mnt/home
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/<root> /mnt/home
btrfs subvolume list /mnt
```

Format and mount the EFI partition, set up swap:

```bash
mkfs.fat -F32 /dev/<efi>
mkswap /dev/<swap>
swapon /dev/<swap>
mkdir /mnt/boot
mount /dev/<efi> /mnt/boot
lsblk -f
```

## 2. Connect to Wi-Fi

```bash
iwctl station wlan0 scan
iwctl station wlan0 get-networks
iwctl --passphrase '<password>' station wlan0 connect '<ssid>'
```

## 3. Install the base system

```bash
pacstrap /mnt base linux linux-firmware btrfs-progs amd-ucode
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt
```

> `amd-ucode` is for AMD CPUs. Use `intel-ucode` on Intel.

## 4. Configure the system (inside the chroot)

```bash
passwd
ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime
hwclock --systohc
echo "KEYMAP=us" > /etc/vconsole.conf
pacman -S neovim
```

Uncomment `en_US.UTF-8 UTF-8`, then generate the locale:

```bash
nvim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "<hostname>" > /etc/hostname
```

Install the essentials and enable networking:

```bash
pacman -S grub efibootmgr sudo networkmanager git base-devel os-prober
systemctl enable NetworkManager.service
```

## 5. Bootloader (GRUB)

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
nvim /etc/default/grub
```

In `/etc/default/grub`:

- set `GRUB_TIMEOUT=7`
- add this line: `GRUB_DISABLE_OS_PROBER=false`

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

## 6. Final touches

```bash
useradd -m -G wheel -s /bin/bash <username>
passwd <username>
EDITOR=nvim visudo
```

In `visudo`, uncomment this line (it is under "Uncomment to allow members of group wheel to execute any command"):

```
%wheel ALL=(ALL:ALL) ALL
```

```bash
usermod -aG audio,video,storage <username>
su <username>
sudo pacman -Syu
exit        # leave the user shell
exit        # leave the chroot
umount -R /mnt
reboot
```

---

# Part 2: Post-install setup

## Requirements

A working minimal Arch installation (see [Part 1](#part-1-manual-arch-installation)) with these packages:

```bash
sudo pacman -S neovim networkmanager git base-devel rust cargo python
```

## 1. Connect to Wi-Fi

```bash
nmcli device wifi connect "<ssid>" password "<password>"
```

## 2. Enable multilib

```bash
sudo nvim /etc/pacman.conf
```

Uncomment these two lines:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

```bash
sudo pacman -Syu
```

## 3. Compile paru from source

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## 4. Install the essential packages for a working Hyprland

```bash
sudo pacman -S pipewire pipewire-pulse pipewire-jack pipewire-alsa wireplumber pavucontrol wiremix lib32-mesa lib32-vulkan-icd-loader lib32-libglvnd lib32-alsa-plugins lib32-libpulse hyprland uwsm sddm hyprlock hyprsunset hyprpolkitagent qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-user-dirs swaync grim slurp satty wl-clipboard cliphist bluez bluez-utils bluetui impala brightnessctl swayosd power-profiles-daemon nautilus gvfs-mtp dolphin kitty btrfs-progs cava fuse3 noto-fonts noto-fonts-emoji ttf-nerd-fonts-symbols ttf-font-awesome ttf-jetbrains-mono-nerd network-manager-applet tumbler playerctl python-colorthief syncthing jq hypridle hyprpm qt5ct qt6ct kvantum
```

```bash
paru -S vicinae-bin zen-browser-bin whatsapp-linux-desktop-bin waybar-cava mpvpaper wttrbar wlogout waypaper libinput-gestures obsidian-bin
```

## 5. Start the essential services

```bash
sudo systemctl enable sddm
sudo systemctl enable bluetooth
sudo systemctl enable power-profiles-daemon
systemctl --user enable --now pipewire pipewire-pulse wireplumber
systemctl --user enable syncthing
systemctl --user start syncthing
fc-cache -fv
sudo loginctl enable-linger $USER
reboot
```

## 6. Set up a working Obsidian vault

1. Copy or clone the `hypr`, `kitty`, `nvim`, `waybar` and `wlogout` folders into `~/.config`.
2. `reboot`
3. Run `syncthing` in the terminal.
4. Copy the Obsidian vault folder from the phone to the laptop storage.
5. Set up the Obsidian folder in the Syncthing settings.
6. Test that send/receive works.
7. Continue with the next steps.

## 7. Install additional apps and packages

```bash
sudo pacman -S ffmpeg mpv awww fzf yazi zoxide rclone btop ffmpegthumbnailer speech-dispatcher python-pipx python-pip man-db man-pages gdb clang testdisk android-tools unzip tree flatpak kdeconnect docker docker-compose imv sushi ollama nodejs npm lsd veracrypt steam timeshift gparted cmatrix nvtop obs-studio scrcpy torbrowser-launcher mangohud baobab qbittorrent wine winetricks libvirt qemu-full virt-manager virt-viewer dnsmasq ebtables iptables-nft swtpm edk2-ovmf virt-install qemu-img libosinfo guestfs-tools tauon-music-box gimp gnome-software nwg-look gnome-themes-extra dconf xdg-desktop-portal-gtk adw-gtk-theme gnome-tweaks gnome-control-center extension-manager gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav zsh zsh-autosuggestions zsh-completions zsh-doc zsh-history-substring-search zsh-lovers zsh-syntax-highlighting zshdb
```

```bash
paru -S syncthingtray metadata-cleaner hypnotix waydroid freedownloadmanager ventoy-bin neofetch fastfetch mission-center angrysearch cpu-x kdiskmark geforcenow-electron-bin an-anime-game-launcher-bin goverlay peaclock localsend-bin lutris sklauncher-bin xclicker pacseek-bin qdiskinfo cpio cmake meson gcc lavat-git fetch-git vencord-installer telegram-desktop-bin pipes.sh ryzenadj discord
```

```bash
pipx ensurepath
pipx install norminette
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
reboot
```

```bash
flatpak install flathub -y io.github.kolunmi.Bazaar org.gnome.Maps org.vinegarhq.Sober com.usebottles.bottles com.github.tchx84.Flatseal org.gnome.Loupe com.jeffser.Alpaca com.github.tenderowl.frog de.schmidhuberj.tubefeeder com.rafaelmardojai.Blanket io.bassi.Amberol io.github.seadve.Mousai org.gnome.Music org.gnome.Showtime org.gnome.clocks org.gnome.Snapshot org.gnome.Calendar org.gnome.Calculator org.nickvision.tubeconverter app.twintaillauncher.ttl org.kde.kdenlive io.github.zarestia_dev.rclone-manager
```

## 8. Install hyprexpo

```bash
hyprpm update
hyprpm add https://github.com/sandwichfarm/hyprexpo
hyprpm enable hyprexpo
hyprpm reload
```

## 9. Dark theme and macOS Tahoe dark theme

> [!IMPORTANT]
> Run these in the right order.

### macOS Tahoe dark theme

```bash
git clone https://github.com/kayozxo/GNOME-macOS-Tahoe
cd GNOME-macOS-Tahoe
./install.sh
```

Choose the dark orange theme.

### Dark theme

```bash
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
mkdir -p ~/.config/xdg-desktop-portal
nvim ~/.config/xdg-desktop-portal/hyprland-portals.conf
```

Add these lines:

```ini
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.Settings=gtk
```

## 10. Twilight cursor

1. Download it from <https://www.gnome-look.org/p/1607387> and unzip it.
2. Install and apply it:

```bash
sudo cp -r ~/Downloads/Twilight-cursors /usr/share/icons/
hyprctl setcursor Twilight-cursors 24
sudo nvim /etc/environment
```

Add these lines to `/etc/environment`:

```
XCURSOR_THEME=Twilight-cursors
XCURSOR_SIZE=24
```

```bash
gsettings set org.gnome.desktop.interface cursor-theme 'Twilight-cursors'
reboot
```

## 11. Oh My Zsh

```bash
sudo usermod -s /usr/bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
nvim ~/.zshrc
```

Paste this at the very bottom of `~/.zshrc`:

```bash
# --- Load Arch System Plugins & Functions ---
fpath=(/usr/share/zsh/site-functions $fpath)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax Highlighting MUST be loaded last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

```bash
zsh
source ~/.zshrc
reboot
```

## 12. Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

## 13. CachyOS repo

Check which x86-64 level your CPU supports:

```bash
/lib/ld-linux-x86-64.so.2 --help | grep supported
```

```bash
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh
cd
rm -rf cachyos-repo cachyos-repo.tar.xz
sudo pacman -Syu
grep -n "^\[" /etc/pacman.conf
```

## 14. CachyOS kernel and scheduler

### Kernel

```bash
sudo pacman -S linux-cachyos linux-cachyos-headers
```

### Scheduler

```bash
sudo pacman -S scx-scheds scx-tools
sudo mkdir -p /etc/scx_loader
sudo cp /usr/share/scx_loader/config.toml /etc/scx_loader/config.toml
sudo nvim /etc/scx_loader/config.toml
```

Paste these two lines:

```toml
default_sched = "scx_bpfland"
default_mode = "Gaming"
```

```bash
sudo systemctl enable --now scx_loader.service
```

### Make the CachyOS kernel the GRUB default

First, locate the CachyOS kernel menu entry:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
grep menuentry /boot/grub/grub.cfg
sudo nvim /etc/default/grub
```

Delete these two lines if they exist:

```
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

Paste the CachyOS kernel menu entry you found:

```
GRUB_DEFAULT="Advanced options for Arch Linux>Arch Linux, with Linux linux-cachyos"
```

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## 15. Additional configs

### Aliases

> Skip this step if you copied `.zshrc` from this repo. It already contains them, and running this again would add duplicates.

```bash
echo 'alias tdp1="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=1000 --fast-limit=1000 --slow-limit=1000"' >> ~/.zshrc
echo 'alias tdp2="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000"' >> ~/.zshrc
echo 'alias tdp3="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=3000 --fast-limit=3000 --slow-limit=3000"' >> ~/.zshrc
echo 'alias tdp4="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000"' >> ~/.zshrc
echo 'alias tdp5="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=5000 --fast-limit=5000 --slow-limit=5000"' >> ~/.zshrc
echo 'alias tdp6="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=6000 --fast-limit=6000 --slow-limit=6000"' >> ~/.zshrc
echo 'alias tdp7="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000"' >> ~/.zshrc
echo 'alias tdp8="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=8000 --fast-limit=8000 --slow-limit=8000"' >> ~/.zshrc
echo 'alias tdpreset="sudo ryzenadj --stapm-limit=28000 --fast-limit=64000 --slow-limit=28000 && sudo systemctl start power-profiles-daemon"' >> ~/.zshrc
echo 'alias ls="lsd"' >> ~/.zshrc
echo 'eval "$(zoxide init --cmd cd zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### libinput: 4 fingers down to mute

```bash
sudo gpasswd -a $USER input
nvim ~/.config/libinput-gestures.conf
```

Paste this:

```
gesture swipe down 4 pactl set-sink-mute @DEFAULT_SINK@ toggle
```

```bash
libinput-gestures-setup autostart
libinput-gestures-setup start
reboot
```

### Bluetooth

```bash
sudo rfkill unblock bluetooth
sudo systemctl start bluetooth
bluetoothctl power on
sudo systemctl enable bluetooth
sudo nvim /etc/bluetooth/main.conf
```

Under `[Policy]` paste:

```ini
AutoEnable=true
```

```bash
sudo nvim /etc/udev/rules.d/50-bluetooth.rules
```

Paste:

```
SUBSYSTEM=="rfkill", ATTR{type}=="bluetooth", ATTR{state}="1"
```

### systemd

Copy `vicinae-suspend@.service` to `/etc/systemd/system/`, then:

```bash
sudo systemctl daemon-reload
sudo systemctl enable vicinae-suspend@$USER.service
```

Ignore the power button and lid switch with a logind drop-in:

```bash
sudo mkdir -p /etc/systemd/logind.conf.d
sudo nvim /etc/systemd/logind.conf.d/10-ignore.conf
```

Paste:

```ini
[Login]
HandlePowerKey=ignore
HandlePowerKeyLongPress=ignore
HandleLidSwitch=ignore
```

```bash
reboot
```

### Hibernation

> Your swap should be at least as big as your RAM.

Get the swap UUID and add it to the kernel command line:

```bash
SWAP_UUID=$(lsblk -rno UUID,FSTYPE | awk '$2=="swap"{print $1}')
echo "$SWAP_UUID"
sudo sed -i "s|^\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"|\1 resume=UUID=$SWAP_UUID\"|" /etc/default/grub
```

Add the `resume` hook to `HOOKS` in `/etc/mkinitcpio.conf` (after `udev`, before `filesystems`), then rebuild:

```bash
sudo nvim /etc/mkinitcpio.conf
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
reboot
```
