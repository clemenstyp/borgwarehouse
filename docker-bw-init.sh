#!/bin/bash

set -e

SSH_DIR="/home/borgwarehouse/.ssh"
AUTHORIZED_KEYS_FILE="$SSH_DIR/authorized_keys"
REPOS_DIR="/home/borgwarehouse/repos"

init_ssh_server() {
  if [ -z "$(ls -A /etc/ssh)" ]; then
    echo "/etc/ssh is empty, generating SSH host keys..."
    ssh-keygen -A
    cp /home/borgwarehouse/sshd_config /home/borgwarehouse/moduli /etc/ssh/
  fi
}

create_ssh_directory() {
  if [ ! -d "$SSH_DIR" ]; then
    echo "The .ssh directory does not exist, creating..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
  fi
}

create_authorized_keys_file() {
  if [ ! -f "$AUTHORIZED_KEYS_FILE" ]; then
    echo "The authorized_keys file does not exist, creating..."
    touch "$AUTHORIZED_KEYS_FILE"
    chmod 600 "$AUTHORIZED_KEYS_FILE"
  fi
}

create_repos_directory() {
  if [ ! -d "$REPOS_DIR" ]; then
    echo "The repos directory does not exist, creating..."
    mkdir -p "$REPOS_DIR"
  fi
}

init_ssh_server
create_ssh_directory
create_authorized_keys_file
create_repos_directory

exec "$@"