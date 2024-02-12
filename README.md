# dotfiles

- 把想要管理的 dotfiles move here and use git to manage
- create a soft link to its needed directory
- ex:
```shell
ln -s /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/.zshrc ~/.zshrc
```

例子：
```shell
# step1: copy 現在的 config 檔案到要裡面的 dir 中
cp ~/.config/pet/snippet.toml /Users/re4388/project/personal/my-github-pjt/dotfiles/pet

# step2: 砍掉 config 檔案
rm ~/.config/pet/snippet.toml

# step3: 建立軟連接 
ln -s <這個repo的想要管理的path> <config檔案應該放的地方>  (ln -s real_filegit link_file)
ln -s /Users/re4388/project/personal/my-github-pjt/dotfiles/pet/snippet.toml ~/.config/pet/snippet.toml

```


