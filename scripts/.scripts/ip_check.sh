#!/bin/bash
# Check if IPv6 changed since last boot

IFACE="enp5s0"
STATEFILEDIR="$HOME/.local/state/"
STATEFILE="$HOME/.local/state/last_ipv6_state"

if [ ! -d "$STATEFILEDIR" ]; then
    mkdir -p "$STATEFILEDIR"
fi

CURR_ADDR=$(ip -6 addr show dev "$IFACE" \
    | awk '/inet6 [2-3]/ && !/temporary/ {print $2; exit}')

if [ -z "$CURR_ADDR" ]; then
    notify-send "[WARN]" "No global IPv6 address found on $IFACE."
    exit 0
fi

# Detect change
if [ -f "$STATEFILE" ]; then
    LAST_ADDR=$(cat "$STATEFILE")
    if [ "$CURR_ADDR" != "$LAST_ADDR" ]; then
        notify-send "IPv6 changed" "New: $CURR_ADDR (was $LAST_ADDR)"
    fi
else
    notify-send "IPv6 detected" "Address: $CURR_ADDR"
fi

echo "$CURR_ADDR" > "$STATEFILE"
