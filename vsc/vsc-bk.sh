#!/bin/bash
powershell.exe -File "C:\Users\re438\AppData\scripts\get-vsce-ext-list.ps1" > win-vsc-ext.txt
cp /mnt/c/Users/re438/AppData/Roaming/Code/User/settings.json ./
cp /mnt/c/Users/re438/AppData/Roaming/Code/User/keybindings.json ./
