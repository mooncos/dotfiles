#!/bin/bash
# Clone Prezto if not already present (check for init.zsh as the real indicator)
if [ ! -f "$HOME/.zprezto/init.zsh" ]; then
  echo "Cloning Prezto..."
  rm -rf "$HOME/.zprezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi
