#!/bin/bash
#
# Run a development container which we can attach to in order
# to develop remotely
#

USAGE="d_dev.sh [machine name]"

SRC_DIRECTORY="/src"
USERUID=$(id -u $USER)
USERGID=$(id -g $USER)

DOCKER_COMMAND="docker run -it \
                --rm \
                -w $SRC_DIRECTORY
                -u $USERUID:$USERGID \
                --mount type=bind,src="$(pwd)",target="$SRC_DIRECTORY

#if [[ -e ~/.config/nvim/init.vim || -e ~/.config/nvim/init.lua  ]]; then
#    echo "[+] Found neovim config, mounting..."
 #   DOCKER_COMMAND=$DOCKER_COMMAND" --mount type=bind,src=/home/"$USER"/.config/nvim/,target=/home/dev/.config/nvim/"
#elif [[ -z ~/.config/vim ]]; then
#    echo "[+] Found vim config, mounting..."
#    DOCKER_COMMAND=$DOCKER_COMMAND" --mount type=bind,src=/home/"$USER"/.config/vim/,target=/home/dev/.config/vim/"
#fi

# if [[ -e ~/.tmux.conf ]]; then 
#     echo "[+] Found Tmux config, mounting..."
#     DOCKER_COMMAND=$DOCKER_COMMAND" --mount type=bind,src=/home/"$USER"/.

echo "[+] Starting session..."

DOCKER_COMMAND=$DOCKER_COMMAND" "$1

echo "[i] Running command "$DOCKER_COMMAND

$DOCKER_COMMAND
