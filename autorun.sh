#!/usr/bin/env bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run compton
run redshift                    # auto adjust screen temperature for night work
run setxkbmap -layout "pl" 			# keyboard layout
