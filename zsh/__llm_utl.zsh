
# llm -m openrouter/mistralai/mistral-7b-instruct:free

# curl -s https://www.nytimes.com/ | strip-tags .story-wrapper | ttok -t 4000 | llm -m openrouter/mistralai/mistral-7b-instruct:free 'summary bullet points'


#    case $opt in
#        "view-webapp")
#            dir=${workspace}${datetime}_view-webapp
#            git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git $dir
# 						cd $dir
#						npm i
#            break
#            ;;
#        "imaging-library")


function llm_doc() {
      selected_option=$(echo -e "llm_doc_plugin\nllm_doc_chat\nllm_doc_alias\nllm_doc_models\nllm_doc\nllm_doc_common_use\nllm_doc_log\nllm_doc_template\n" | fzf --prompt="Choose an option: ")
      if [ -n "$selected_option" ]; then
           case $selected_option in
               "llm_doc_plugin")
                  llm_doc_plugin
                   ;;
               'llm_doc_chat')
                  llm_doc_chat
                   ;;
               'llm_doc_alias')
                  llm_doc_alias
                   ;;
               'llm_doc_models')
                  llm_doc_models
                   ;;
               'llm_doc')
                  llm_doc
                   ;;
               'llm_doc_common_use')
                  llm_doc_common_use
                   ;;
               'llm_doc_log')
                  llm_doc_log
                   ;;
                'llm_doc_template')
                llm_doc_template
                    ;;
               *)
                   echo "not available"
                   ;;
           esac

      else
          echo "No option selected"
      fi
}






function llm_show() {
      selected_option=$(echo -e "key\nmodel\nalias\nmodel_size" | fzf --prompt="Choose an option: ")
      if [ -n "$selected_option" ]; then
           case $selected_option in
               "key")
                 llm_show_keys
                   ;;
               'alias')
                  llm_show_aliases
                   ;;
               'model')
                  llm_show_models
                   ;;
               'model_size')
                  llm_show_model_size
                   ;;
               *)
                   echo "not available"
                   ;;
           esac

      else
          echo "No option selected"
      fi
}



################# LLM #################

# 目前 default 是 gemini-pro
#alias llmfree="llm -m gpt4all-falcon-newbpe-q4_0" I think this model is still to
alias llm_phind_code="llm -m openrouter/phind/phind-codellama-34b"
alias llm_palm2_code="llm -m openrouter/google/palm-2-codechat-bison"
alias llm_lamma2_70b="llm -m openrouter/meta-llama/llama-2-70b-chat"
alias llm_3t_0125="llm -m openrouter/openai/gpt-3.5-turbo-0125"
alias llm_4t_0125="llm -m gpt-4-0125-preview"


####################### Chat #####################

#alias llm_free_Chat="llm chat -m orca-mini-3b-gguf2-q4_0"
alias chat_phind_code="llm chat -m openrouter/phind/phind-codellama-34b"
alias chat_paLm_code="llm chat -m openrouter/google/palm-2-codechat-bison"
alias chat_llama70b="llm chat -m openrouter/meta-llama/llama-2-70b-chat"
alias chat_geminiPro="llm chat -m openrouter/google/gemini-pro"

#alias llm_local_Orca_4gb_Chat="llm chat -m orca-mini-3b-gguf2-q4_0"
#alias llm_local_Falcon_8gb_Chat="llm chat -m gpt4all-falcon-newbpe-q4_0"

alias llm_show_price_and_usage="ai_price_usage"


################################ Example #################################

function llm_strip_tags_example() {
    # "get info under certain class tag"
    "cat a1.html | strip-tags -t h1 -t h2 -m '.highlight'"
    echo""

    echo"know how many tokens after strip tags"
    echo "curl -s https://www.nytimes.com/ | strip-tags -m | ttok"
    echo""

    echo"full example"
    echo "curl -s https://www.nytimes.com/ | strip-tags .story-wrapper | ttok -t 4000 | llm 'summary bullet points'"
    echo""
}

################################ Show #################################

function llm_show_model_size(){
  cd ~/.cache/gpt4all && du
}

