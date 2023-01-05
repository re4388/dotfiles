const fs = require('fs');
const path = require('path');

const originFile = '/Users/re4388/project/personal/experiment/node-12-22-0-commonJS/src/cron-job/back.ts'
const destFile = '/Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/back2.ts'

// copy async
fs.copyFile(originFile, destFile, (err: Error) => {
    if (err) {
        console.error(err);
        return;
    }

    const from = path.basename(originFile);
    const to = path.basename(destFile);

    console.log(`File copied successfully! ${from} -> ${to}`);
});



// ts-node ./cron-job/back.ts