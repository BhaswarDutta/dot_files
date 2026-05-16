#!/bin/bash

set -e


EXTENSION_FILE="extension_list.txt"

clear

echo "=================================="
echo "   VSCode Extension Installer"
echo "=================================="
echo
echo "Choose installation target:"
echo
echo "  1) Both (default)"
echo "  2) VS Code"
echo "  3) VSCodium"
echo

read -rp "Selection [1-3]: " choice

choice=${choice:-1}

install_extensions() {
    local editor=$1

    if ! command -v "$editor" >/dev/null 2>&1; then
        echo
        echo "[!] $editor is not installed."
        return
    fi

    echo
    echo "Installing extensions for: $editor"
    echo "----------------------------------"

    while IFS= read -r extension; do
        [ -z "$extension" ] && continue

        echo "→ $extension"
        "$editor" --install-extension "$extension"
    done < "$EXTENSION_FILE"

    echo
    echo "[✓] Finished installing for $editor"
}

case "$choice" in
    1)
        install_extensions code
        install_extensions codium
        ;;
    2)
        install_extensions code
        ;;
    3)
        install_extensions codium
        ;;
    *)
        echo
        echo "Invalid option."
        exit 1
        ;;
esac

echo
echo "Done."
