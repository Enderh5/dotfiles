#!/usr/bin/env bash
# %A: archivo local ($1), %B: archivo remoto ($2)
LOCAL_FILE="$1"
REMOTE_FILE="$2"

# Si la versión remota es más reciente que la local, sobreescribe la local
if [ "$REMOTE_FILE" -nt "$LOCAL_FILE" ]; then
    cp "$REMOTE_FILE" "$LOCAL_FILE"
fi
exit 0
