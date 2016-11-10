function beck() {
    ( cd ~/BeckHomestead && vagrant $* )
}

function beck-run() {
    PROJECTPATH=${$(pwd)##*Projects/Beck/development/}
    echo $(beck ssh -- -t "cd projects/$PROJECTPATH && $*")
}

alias br='beck-run'
