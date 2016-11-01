function beck() {
    ( cd ~/BeckHomestead && vagrant $* )
}

function beck-run() {
    PROJECTPATH=${$(pwd)##*Development/}
    echo $(beck ssh -- -t "cd projects/$PROJECTPATH && $*")
}

alias br='beck-run'
