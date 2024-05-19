
alias vi=nvim
alias vim=lvim

alias ps2=procs

###################### mdcat - pretty markdown in terminal
## 有點慢，可能比較適合作為一些需要漂亮展示的 markdown顯示
alias mdcat=/Users/re4388/project/personal/mdcat-2.1.1-x86_64-apple-darwin/mdcat



alias kc=kubectl
alias minik=minikube
alias kctx=kubectx


# IDEA open, like `code` for vscode
#alias idea='open -na "IntelliJ IDEA.app" --args'
alias goland='open -na "GoLand.app" --args'
alias du='gdu-go'

alias ls="eza"
#alias ll="eza -al"


# -a is to show all, include hidden file
# --hyperlink make it clickable
# -l means show all info
alias ll="eza --sort newest -a --hyperlink -l"


alias qq='ben'
alias j="z"

alias dif="difft"
alias his="atuin"


#alias b='buku'

################ global alias #################################
# doc
# https://github.com/rothgar/mastering-zsh/blob/master/docs/helpers/aliases.md#global-aliases

alias -g F='| fzf | pbcopy'
alias -g C='| pbcopy'
#alias -g E='| llm -m ph "explain this code"'
#alias -g S='| llm -m ph "help me summarize the this dif diff difference and show me the bullet points result"'

alias -g SUM="| llm -m gpt-4-turbo-preview 'Help me succinctly summarize this article with bullet point in traditional Chinese'"

#

alias ai=sgpt
alias traceroute2=nexttrace
alias traceroute3="trip --unprivileged"
#alias ai=llm


alias jq2="jnv"

alias ts="/Applications/Tailscale.app/Contents/MacOS/Tailscale"



# usage: echo "https://www.nytimes.com" TO
alias -g TO='| xargs curl -s | strip-tags -m | ttok'


################### use`space` to exand your aliases
################## 好處？ 你可以知道你實際上在用那個套件
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