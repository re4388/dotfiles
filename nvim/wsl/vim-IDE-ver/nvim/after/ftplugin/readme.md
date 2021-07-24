
The ~/.vim/after/ directory is a bit of a hack. 
Files in this directory will be loaded every time Vim starts, but after the files in ~/.vim/plugin/.
This allows you to override Vim's internal files.
In practice you'll rarely need this, so don't worry about it until you find yourself thinking
Vim itself sets option x, but I want something different".
