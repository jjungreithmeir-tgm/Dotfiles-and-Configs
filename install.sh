#!/bin/bash
# Calls all scripts and sets up necessary symlinks to this repository
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -sf $REPO/.Xmodmap ~/.Xmodmap
./maxima_tempfiles.sh
ln -sf $REPO/.aliases ~/.aliases
# Only adds line if it is not to be found in the zshrc
grep -q -F "source \$(readlink ~/.aliases)" ~/.zshrc || echo "source \$(readlink ~/.aliases)" >> ~/.zshrc
./infinality.sh
