

# not working, since strip-tags is python lib..
function _strip-tags {
   local line
   _arguments -C \
       "--help[Show this message and exit.]" \
       "--version[Show the version and exit.]" \
       "-r[Remove content in these selectors]:t:->empty" \
       "--remove[Remove content in these selectors]:t:->empty" \
       "-i[Input file]:t:->empty" \
       "--input[Input file]:t:->empty" \
       "-t[Keep these <tags>]:t:->empty" \
       "--keep-tag [Keep these <tags>]:t:->empty" \
       "--first[First element matching the selectors]" \
       "--all-attrs [Include all attributes on kept tags]" \
       "-m[Minify whitespace]" \
       "--minify[Minify whitespace]" \
       "*::arg:->args"

   case $line[1] in
       empty)
       ;;
   esac
}

compdef _strip-tags strip-tags

