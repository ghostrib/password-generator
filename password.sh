#!/usr/local/bin/bash

bold() { 
  local bold=$(tput bold);
  local reset=$(tput sgr0);
  printf "${bold}%s${reset}\n" "$@" 
}

usage() {
  name="$(basename ${BASH_SOURCE[0]})"
  cat << EOF
usage:  $(bold $name) [$(bold length)][$(bold -c)|$(bold -copy)][$(bold -a)|$(bold -alnum)]|[$(bold -h)|$(bold -help)]
arguments:	
  length		A number to determine password length. If left blank a random length will be assigned
  -c | -copy	Copy the password to the clipboard (will not display on screen)
  -a | -alnum	Restrict password characters to alphanumeric
  -h | -help	Display this help message
Example:
  $name 36 -c
      will create a random string of 36 characters and copy it to the clipboard
  $name 42
      will create a random string of 42 characters and display it on the screen
  $name
      will create a random string of random length and display it on the screen
  $name -c
      will create a random string of random length and copy it to the clipboard
  $name -a -c 27
      will create a random string of 27 alphanumeric characters and copy it to the clipboard
  
  The order of arguments does not affect the outcome. 
  $(bold "$name 12 -c -a") is the same as $(bold "$name -c 12 -a") 
  
EOF
exit
}

chars=( {a..z} {A..Z} {0..9} \! \" \# \$  \% \& \( \) \* \+ \, \- \. \/ \: \; \< \= \> \? \@ \[ \] \^ \_ \` \{ \| \} \~ \\ )

generatePassword() {	
  local c=$1 password=
  while ((c--)); do
    password+=${chars[$((RANDOM%${#chars[@]}))]}
  done
  printf '%s\n' "$password"
}

randomNumber() {
  python -S -c "import random; print(random.randrange(12,64))"
}

declare copy=
declare length=

while [ "$1" ]; do
  case "$1" in
  
    -a|-alnum|--alnum)
      chars=( {a..z} {A..Z} {0..9} )
      ;;
      
    -h|-help|--help)			
      usage
      ;;

    -c|-copy|--copy)
      copy=1
      ;;

    *)
      [[ "$1" =~ ^[0-9]+$ ]] || usage
      length="$1"
      ;;
  esac
  shift
done

[ "$length" ] || length=$(randomNumber)

if [ "$copy" ]; then
  generatePassword "$length" | tr -d '\n' | pbcopy
  bold "Password copied to clipboard"
else
  generatePassword "$length"
fi
