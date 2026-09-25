info "Updating mirror list with the latest 5 US mirrors"
sleep 0.5
reflector --latest 5 --country US --protocol https --sort rate --save /etc/pacman.d/mirrorlist || true

info "Detecting CPU vendor for microcode installation..."
sleep 0.5

CPU_VENDOR=$(grep -m 1 "vendor_id" /proc/cpuinfo | awk '{print $3}')

if [[ "$CPU_VENDOR" == "GenuineIntel" ]]; then
  UCODE_PKG="intel-ucode"
  info "Intel CPU detected. Selected package: ${BOLD}${UCODE_PKG}${RESET}"
elif [[ "$CPU_VENDOR" == "AuthenticAMD" ]]; then
  UCODE_PKG="amd-ucode"
  info "AMD CPU detected. Selected package: ${BOLD}${UCODE_PKG}${RESET}"
else
  UCODE_PKG=""
  warning "Unknown CPU vendor. Skipping microcode installation."
fi

info "Installing base packages..."
sleep 0.5
pacstrap -K /mnt base linux linux-firmware networkmanager vim base-devel $UCODE_PKG || error "Falló pacstrap."

success "Base packages installed successfully."
sleep 0.5

info "Generating fstab..."
sleep 0.5

genfstab -U /mnt >> /mnt/etc/fstab

success "fstab written successfully."
sleep 0.5