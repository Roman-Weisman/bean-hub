bashrc() {
  BASHRC="$HOME/.bashrc"

  if ! grep -q "umask" $BASHRC; then
    cp ~/.bashrc ~/.bashrc.bkp
    echo "" >>$BASHRC
    echo "# defaulting directories to 755 (777-22) and files to 644 (666-22)" >>$BASHRC
    echo "umask 022" >>$BASHRC
  fi
}

bashrc
