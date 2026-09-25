#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/module/install/lib.sh"
# source "$DIR/src/module/install/partition.sh"
# source "$DIR/src/module/install/base.sh"
source "$DIR/src/module/install/arch.sh"


# success "¡Instalación completada con éxito!"
# info "Desmonta y reinicia con: umount -R /mnt && reboot"