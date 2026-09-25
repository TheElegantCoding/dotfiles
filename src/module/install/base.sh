info "Updating mirror list with the latest 5 US mirrors"
sleep 0.5
reflector --latest 5 --country US --protocol https --sort rate --save /etc/pacman.d/mirrorlist || true

info "Installing base packages..."
sleep 0.5
pacstrap -K /mnt base linux linux-firmware networkmanager vim base-devel intel-ucode || error "Falló pacstrap."

success "Base packages installed successfully."
sleep 0.5

info "Generating fstab..."
sleep 0.5

genfstab -U /mnt >> /mnt/etc/fstab

success "fstab written successfully."
sleep 0.5