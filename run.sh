#!/bin/bash

function usage() {
    printf "Usage: $0 OPTION...
    -i          postgres와 함께 시작
    -c          존재하는 postgres에 연결
    \\n" "$0" 1>&2
    exit 1
}

[ $# -eq 0 ] && usage

export UID=$(id -u)

while getopts "ic" opt; do
    case $opt in
    i)
        docker-compose -f docker-compose-with-postgres.yaml up -d
        ;;
    c)
        docker-compose up -d
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
