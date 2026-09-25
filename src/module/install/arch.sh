#!/bin/bash
info "Configuring user accounts and credentials..."
echo ""

info_inline "Enter your username: "
read -p "" USER_NAME

while true; do
  info "Enter the password for the new user $BOLD${USER_NAME}$RESET:"
  read -s -p "Password: " USER_PASS

  read -s -p "Confirm password: " USER_PASS_CONFIRM
  echo ""

  if [ "$USER_PASS" = "$USER_PASS_CONFIRM" ]; then
    break
  fi

  warning "Passwords do not match. Please try again."
  echo ""
done

echo ""

while true; do
  info "Enter the password for the $BOLD(root)$RESET user:s"
  read -s -p "Root password: " ROOT_PASS

  read -s -p "Confirm root password: " ROOT_PASS_CONFIRM
  echo ""

  if [ "$ROOT_PASS" = "$ROOT_PASS_CONFIRM" ]; then
    break
  fi

  warning "Root passwords do not match. Please try again."
  echo ""
done

info "Configuring the system inside the chroot..."
sleep 0.5

arch-chroot /mnt /bin/bash <<EOF
set -e

ln -sf /usr/share/zoneinfo/America/Caracas /etc/localtime
hwclock --systohc

sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
sed -i "s/#en_US ISO-8859-1/en_US ISO-8859-1/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "${USER_NAME}" > /etc/hostname
systemctl enable NetworkManager

echo "root:${ROOT_PASS}" | chpasswd
useradd -m -G wheel,users "${USER_NAME}"
echo "${USER_NAME}:${USER_PASS}" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
EOF

success "System configured successfully inside chroot."