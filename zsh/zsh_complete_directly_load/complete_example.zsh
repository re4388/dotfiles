

# 教學
# [zsh-completions/zsh-completions-howto.org at master · zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org)
# https://wikimatze.de/writing-zsh-completion-for-padrino/
# a lot of source code to see
# https://github.com/zsh-users/zsh-completions/tree/master/src


function _qq0 {
   local line
   _arguments -C \
       "-h[Show help information22]" \
       "--h[Show help information]" \
       "1: :(a1 a2)" \
       "*::arg:->args"

   case $line[1] in
       a1)
           _a1
       ;;
       a2)
           _a2
       ;;
   esac
}

function _a1() {
     _arguments '-s2[sort output111]'
}
function _a2() {
     _arguments '-s2[sort output]'
}

compdef _qq3 qq3

##################################################################
##################################################################
##################################################################

# _describe 語法, 最簡單的語法
# 無法指定 action
# 無法制定順序
function qq3() {
    echo 'qq3'
}
function _qq3() {
  # 如果有很多，可以分組
  local -a subcmds topics topics2
  subcmds=(
    'c:description for c command'
    'd:description for d command'
  )

  topics1=(
    'e:description1 for e help topic1'
    'f:description for f1 help topic'
  )

  topics2=(
    'e:description for q help topic'
    'f:description for g help topic'
  )
  _describe 'command' subcmds -- topics1 -- topics2
}
compdef _qq3 qq3


# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# 這種會 先跑，才會跑 qq1 那些
# N:MESSAGE:ACTION
#    N -> the Nth command arg
#    N is omitted -> just means the next command
#    :: -> the argument is optional.
function qq2() {
    echo 'qq2'
}
function _qq2() {
    _arguments \
    '1:first arg:_net_interfaces' \
    ':next arg:(a b c)' \
    '::optional arg:_files'
}
compdef _qq2 qq2


# special tag 包括
# args, files, dirs, pids, options



# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


# _arguments 形式

# 第一種
# -OPT[DESCRIPTION]
# ex: --help[ Show this message and exit.]


# 第二種
# -OPT[DESCRIPTION]:MESSAGE:ACTION
# ex: -m[pdf file in ~/Downloads]:filename:->files


# 第三種
# N:MESSAGE:ACTION
#    N -> the Nth command arg
#    N is omitted -> just means the next command
#    :: -> the argument is optional.
# '1:first arg:_net_interfaces' \
# '::optional arg:_files' \
# ':next arg:(a b c)'




function qq1() { echo "Hello $1!";}
function _qq1() {
    _arguments \
    '-m[pdf file in ~/Downloads]:filename:->files' \
    '-f[flags]:flag:->flags' \
    '-s[sessionIds]:sessionId:->sessionIds' \
    '-t[test]:t:->tests' \
    '-t2[test2]:t:->tests2' \
    '-a1[alternative ex1]:t:->a11' \
    '-a2[alternative ex2]:t:->a12' \
    '-a3[alternative ex3]:t:->a13' \
    '-a4[alternative ex4]:t:->a14' \
    '-q1[q11]:t:->q11' \
    '--f[input file]:filename:_files' \
    '-s1[sort output]' \
    '--l[double - is fine]'

    case "$state" in
        a11)
            #  'TAG:DESCRIPTION:ACTION'
            #  'arguments:custom arg:(a b c)'
            # 兩種選擇，一種是 arg, 一種是 files
            _alternative \
            'arguments:custom arg:(a b c)' \
            'files:filename:_files'
          ;;
        a12)
            # 也可以加上 description
            _alternative \
            'args:custom arg:((a\:"description a" b\:"description b" c\:"description c"))' \
            'files:filename:_files'
          ;;
        a13)
            # dirs and pids 都是 special tag
            _alternative \
              "dirs:user directory:($LINE_TOKEN)" \
              "pids:process ID:($(ps -ax -o pid))"
          ;;
        a14)
            _alternative \
              "directories:user directory:($pwd)" \
              'options:comma-separated opt: _values -s , letter a b c'
          ;;
        q11)
            # compadd foo bar blah
            compadd -X 'Some completions' foo bar blah
            # 選上加上 preifx
            # compadd -P what_ foo bar blah
            # 選上加上 suffix
            # compadd -S _todo foo bar blah

            # use array
            # compadd -a wordsarray
            ;;
        files)
            # Comma separated list of session id numbers:
            _values 'pdf files' /Users/re4388/Downloads/*.pdf
            ;;
        flags)
            _values -s , 'flags' a b c d e
            ;;
        sessionIds)
            # comma separated list of session id numbers:
            _values -s , 'session id' "${(uonzf)$(ps -ax -o pid=)}"
            ;;
        tests)
            # layer by layer choose 選後，會補上 @, :
            _sep_parts '(foo bar)' @ '(news ftp)' : '(woo laa)'
            ;;
        tests2)
            # layer by layer choose，如果剛好一樣，像是第一層都是 00 就不會給選項了
            _multi_parts : '(00:11:22:33:44:55 00:23:34:45:56:67 00:23:45:56:67:78)'
            ;;
    esac

}
compdef _qq1 qq1
