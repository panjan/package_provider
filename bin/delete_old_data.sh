#!/bin/sh

readonly DAYS=$1
readonly DIRECTORY=$2

is_empty() {
    local var=$1
    [ -z $var ]
}

is_directory() {
    local path=$1
    [ -d "$path" ]
}

show_help() {
    echo "Usage: <days>[1-*] <directory>"
}

main() {
    if is_empty $DAYS || is_empty $DIRECTORY; then
	echo "Mandatory parameter(s) not specified."
	show_help
	exit 1
    fi

    if [ $DAYS -lt 1 ]; then
	echo "The <days> parameter must be greater than 0."
	show_help
	exit 1
    fi

    if ! is_directory $DIRECTORY; then
	echo "The given path ${DIRECTORY} is not an existing directory."
	show_help
	exit 1
    fi
    
    echo "Cleaning directory: ${DIRECTORY}"
    find $DIRECTORY -depth -mindepth 1 -maxdepth 1 -mtime +$DAYS -exec rm -rfv '{}' \;
}
main
