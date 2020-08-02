#!/bin/zsh

/usr/bin/guake &
sleep 5 # let main guake process start and initialize D-Bus session

guake --rename-tab="apps" --execute-command="cd /home/michael/ownera/omsys-poc/"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/common" --rename-current-tab="common" 

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/api" --rename-current-tab="api"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/ownera-api" --rename-current-tab="ownera-api"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/backend" --rename-current-tab="backend"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/investor-dashboard" --rename-current-tab="investor-dashboard"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/ownera-node-dashboard" --rename-current-tab="ownera-node-dashboard"

guake --new-tab --execute="/usr/bin/zsh"
guake --execute-command="cd /home/michael/ownera/omsys-poc/packages/issuer-dashboard" --rename-current-tab="issuer-dashboard"

