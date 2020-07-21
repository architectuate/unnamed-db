#!/bin/sh

function usage() {
    echo "usage: $0 [command] [key] [value]"
    echo ""
    echo "command       Only commands 'get' and 'set' are supported."
    echo "key           Any value, acts as the primary index for your data. Required for get and set commands."
    echo "value         Any value, acts as the data itself. Required for set command."
    exit
}

DB_FILE="db.txt"
function set_value() {
    KEY="$1"
    VALUE="$2"
    if [[ -z "$KEY" || -z "$VALUE" ]]; then usage; fi
    echo "$1,$2" >> "$DB_FILE"
}

function get_value() {
    KEY="$1"
    if [[ -z "$KEY" ]]; then usage; fi
    grep "$1," "$DB_FILE" | sed "s/$1,//g" | tail -n 1
}

COMMAND="$1"
case "$COMMAND" in
    ("set") set_value "$2" "$3" ;;
    ("get") get_value "$2" ;;
    (*) usage ;;
esac