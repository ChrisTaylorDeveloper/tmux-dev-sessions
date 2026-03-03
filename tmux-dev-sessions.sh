#!/usr/bin/env bash

# $1 the command to run
# $2 clear again, after cmd is run
run_cmd() {
  tmux send-keys "clear" C-m
  tmux send-keys "$1" C-m
  if [ -n "$2" ]; then
    tmux send-keys "clear" C-m
  fi
}

# $1 the command to insert
place_cmd() {
  tmux send-keys "clear" C-m
  tmux send-keys "$1  # Hit Enter"
}

# $1 session name
# $2 window number
# $3 window title
# $4 directory
win_git() {
  tmux new-window -t "$1":"$2" -n "$3 Git"
  run_cmd "cd $4"
  run_cmd gitgraph
  tmux splitw -h
  run_cmd "cd $4"
  run_cmd "git status"
}

# $1 session name
# $2 window number
# $3 window title
# $4 directory
# $5 opening files list
win_nvim() {
  tmux new-window -t "$1":"$2" -n "$3 Nvim"
  run_cmd "cd $4"
  if [ -z "$5" ]; then
    place_cmd "nvim"
  else
    place_cmd "nvim $5"
  fi
}

# $1 session name
# $2 window number
# $3 window title
# $4 directory
win_git_graph() {
  tmux new-window -t "$1":"$2" -n "$3 Graph"
  run_cmd "cd $4"
  place_cmd 'gitgraph'
}

# $1 session name
# $2 window number
# $3 window title
# $4 directory
win_git_status() {
  tmux new-window -t "$1":"$2" -n "$3 Git"
  run_cmd "cd $4"
  run_cmd 'git status'
}

# $1 session name
# $2 window number
# $3 window title
# $4 directory
win_bash_deprecated() {
  tmux new-window -t "$1":"$2" -n "$3 Bash"
  run_cmd "cd $4" "clear"
}

# $1 session name
# $2 window number
# $3 directory
# $4 window title
win_bash() {
  tmux new-window -t "$1":"$2" -n "$4"
  run_cmd "cd $3" "clear"
}

win_hosts_file() {
  tmux new-window -t "$1":"$2" -n "/etc/hosts"
  run_cmd "cd /etc/"
  place_cmd 'sudo vim -c "set number" hosts'
}
