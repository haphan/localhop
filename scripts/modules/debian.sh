#!/usr/bin/env bash

function b.debian.clean_packages() {
    return 0;
}

function b.debian.repo_add_src() {
    local repo=${1}
    local source="/etc/apt/sources.list"
    echo ${repo} >> ${source}
    return 0;
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
}