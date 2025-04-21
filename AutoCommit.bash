#!/bin/zsh

while true; do
  echo "Adding Files...."
  git add *
  echo "Commiting Files....."
  git commmt -m "ui changges && backend changes"
  echo "Pushing changes to github..."
  git push -u origin main

  sleep 600
done
