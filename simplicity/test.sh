#!/bin/sh

function assert() {
    if [[ "$1" != "$2" ]]; then
        echo "Assertion error: expected value $2, actual value $1";
        exit
    fi
}

echo "Initiating database tests..."

DB_CMD="$PWD/db.sh"

${DB_CMD} set 1 foo
assert "$(${DB_CMD} get 1)" "foo"
${DB_CMD} set 2 bar
${DB_CMD} set 1 baz
assert "$(${DB_CMD} get 2)" "bar"
assert "$(${DB_CMD} get 1)" "baz"
${DB_CMD} set 5 buzz
${DB_CMD} set 10 fizz
assert "$(${DB_CMD} get 10)" "fizz"

echo "Tests successfully completed"