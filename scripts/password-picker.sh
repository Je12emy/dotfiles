#!/bin/bash

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | tofi "$@")

[[ -n $password ]] || exit

pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | wl-copy
notify-send "Password has been copied to clipboard."
