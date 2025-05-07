#!/bin/sh

# Check CPU architecture
ARCH=$(uname -m)

echo -e "${INFO} Check CPU architecture ..."
if [[ ${ARCH} == "x86_64" ]]; then
    ARCH="amd64"
elif [[ ${ARCH} == "aarch64" ]]; then
    ARCH="arm64"
else
    echo -e "${ERROR} This architecture is not supported."
    exit 1
fi


WGCF_URL=$(curl -fsSL https://api.github.com/repos/ViRb3/wgcf/releases/latest | grep 'browser_download_url' | cut -d'"' -f4 | grep "_linux_${ARCH}")
curl -fsSL "${WGCF_URL}" -o ./wgcf
chmod +x ./wgcf

WIREPROXY_URL=$(curl -fsSL https://api.github.com/repos/whyvl/wireproxy/releases/latest | grep 'browser_download_url' | cut -d'"' -f4 | grep "wireproxy_linux_${ARCH}.tar.gz")
curl -fsSL "${WIREPROXY_URL}" -o ./wireproxy.tar.gz
tar -xzf wireproxy.tar.gz
rm wireproxy.tar.gz
chmod +x ./wireproxy

