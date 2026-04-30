#!/bin/bash
# Clone Prezto if not already present
if [ ! -d "$HOME/.zprezto" ]; then
  echo "Cloning Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi
