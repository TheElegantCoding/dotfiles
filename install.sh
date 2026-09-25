#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/module/install/lib.sh"
# source "$DIR/src/module/install/partition.sh"
source "$DIR/src/module/install/base.sh"

# source "$DIR/pacstrap.sh"
# source "$DIR/configure.sh"


# # ==========================================
# # CONFIGURACIÓN CHROOT
# # ==========================================
# info "Configurando el sistema dentro del chroot..."
# arch-chroot /mnt <<EOF
# set -e
#
# ln -sf /usr/share/zoneinfo/America/Caracas /etc/localtime
# hwclock --systohc
#
# sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
# sed -i "s/#en_US ISO-8859-1/en_US ISO-8859-1/" /etc/locale.gen
# locale-gen
# echo "LANG=en_US.UTF-8" > /etc/locale.conf
#
# echo "LuisdaByte" > /etc/hostname
# systemctl enable NetworkManager
#
# echo "root:rootpassword" | chpasswd
# useradd -m -G wheel,users LuisdaByte
# echo "LuisdaByte:userpassword" | chpasswd
# echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
#
# pacman -S --noconfirm grub efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
# EOF
#
# success "¡Instalación completada con éxito!"
# info "Desmonta y reinicia con: umount -R /mnt && reboot"