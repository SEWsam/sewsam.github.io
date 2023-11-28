#!/bin/zsh
echo "Installing requirements"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
wait
brew install spoof-mac > /dev/null
wait
echo "Done... fixing wifi"
echo "You will need to enter your password. It will not appear in the terminal, but its still being typed."
sudo spoof-mac randomize en0
wait
echo "Done!"
