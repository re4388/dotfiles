
alias ai=sgpt

function ai-usage(){
  open "https://platform.openai.com/usage"
}

function ai_config() {
    vi ~/.config/shell_gpt/.sgptrc
}

function ai_chat_session_show() {
  sed '1q;d' ~/.config/shell_gpt/.sgptrc | cut -d'=' -f2 | xargs ls
}

function ai_code_only() {
      if [ -z "$1" ]; then
        echo "Usage: $0 <cmd with double quote>"
        return
      fi

      sgpt --code "$1"
}


function ai_shell() {
      if [ -z "$1" ]; then
        echo "Usage: $0 <cmd with double quote>"
        return
      fi

      sgpt --shell "$1"
}

function ai_repl_shell() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <unique_session_name>"
    return
  fi

  sgpt --repl "$1" --shell
}

function ai_repl() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <unique_session_name>"
    return
  fi

  sgpt --repl "$1"
}

