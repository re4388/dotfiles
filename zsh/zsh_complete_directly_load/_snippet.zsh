
function _snippet() {
      _arguments \
      '-s[search exit code ]' \
      '-a[to add new code"]:t:->empty' \
      '-e[to edit exist code]:t:->empty' \

      case "$state" in
          empty)
          ;;
      esac
}



compdef _snippet snippet
