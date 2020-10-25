#!/bin/bash

cp ~/.iTerm2-Workspace/SaveTabs.json ~/Library/Application\ Support/iTerm2/DynamicProfiles

if [[ $? == 0 ]]
then
    echo "Install successfully".
fi