function llm_show_keys() {
    echo "path: /Users/re4388/Library/Application\ Support/io.datasette.llm/keys.json"
    bat /Users/re4388/Library/Application\ Support/io.datasette.llm/keys.json
}


function llm_show_aliases() {
    llm aliases | fzf
}

function llm_show_models() {
    llm models | fzf
}

################################ DOC #################################

function llm_doc_common_use() {
  echo "# most common use case
        llm 'Ten names for cheesecakes'

        # redirect string
        echo 'Ten names for cheesecakes' | llm

        # redirect file
        cat myscript.py | llm 'explain this code'

        # no stream
        llm 'Ten names for cheesecakes' --no-stream

        # get info under certain class tag
        cat a1.html | strip-tags -t h1 -t h2 -m '.highlight'

        # know how many tokens after strip tags
        curl -s https://www.nytimes.com/ | strip-tags -m | ttok

        # full example
        curl -s https://www.nytimes.com/ | strip-tags .story-wrapper | ttok -t 4000 | llm 'summary bullet points'


        # where llm model placed?
        ~/.cache/gpt4all

        # see model support
        llm models
        llm models --options

        # show key path
        llm keys path"

}
function llm_doc_log() {
    echo "# see sqlite log path
          llm logs path

          # see 5 recent log
          llm logs -n 5

          # no log for this prompt
          llm 'xxxx' -n

          # turn on/off
          llm logs off or llm logs on

          # see log status
          llm logs status

          # see json
          llm logs --json

          # see all
          llm logs -n 0

          # see log with -t/--truncate option
          llm logs -n 5 -t --json

          # see conversation
          llm logs -c
          llm logs --cid 01h82n0q9crqtnzmf13gkyxawg

          # query
          llm logs -q 'cheesecake'

          # filter by model
          llm logs -m chatgpt
"
}
function llm_doc_template() {
    echo "# list current templates
          llm templates

          # save into template
          llm 'Summarize this: $input' --save summarize

          curl -s https://example.com/ | llm -t sumUpInChinese

          # set the default model
          llm 'Summarize this' --model XXX --save summarize

          # edit the template
          llm templates edit sumUpInChinese

          # show path
          llm templates path


          # multiline prompt
          prompt: >
              Summarize the following text.

              Insert frequent satirical steampunk-themed illustrative anecdotes.
              Really go wild with that.

              Text to summarize: $input


          # 還可以設定 variable and system promot(for gpt3/4 model)
          [Prompt templates - LLM](https://llm.datasette.io/en/stable/templates.html)"
}
function llm_doc_plugin() {
    echo "# install and uninstall
    llm install llm-gpt4all
    llm uninstall xxxx -y

    # list installed plugin
    llm plugins

    # plugins market!
    [Plugin directory - LLM](https://llm.datasette.io/en/stable/plugins/directory.html)"
}
function llm_doc_chat() {
        echo "to start:"
        echo "llm chat"
        echo ""

        echo "to start as continue the most recent prompt:"
        echo "llm chat -c"
        echo ""

        echo "add accurate if the model supports, like chatGpt:"
        echo "llm chat -m 3.5 -o temperature 0.2"
        echo ""

        echo "create and using template:"
        echo "llm --system 'You are a nodejs expert' -m gpt-4 --save nodejs"
        echo "llm chat -t nodejs"
}
function llm_doc_alias() {
    echo "see aliases:"
    echo "llm aliases"
    echo "or"
    echo "llm aliases list --json"
    echo ""

    echo "add aliases:"
    echo "llm aliases set <alias> <model-id>"
    echo ""

    echo "remove aliases:"
    echo "llm aliases remove <alias>"
    echo ""

    echo "see custom aliases:"
    echo "bat /Users/re4388/Library/Application\ Support/io.datasette.llm/aliases.json"
}
function llm_doc_models() {
    echo "see model:"
    echo "llm models"
    echo "or"
    echo "llm models --options"
    echo ""

    echo "to see current default:"
    echo "llm models default "
    echo ""

    echo "set default model:"
    echo "llm models default <model_name>"
}





