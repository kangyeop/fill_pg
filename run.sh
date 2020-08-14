#!/bin/bash

function usage() {
    printf "Usage: $0 OPTION...
    -d          fill pg 종료
    -i          초기 시작(테이블 스키마 생성)
    -I          테이블 전부 삭제 후 재시작(테이블 스키마 삭제 후 재생성)
    -s          block number, block number까지 스킵하고 fill-pg 실행
    \\n" "$0" 1>&2
    exit 1
}

[ $# -eq 0 ] && usage

# export UID=$(id -u)
SUB_COMMAND=""

while getopts "piIs:" opt; do
    case $opt in
    p)
        docker-compose -f docker-compose-postgres.yaml up -d
        ;;
    i)  
        SUB_COMMAND+=" --fpg-create"
        ;;
    I)  
        SUB_COMMAND+=" --fpg-drop --fpg-create"
        ;;
    s)
        if (( $OPTARG <= 0 )); then
            echo "block num is must be postive"
            exit 1
        fi
        SUB_COMMAND+=" --fill-skip-to $OPTARG"
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
export SUB_COMMAND
docker-compose up -d