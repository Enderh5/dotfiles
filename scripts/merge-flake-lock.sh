#!/usr/bin/env bash

# Parámetros pasados por Git (%A = Local, %B = Remoto)
LOCAL_FILE="$1"
REMOTE_FILE="$2"

# Verificar que ambos archivos existan
if [ ! -f "$LOCAL_FILE" ] || [ ! -f "$REMOTE_FILE" ]; then
    exit 1
fi

# Comparar las fechas de modificación de ambos archivos
if [ "$REMOTE_FILE" -nt "$LOCAL_FILE" ]; then
    cp "$REMOTE_FILE" "$LOCAL_FILE"
fi

exit 0
