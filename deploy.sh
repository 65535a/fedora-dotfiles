#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/home"

while IFS= read -r path; do
    [[ -z "$path" || "$path" == \#* ]] && continue

    from="$SRC/$path"
    to="$HOME/$path"
    if [[ -e "$from" ]]; then
        mkdir -p "$(dirname "$to")"
        cp -a "$from" "$to"
        echo "deployed: $path"
    else
        echo "skipped (not in repo): $path"
    fi
done < "$REPO_DIR/files.list"

echo "Done. You may need: swaymsg reload"
