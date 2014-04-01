#!/usr/bin/env bash

function b.requirement._require_root() {
    if [ `whoami` != 'root' ]
    then
        b.raise InsufficientPrivilegeException "This script must run by root."
    fi
}

function b.requirement._require_binaries() {
    declare -a local BINARIES=('apt-get wget apt-key whoami')
    for i in ${BINARIES[@]}
	do
	   command -v ${i} >/dev/null 2>&1 || { b.raise DependencyNotMetException "${i} is not installed." >&2; exit 1; }
	done
}


function b.requirement.check() {
    b.requirement._require_binaries
    b.requirement._require_root
}