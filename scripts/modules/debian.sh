#!/usr/bin/env bash

function b.debian.clean_packages() {
    return 0;
}

function b.debian.repo_add_src() {
    local repo=${1}
    local id=${2}
    local source_dir="/etc/apt/sources.list.d/"
    local source="/etc/apt/sources.list"

    if [[ -z "$id" ]];
    then
        #no repo name supplied, append to primary source list
        echo ${repo} >> ${source}
    else
        #append to a separate repo file in source.list.d
        echo ${repo} >> "${source_dir}/${id}"
    fi

    return 0;
}

#Remove a repo file in source.list.d
function b.debian.repo_remove() {
    local repo=${1}
    local source_dir="/etc/apt/sources.list.d/"
    rm -f "${source_dir}/${repo}"
}

#If pass a repo id, then empty the file in source.list.d, otherwise empty primary repo file
function b.debian.repo_empty() {
    local id=${1}
    local source_dir="/etc/apt/sources.list.d/"
    local source="/etc/apt/sources.list"

    if [[ -z "${id}" ]];
    then
        #no repo name supplied, empty primary source list /etc/apt/source.list
        > "${source}"
    else
        #otherwise empty repo file in /etc/apt/source.list.d/
        > "${source_dir}/${id}"
    fi
}

function b.debian.repo_add_gpg() {
    local gpg=${1}
    wget -q -O - ${gpg} | apt-key add - > /dev/null
}

function b.debian.add_repo (){
    local repo=${1}
    local key=${2}
    b.debian.repo_add_gpg "${key}";
    b.debian.repo_add_src "${repo}";
}

function b.debian.repo_clean(){
    > /etc/apt/sources.list
}

function b.debian.repo_update() {
    return 0
}

function b.debian.locale_select() {
    echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
    apt-get install locales -y
    locale-gen > /dev/null

    printf "LANGUAGE=en_US:en\nLANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8\nLC_CTYPE=UTF-8" > /etc/default/locale
    printf "LANGUAGE=en_US:en\nLANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8\nLC_CTYPE=UTF-8" > /etc/environment

    export LANGUAGE=en_US:en
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export LC_CTYPE=UTF-8
}

function b.debian.config_profile() {
    local dir="`pwd`/resources"
    declare -a local files=('.bashrc .profile')
    for i in ${files[@]}
	do
	   cat "${dir}/${i}" > "/etc/skel/${i}"
	   cat "${dir}/${i}" > "/root/${i}"
	done
	source ~/.profile
}