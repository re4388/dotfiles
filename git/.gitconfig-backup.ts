[includeIf "gitdir:~/project/personal/"] 
	path = ~/project/personal/.gitconfig-personal
 
[includeIf "gitdir:~/project/work/"]
	path = ~/project/work/.gitconfig-work

[alias]
	cn    = commit --no-verify -m
	a     = !git add . && git reset -- ./.gitignore
	s     = status
	co    = checkout
	ec    = config --global -e
	wip   = !git add --all && git commit -m WIP
[user]
	name = ben.hu
	email = ben.hu@wemoscooter.com
[core]
	excludesfile = /Users/re4388/.gitignore_global
[difftool "sourcetree"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path = 
[mergetool "sourcetree"]
	cmd = /Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
[commit]
	template = /Users/re4388/.stCommitMsg
