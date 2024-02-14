# 3 way to define functions

# function foo1() {
#     echo "foo1"
# }

# foo2() {echo "foo2"}


# (){echo foo2}

#######################################

# function to-lower() {
#     # converts the value of the first positional parameter ($1) to lowercase.
#     # $1 is the value of the first positional parameter.
#     # l means covert to lowercase.
#     echo ${1:l}
# }
# var=$(to-lower FOO)

# use `echo $var` to see the value of the variable.


#######################################
# echo 'do-ls() { emulate -L zsh; \ls; }' > do-ls

# source ./do-ls

# whence -f do-ls
# do-ls () {
#     emulate -L zsh
#     \ls
# }

###################

# use  whence -f to print the function content
# use  whence -v to get the function path


##################################



# Show website certificate from hostname
# usage: 
function curl-cert() {
    echo "usage: curl-cert <hostname>, example: curl-cert github.com"

    if [ "$#" -ne 1 ]; then
        echo "usage: curl-cert <hostname>, example: curl-cert github.com"
        return
    fi


  openssl s_client -showcerts -connect "${1}":443 -servername ${1}
}

# function  mans(){
#     man -k . \
#     | fzf -n1,2 --preview "echo {} \
#     | cut -d' ' -f1 \
#     | sed 's# (#.#' \
#     | sed 's#)##' \
#     | xargs -I% man %" --bind "enter:execute: \
#       (echo {} \
#       | cut -d' ' -f1 \
#       | sed 's# (#.#' \
#       | sed 's#)##' \
#       | xargs -I% man % \
#       | less -R)"
# }

function fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
  | fzf --ansi --preview "echo {} \
    | grep -o '[a-f0-9]\{7\}' \
    | head -1 \
    | xargs -I % sh -c 'git show --color=always %'" \
        --bind "enter:execute:
            (grep -o '[a-f0-9]\{7\}' \
                | head -1 \
                | xargs -I % sh -c 'git show --color=always % \
                | less -R') << 'FZF-EOF'
            {}
FZF-EOF"
}
