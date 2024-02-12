
alias ai=sgpt



function ai_shell_gpt_doc() {
  echo "common usage:"
  echo 'ai "how to say hello world in python"'
  echo 'git diff | a "generate git commit msg for those changes"'
  echo 'sgpt "summarise" < document.txt'
  echo ""

  echo "pure code:"
  echo 'ai --code "xxxxxx"'
  echo ""
  echo "only shell cmd:"
  echo 'ai -- shell "xxxxxx"'
  echo ""

  echo "repl mode:"
  echo "ai --repl <unique_session_name>"
  echo ""

  echo "repl mode:"
  echo "ai --repl <unique_session_name>"
  echo "use 3 double quote for multiple line"
  echo ""
}


function ai_price_usage() {
      selected_option=$(echo -e "openAI\nmistralAI\nopenRouter\ncheckPriceRate" | fzf --prompt="Choose an option: ")
      if [ -n "$selected_option" ]; then
           case $selected_option in
               'openAI')
                   open "https://platform.openai.com/usage"
                   ;;
               'mistralAI')
                   open "https://console.mistral.ai/user/usage/"
                   ;;
               'openRouter')
                   open "https://openrouter.ai/keys"
                   ;;
                'checkPriceRate')
                    open "https://docs.google.com/spreadsheets/d/13qfDq8I0vIX0BxInC-KgUzghnJsP8AnB028myvxU-kQ"
                    ;;
               *)
                   echo "not available"
                   ;;
           esac

      else
          echo "No option selected"
      fi
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

