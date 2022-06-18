#!/bin/bash

#things to do to redeploy
#1)kill all existing tmux sessions, to ensure site is down
tmux kill-server

#2) cd into project folder
cd /root/github-repositories/portfolio-website

#3)this command makes sure local repo has latest changes from main branch
#  on github.
git fetch && git reset origin/main --hard

#4)enter virtual environment and install dependencies
source ./venv/bin/activate
pip3 install -r requirements.txt

#5)start new detached tmux session and start flask server in virtual env
SESSION="site-autodeploy"
WINDOW=0                   #new sessions always have a 0 window
tmux new -d -s $SESSION #create new detached session, -d, & name it

#run command in the tmux window
#sends the key clicks and 'presses' enter
tmux send-keys -t $SESSION:$WINDOW 'export FLASK_ENV=development' Enter
tmux send-keys -t $SESSION:$WINDOW 'flask run --host=0.0.0.0' Enter
exit 0
