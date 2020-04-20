#!/usr/bin/env bash

echo 'Install `opkg` or `ipkg` with "Easy Bootstrap Installer" from "Community Package Hub" source (https://www.cphub.net/)'
echo 'Press enter when done...'
read

IPKG="/opt/bin/ipkg"
PACKAGES="
    coreutils
    util-linux
"

${IPKG} install coreutils util-linux
