#!/usr/bin/env bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run 'setxkbmap -layout "pl"'
run 'setxkbmap -option caps:swapescape'
run redshift                    # auto adjust screen temperature for night work
