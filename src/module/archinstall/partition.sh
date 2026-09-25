#!/bin/bash
info "Starting Arch Linux installation process..."
sleep 0.5

info "Disk available in the system:"
echo ""
sleep 0.5
fdisk -l
echo ""

info_inline "Select the target disk for installation (ej. /dev/sda): "
read -p "" TARGET_DISK

if [ ! -b "$TARGET_DISK" ] && [ ! -e "$TARGET_DISK" ]; then
  error "The specified disk does not exist or is not valid."
fi

info "You have selected the disk: ${BOLD}${TARGET_DISK}${RESET}"
sleep 0.5

echo ""
warning "This will erase all data on ${TARGET_DISK}"
info_inline "Are you sure you want to format and partition this disk? (y/N): "
read -p "" CONFIRM

CONFIRM=$(echo "$CONFIRM" | tr '[:upper:]' '[:lower:]')

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "yes" ]]; then
  info "Installation canceled by the user."
  exit 0
fi

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
sleep 0.5
info "You can use formats like 1G, 512M, 50G, etc."

info "Partition size for the EFI partition (recommended 1G): "
read -p "" EFI_SIZE

info "Partition size for the Swap partition (recommended 4G): "
read -p "" SWAP_SIZE

info "Partition size for the Root partition (recommended 64G): "
read -p "" ROOT_SIZE

info "Creating GPT partition table on ${TARGET_DISK}..."
sleep 0.5

sfdisk "${TARGET_DISK}" <<EOF
label: gpt
size=${EFI_SIZE}, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
size=${SWAP_SIZE}, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
size=${ROOT_SIZE}, type=0FC63DAF-8483-4772-8E79-3D69d8477DE4
type=0FC63DAF-8483-4772-8E79-3D69d8477DE4
EOF

success "Partitions created successfully."

info "Formatting partitions..."
sleep 0.5

mkfs.ext4 "$PART_ROOT" || error "Failed to format Root."
mkfs.ext4 "$PART_HOME" || error "Failed to format Home."
mkfs.fat -F 32 "$PART_EFI" || error "Failed to format EFI."
mkswap "$PART_SWAP" || error "Failed to configure Swap."

success "Partitions formatted successfully."

info "Mounting partitions on /mnt..."
sleep 0.5

mount "$PART_ROOT" /mnt || error "Failed to mount Root."
mkdir -p /mnt/boot /mnt/home || error "Failed to create mount points."
mount "$PART_EFI" /mnt/boot || error "Failed to mount EFI."
mount "$PART_HOME" /mnt/home || error "Failed to mount Home."
swapon "$PART_SWAP" || error "Failed to enable Swap."

success "Partitions mounted successfully."