bashrc() {
  BASHRC="$HOME/.bashrc"
  cp ~/.bashrc ~/.bashrc.bkp

  if ! grep -q "umask" $BASHRC; then
    cat <<EOF >>"$BASHRC"

# defaulting directories to 755 (777-22) and files to 644 (666-22)
umask 022
EOF
  fi

  if ! grep -q "coffeebean" $BASHRC; then
    cat <<EOF >>"$BASHRC"

# coffeebean config
export SERVER_ID="server1"
export ENV="development"
export PORT="8080"
EOF
  fi
}

bashrc
