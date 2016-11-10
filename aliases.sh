function beck() {
    ( cd ~/BeckHomestead && vagrant $* )
}

function beck-run() {
    PROJECTPATH=${$(pwd)##*Projects/Beck/development/}
    echo $(beck ssh -- -t "cd projects/$PROJECTPATH && $*")
}

function beck-ssh() {
    PROJECTPATH=${$(pwd)##*Projects/Beck/development/}
    ssh -p 2222 vagrant@localhost -t "cd projects/$PROJECTPATH ; /bin/bash"
}

alias br='beck-run'
alias bssh='beck-ssh'
