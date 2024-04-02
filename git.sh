#!/bin/bash

git config user.name "Mohamed Ali CHARRAD"
git config user.email "charradmedali@gmail.com"
eval "$(ssh-agent -s)"
ssh-add /home/omegup/.ssh/id_rsa
git add .
git commit -m "Commit message"
git push

