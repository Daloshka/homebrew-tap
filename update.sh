#!/bin/sh
# Point the Librium cask at a new release.
# Usage: ./update.sh 0.5.5
set -eu

version="${1:-}"
if [ -z "$version" ]; then
  echo "usage: $0 <version>   (for example: $0 0.5.5)" >&2
  exit 1
fi

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cask="$root/Casks/librium.rb"
[ -f "$cask" ] || { echo "cask not found: $cask" >&2; exit 1; }

url="https://github.com/Daloshka/Librium/releases/download/v${version}/Librium-${version}-arm64.dmg"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

echo "downloading $url"
curl -fL --retry 3 --progress-bar -o "$tmp/librium.dmg" "$url"
sha=$(shasum -a 256 "$tmp/librium.dmg" | awk '{print $1}')
echo "sha256 $sha"

sed -e "s|^  version \".*\"$|  version \"${version}\"|" \
    -e "s|^  sha256 \".*\"$|  sha256 \"${sha}\"|" \
    "$cask" >"$tmp/librium.rb"
mv "$tmp/librium.rb" "$cask"

grep -q "^  version \"${version}\"\$" "$cask" || { echo "version not updated in $cask" >&2; exit 1; }
grep -q "^  sha256 \"${sha}\"\$" "$cask" || { echo "sha256 not updated in $cask" >&2; exit 1; }
ruby -c "$cask" >/dev/null

echo
echo "$cask updated. Next:"
echo "  brew style --cask daloshka/tap/librium   # needs the tap installed"
echo "  git -C \"$root\" add Casks/librium.rb"
echo "  git -C \"$root\" commit -m 'librium $version'"
echo "  git -C \"$root\" push"
