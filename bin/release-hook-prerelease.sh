#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if test -f "$SCRIPTPATH"/replacements; then
  while read -ra __; do
    go mod edit -dropreplace ${__[0]}
  done < "$SCRIPTPATH"/replacements
fi

hugo mod get -u ./...
hugo mod tidy

git add go.mod --force
git add go.sum --force

#rm -rf public
#hugo
#git add public/ -f

if test -f "$SCRIPTPATH"/replacements; then
  while read -ra __; do
    go mod edit -replace ${__[0]}=${__[1]}
  done < "$SCRIPTPATH"/replacements
fi
