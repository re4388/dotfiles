@REM change code page so UTF-8 characters work
chcp 65001

@REM pass six QUTE_ variables to the bash script
wsl.exe /home/re4388/projects/dotfiles/bash_projects/notion_api/send_to_wait_to_sort.sh "%QUTE_URL%" "%QUTE_TITLE%"