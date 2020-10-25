#!/bin/bash

cp ./SaveTabs.json ~/Library/Application\ Support/iTerm2/DynamicProfiles

if [[ $? == 0 ]]
then
    echo "Install successfully".
fi