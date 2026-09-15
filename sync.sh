#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$REPO_DIR/home"
LIST="$REPO_DIR/files.list"

mkdir -p "$DEST"

while IFS= read -r path; do
    # skip blank lines and comments
    [[ -z "$path" || "$path" == \#* ]] && continue

    src="$HOME/$path"
    if [[ -e "$src" ]]; then
        rsync -aR --mkpath "$HOME/./$path" "$DEST/"
        echo "synced: $path"
    else
        echo "skipped (not found): $path"
    fi
done < "$LIST"

echo "Done. Review changes with: git -C \"$REPO_DIR\" status"
