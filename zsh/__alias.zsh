
alias vi=nvim
alias vim=lvim

alias ps=procs

###################### mdcat - pretty markdown in terminal
## 有點慢，可能比較適合作為一些需要漂亮展示的 markdown顯示
alias mdcat=/Users/re4388/project/personal/mdcat-2.1.1-x86_64-apple-darwin/mdcat



alias kc=kubectl
alias minik=minikube
alias kctx=kubectx


# IDEA open, like `code` for vscode
alias idea='open -na "IntelliJ IDEA.app" --args'
alias goland='open -na "GoLand.app" --args'
alias du='gdu-go'

alias fdf="fd | fzf"



alias ls="eza"
alias ll="eza -al"


alias qq='ben'

alias j="z"


alias dif="difft"

################ global alias #################################
# doc
# https://github.com/rothgar/mastering-zsh/blob/master/docs/helpers/aliases.md#global-aliases

alias -g F='| fzf | pbcopy'
alias -g C='| pbcopy'
alias -g L='| llm -m ph "explain this code"'

# usage: echo "https://www.nytimes.com" TO
alias -g TO='| xargs curl -s | strip-tags -m | ttok'


################ global alias #################################











# use`space` to exand your aliases
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space