#!/bin/bash
set -e

VERSION="v1.10.2"

apt-get update
apt-get install -y curl unzip gnupg lsb-release

ARCH=$(uname -m)
case "$ARCH" in
x86_64) ARCH="amd64" ;;
aarch64 | arm64) ARCH="arm64" ;;
*)
	echo "Unsupported architecture: $ARCH"
	exit 1
	;;
esac

TMPDIR=$(mktemp -d)
curl -sSL "https://github.com/grafana/alloy/releases/download/${VERSION}/alloy-linux-${ARCH}.zip" -o "${TMPDIR}/alloy.zip"
unzip "$TMPDIR/alloy.zip" -d "$TMPDIR"
mv "$TMPDIR"/alloy-linux-"$ARCH" /usr/local/bin/alloy
chmod +x /usr/local/bin/alloy
rm -rf "$TMPDIR"
