#!/bin/bash
# to make execurable
# chmod +x install_nodejs.sh 

# https://github.com/jdx/mise

echo "- Install Nodejs@22, npm and pnpm --------------------------------------------------"
mise use node@22 -g
mise use npm@latest -g
mise use pnpm@latest -g

echo "- Install NPM packages --------------------------------------------------"
npm i -g @ast-grep/cli npm-check-updates 
