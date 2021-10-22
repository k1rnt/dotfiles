#!/usr/bin/env bash

set -eu

#workdir
cd $HOME

#homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'homebrew install success'

