#!/bin/bash

function usage() {
    printf "Usage: $0 OPTION...
    -f          fill pg 종료
    -p          postgres 종료
    \\n" "$0" 1>&2
    exit 1
}

[ $# -eq 0 ] && usage

while getopts "fp" opt; do
    case $opt in
    p)
        docker-compose -f docker-compose-postgres.yaml down
        ;;
    f)  
        docker-compose down
        ;;
    ?)
        echo "Invalid Option!" 1>&2
        usage
        ;;
    :)
        echo "Invalid Option: -${OPTARG} requires an argument." 1>&2
        usage
        ;;
    *)
        usage
        ;;
    esac
done