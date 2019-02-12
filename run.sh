#!/bin/sh
service ssh start;
vim +PluginInstall +qall;

while true; do :; sleep 3600; done