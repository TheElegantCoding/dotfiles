#!/bin/bash
set -e

RESET="\033[0m"
BOLD="\033[1m"

BG_INFO="\033[44;37m"
BG_SUCCESS="\033[42;30m"
BG_ERROR="\033[41;37m"
GREY="\033[38;2;125;125;125m"

timestamp() {
  echo -e "${GREY}$(date +"%H:%M:%S")${RESET}"
}

info() {
  echo -e "$(timestamp) ${BOLD}${BG_INFO} INFO ${RESET} $1"
}

info_inline() {
  echo -en "$(timestamp) ${BOLD}${BG_INFO} INFO ${RESET} $1"
}

success() {
  echo -e "$(timestamp) ${BOLD}${BG_SUCCESS} SUCCESS ${RESET} $1"
}

error() {
  echo -e "$(timestamp) ${BOLD}${BG_ERROR} ERROR ${RESET} $1"
  exit 1
}

echo ""
info "Starting Arch Linux installation process..."

info "Disk available in the system:\n"
fdisk -l
echo ""

info_inline "Select the target disk for installation (ej. /dev/sda):"
read -p "" TARGET_DISK

if [ ! -b "$TARGET_DISK" ] && [ ! -e "$TARGET_DISK" ]; then
  error "The specified disk does not exist or is not valid."
fi

info "You have selected the disk: ${BOLD}${TARGET_DISK}${RESET}"

if [[ "$TARGET_DISK" =~ "nvme" ]]; then
  PART_EFI="${TARGET_DISK}p1"
  PART_SWAP="${TARGET_DISK}p2"
  PART_ROOT="${TARGET_DISK}p3"
  PART_HOME="${TARGET_DISK}p4"
else
  PART_EFI="${TARGET_DISK}1"
  PART_SWAP="${TARGET_DISK}2"
  PART_ROOT="${TARGET_DISK}3"
  PART_HOME="${TARGET_DISK}4"
fi

info "Configuring partition sizes..."
info "You can use formats like 1G, 512M, 50G, etc."

info "Partition size for the EFI partition:"
read -p "" EFI_SIZE

info "Partition size for the Swap partition:"
read -p "" SWAP_SIZE

info "Partition size for the Root partition:"
read -p "" ROOT_SIZE

info "Creating GPT partition table on ${TARGET_DISK}..."

sfdisk "${TARGET_DISK}" <<EOF
label: gpt
size=${EFI_SIZE}, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
size=${SWAP_SIZE}, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
size=${ROOT_SIZE}, type=0FC63DAF-8483-4772-8E79-3D69d8477DE4
type=0FC63DAF-8483-4772-8E79-3D69d8477DE4
EOF

success "Partitions created successfully."

info "Formatting partitions..."

mkfs.ext4 "$PART_ROOT" || error "Failed to format Root."
mkfs.ext4 "$PART_HOME" || error "Failed to format Home."
mkfs.fat -F 32 "$PART_EFI" || error "Failed to format EFI."
mkswap "$PART_SWAP" || error "Failed to configure Swap."

success "Particiones formateadas con éxito."

info "Montando particiones en /mnt..."

mount "$PART_ROOT" /mnt || error "Failed to mount Root."
mkdir -p /mnt/boot /mnt/home || error "Failed to create mount points."
mount "$PART_EFI" /mnt/boot || error "Failed to mount EFI."
mount "$PART_HOME" /mnt/home || error "Failed to mount Home."
swapon "$PART_SWAP" || error "Failed to enable Swap."

success "Partitions mounted successfully."

# # ==========================================
# # INSTALACIÓN BASE Y PAQUETES
# # ==========================================
# info "Actualizando espejos y ejecutando pacstrap..."
# reflector --latest 5 --country US --protocol https --sort rate --save /etc/pacman.d/mirrorlist || true
# pacstrap -K /mnt base linux linux-firmware networkmanager vim base-devel intel-ucode || error "Falló pacstrap."
# success "Paquetes base instalados."
#
# info "Generando fstab..."
# genfstab -U /mnt >> /mnt/etc/fstab
# success "fstab generado."
#
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