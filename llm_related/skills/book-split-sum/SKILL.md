---
name: book-split-sum
description: sumerize book by split into many summary md file 
---

I will give you the book md file path



markitdownif the book format I provide to you is not .md format
use below command to covert it first
`markitdown xxx.pdf -o myfile.m`
`markitdown xxx.epb -o myfile.m`


for all folder and file are saved into this path:
/Users/re4388/project/personal/learnByStory/markitdown


step1: folder creation
- create a new folder, folder name is <bookName>_dir.
- create a second new folder in this <bookName>_dir, name it <bookName>_summary.

step2: md file split
- split this provied md file into many .md file, split by chapter
- name .md file name with the chapter name
- put those .md files into <bookName>_dir folder

step2:
- for each chapter md file, check it and create "details summary" for each file and put those summary results into each <chapter_name>-summary file and all of these files put into <bookName>_summary folder (the summary text shall be zh-tw lang)
(spawn many subagent to do this summary work, since this kind of work can be run in parrellel)