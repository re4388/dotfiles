#  to update the models:
#  llm models | awk -F': ' '{print $2}' | awk -F' ' '{print $1}' | tr '\n' ' ' > /Users/re4388/project/personal/llm_data/llm_model_list
llm_model_list='/Users/re4388/project/personal/llm_data/llm_model_list'

# llm plugins | jq '.[] .name' | sed 's/"//g' | tr '\n' ' ' > /Users/re4388/project/personal/llm_data/llm_installed_plugins
llm_plugin_list='/Users/re4388/project/personal/llm_data/llm_installed_plugins'



function _llm {
    local line

    _arguments -C \
        '-m[to specify model]:t:->models' \
        "--help[Show help information]" \
        "--version[Show version information]" \
        "--no-stream[disable output stream]" \
        "--key[llm 'xxxx' --key sk-my-key-goes-here]" \
        "1: :('models' 'aliases' 'chat' 'install' 'uninstall' 'plugins' 'logs' 'keys')" \
        "*::arg:->args"

    case $line[1] in
        models)
            _models
        ;;
        aliases)
            _aliases
        ;;
        chat)
            _chat
        ;;
        logs)
            _logs
        ;;
        install)
            _install
        ;;
        uninstall)
            _uninstall
        ;;
        keys)
            _keys
        ;;
    esac


    case "$state" in
        empty)
        ;;
        models)
            _values -s 'model' "${(uonzf)$(cat /Users/re4388/tmp/a2)}"
        ;;
    esac
}


function _keys() {
    local line
    _arguments -C \
        "1: :('set' 'path')" \
        "*::arg:->args"
    case $line[1] in
        set)
            _setKey
        ;;
    esac
}

function _setKey() {
  compadd openai openrouter
}


function _install() {
    compadd -X 'choose plugin to install' plugin_to_install
}

function _uninstall() {
    _values -s , 'plugin to uninstall' "${(uonzf)$(cat $llm_plugin_list)}"
}


function _aliases {
    local -a subcmds
    subcmds=(
      'remove: llm aliases remove <alias>'
      'set: llm aliases set <alias> <model_name>'
      'list: llm aliases list'
    )
    _describe 'basic_function' subcmds

    _arguments '--json[in json format]'
}

function _logs() {
      _arguments \
      '-m[filter by model]:t:->models' \
      '-q[query. ex: llm logs -q "cheesecake"]:t:->empty' \
      '-c[to by conversation id]:t:->empty' \
      '--cid[to by conversation id]:t:->empty' \
      '-n[ see most recent #. ex: llm logs -n 5.  use 0 to see all]:t:->empty' \
      '--save[to save into custom template]:t:->empty' \
      '--json[in json format"]' \
      '-t[truncate mode, use when data is too length"]' \
      '--truncate[truncate mode, use when data is too length"]' \

      case "$state" in
          empty)
          ;;
          models)
              _values -s 'model' "${(uonzf)$(cat /Users/re4388/tmp/a2)}"
          ;;
      esac

      local -a subcmds
      subcmds=(
        'on: turn on log'
        'off: turn off log'
        'status: see log status'
        'path: see where log located'
      )
      _describe 'basic_function' subcmds

}

function _chat() {
      # use _arguments , 選了就不見了
      # 如果後面有接 action, 一定選才可以繼續下去, 沒有接的，可以直接用 -c 就可以繼續 tab 下去
      _arguments \
      '-c[to start as continue the most recent prompt]' \
      '-t[to specify template]:t:->empty' \
      '-m[to specify model]:t:->models' \
      '-o[add accurate if the model supports, like chatGpt, ex: -o temperature 0.2]:t:->empty' \
      '--save[to save into custom template]:t:->empty' \

      case "$state" in

          empty)
          ;;
          models)
              _values -s 'model' "${(uonzf)$(cat $llm_model_list)}"
          ;;

      esac
}

function _models {
    local line
    _arguments -C \
        "--options[Show more information]" \
        "1: :(default)" \
        "*::arg:->args"

    case $line[1] in
        default)
            _values -s , 'model' "${(uonzf)$(cat $llm_model_list)}"
        ;;
    esac
}

compdef _llm llm
