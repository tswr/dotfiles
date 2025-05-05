# dotfiles

Dotfiles are managed with [chezmoi](https://www.chezmoi.io/) in this repo.

## Installing Arch with dual boot
1. Have Windows installed before, make sure that its partitions are shrank so that Arch would fit.
1. Download iso from https://archlinux.org/download/, validate, use balena etcher to flash.
1.In BIOS set secure boot to Other OS and boot from USB flash drive.
1. Connect to wi-fi
    ```
    iwctl
    device list
    Station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect SSID
    ping archlinux.org
    ```
1. Sync time
    ```
    timedatectl
    ```
1. Add partitions
    ```
    fdisk -l
    fdisk /dev/nvme0n1
    n
    <enter>
    +1G
    n
    <enter>
    <enter>
    w
    ```
1. Initialize
    ```
    mkfs.ext4 /dev/nvme0n1p4
    mkfs.btrfs /dev/nvme0n1p5
    ```
1. Btrfs
    ```
    mount /dev/nvme0n1p5 /mnt
    btrfs subvolume create /mnt/@
    btrfs subvolume create /mnt/@home
    btrfs subvolume create /mnt/@log
    btrfs subvolume create /mnt/@pkg
    btrfs subvolume create /mnt/@snapshots
    btrfs subvolume create /mnt/@tmp
    umount /mnt
    ```
1. Mount all
    ```
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@ /dev/sda2 /mnt
    mkdir -p /mnt/{boot,home,var/log,var/cache/pacman/pkg,var/tmp,@snapshots}
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@home /dev/nvme0n1p3 /mnt/home
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@log /dev/nvme0n1p3 /mnt/var/log
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@pkg /dev/nvme0n1p3 /mnt/var/cache/pacman/pkg
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@tmp /dev/nvme0n1p3 /mnt/var/tmp
    mount -o noatime,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/nvme0n1p3 /mnt/@snapshots

    mount /dev/nvme0n1p4 /mnt/boot
    mkdir /mnt/boot/efi
    mount /dev/nvme0n1p1 /mnt/boot/efi
    ```
1. archinstall
1. agree to chroot
1. GRUB
    ```
    pacman -S grub efibootmgr os-prober
    nvim /etc/default/grub # GRUB_DISABELE_OS_PROBER=false
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
    ```
1. Nvidia
    ```
    sudo pacman -S nvidia-open-dkms
    sudo pacman -S cuda
    ```
1. Utils
    ```
    sudo pacman -S base-devel git clang rsync neovim tmux
    sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions starship
    sudo pacman -S eza bat fzf zoxide tldr btop neofetch ripgrep extra/bc fd less plocate man-db
    ```
1. Audio
    ```
    sudo pacman -S pavucontrol
    ``` 
1. AUR
    ```
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay/
    ```
1. Wayland
    ```
    sudo pacman -S kitty hyprland wofi waybar ttf-font-awesome hyprsunset hyprlock hypridle hyprpaper swaync
    yay -S hyprshot themix-full-git
    ```
    On Fedora:
    ```
    sudo dnf copr enable solopasha/hyprland
    sudo dnf install hyprland kitty wofi waybar hyprlock hypridle hyprpaper swaync hyprsunset hyprshot
    ```
1. Micromamba
    ```
    yay -S micromamba
    micromamba activate
    micromamba install numpy pandas scipy matplotlib plotly jupyter ipython sklearn -c conda-forge
    pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128
    ```
1. Tmux plugin manager
    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
1. Dotfiles
    ```
    sudo pacman -S chezmoi
    ```
    On Fedora:
    ```
    sh -c "$(curl -fsLS get.chezmoi.io)"
    ```
    Follow https://www.chezmoi.io/quick-start/.
1. VSCode insiders
    ```
    sudo pacman -S gnome-keyring libsecret
    yay -S visual-studio-code-insiders-bin
    ```
1. i3wm (outdated)
    ```
    sudo pacman -S luarocks feh polybar picom i3-wm i3lock dmenu xorg-xrandr redshift
    ```


## dependencies

For copilot:
```
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt install nodejs
```
