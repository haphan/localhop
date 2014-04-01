#!/usr/bin/env bash

function b.localhop.init_repo() {
    #clean repo
    b.debian.repo_clean

    #importing key
    b.debian.repo_add_gpg "http://repo.varnish-cache.org/debian/GPG-key.txt"
    b.debian.repo_add_gpg "http://www.dotdeb.org/dotdeb.gpg"

    #importing repo source
    b.debian.repo_add_src "deb http://http.debian.net/debian wheezy main"
    b.debian.repo_add_src "deb http://security.debian.org/ wheezy/updates main"
    b.debian.repo_add_src "deb http://repo.varnish-cache.org/debian/ wheezy varnish-3.0"
    b.debian.repo_add_src "deb http://packages.dotdeb.org wheezy all"
    b.debian.repo_add_src "deb http://packages.dotdeb.org wheezy-php55 all"

    apt-get update
}

function b.localhop.install_packages() {
    declare -a local PKGS=('varnish nginx php5-fpm php5-cli build-essential git-core');
    apt-get install -y `(IFS=' '; echo "${PKGS[*]}")`
}

function b.localhop.run() {
    #setup standard locale for debian
    b.debian.locale_select
    #check prerequisites
    b.requirement.check

    b.localhop.init_repo
    b.localhop.install_packages
}