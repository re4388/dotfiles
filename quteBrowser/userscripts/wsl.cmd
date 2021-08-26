@REM change code page so UTF-8 characters work
chcp 65001

@REM pass six QUTE_ variables to the bash script
wsl.exe /home/re4388/projects/script/qb.sh "%QUTE_URL%" "%QUTE_TITLE%" "%QUTE_SELECTED_TEXT%" "%QUTE_COMMANDLINE_TEXT%" "%QUTE_HTML%" "%QUTE_TEXT%"