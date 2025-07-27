#!/bin/bash
set -euo pipefail

if [ "$(whoami)" != "chronos" ]; then
    echo "[!] please run this script as user 'chronos'"
    exit 1
fi

echo "[*] installing chromebrew..."

if ! command -v crew &>/dev/null; then
    rm -rf /usr/local/*
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/skycocker/chromebrew/master/install.sh)"
else
    echo "[*] chromebrew already installed"
fi

if ! echo "$PATH" | grep -q "/usr/local/bin"; then
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
    export PATH="/usr/local/bin:$PATH"
fi

echo "[*] installing packages via crew..."

packages=(
    gcc
    make
    g++
    git
    curl
    wget
    vim
    nano
    python3
    python
    python3-pip
    openssh
    unzip
    tar
    gzip
    bash-completion
    htop
    tmux
    net-tools
    inetutils
    coreutils
    findutils
    less
    tree
    rsync
    screen
    zsh
    fish
    jq
    lynx
    bc
    gdb
    strace
    tcpdump
    iproute2
    netcat
    openssl
    socat
    cmake
    autoconf
    automake
    pkg-config
    perl
    ruby
    nodejs
    npm
)

for pkg in "${packages[@]}"; do
    echo "[*] installing package: $pkg"
    crew install "$pkg" || echo "[!] failed to install $pkg, continuing"
done

echo "[*] running dev_install as root..."

sudo bash -c '
echo "[*] running dev_install"
dev_install
echo "[*] dev_install finished"
'

echo "[*] done. restart your shell or run \"source ~/.bashrc\""
