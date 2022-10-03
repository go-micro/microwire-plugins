#!/bin/bash

function go_mods() {
    local OLD_SHA=$(git rev-list -n 1 ${1})
    local NEW_SHA=$(git rev-list -n 1 ${2})

    local cfiles=$(git diff --name-only ${OLD_SHA} ${NEW_SHA})
    for f in ${cfiles}; do
        if [[ -f "$(dirname ${f})/go.mod" ]]; then
            echo "$(dirname ${f})"
        fi
        if [[ -f "$(dirname ${f}/../go.mod)" ]]; then
            echo $(dirname ${f}/../)
        fi
    done
}

function main() {
    local gmods=$(go_mods $1 $2 | sort -u)

    for g in ${gmods[@]}; do
        echo "${g}"
    done
}

main $1 $2