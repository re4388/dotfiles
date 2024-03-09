

handleStringStream() {
  local input=""
  while IFS= read -r line; do
    input+="$line"
    if [[ $line == *"\n"* ]]; then
      echo -e "$input"
      input=""
    fi
  done
  if [[ -n $input ]]; then
    echo -e "$input"
  fi
}




enumWemo(){
  local hermes="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/Hermes-poc --json=stream"
  local ceres="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/Ceres --json=stream"
  local mneApi="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/mnemosyne-api --json=stream"
  local talos="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/talos --json=stream"
  local boSvc="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/box-microservice --json=stream"
  local angelia="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/angelia --json=stream"
  local zeus="sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/zeus --json=stream"

  { eval "$hermes"; eval "$ceres"; eval "$mneApi"; eval "$talos"; eval "$boSvc"; eval "$angelia"; eval "$zeus"; } | jq .lines | fzf | handleStringStream
}

#
#enumHermes() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/Hermes-poc --json=stream | jq .lines | fzf | handleStringStream
#}
#
############# no use below ##############
#enumCeres() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/Ceres --json=stream | jq .lines | fzf | handleStringStream
#}
#
#
#
#enumMnemosyneApi() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/mnemosyne-api --json=stream | jq .lines | fzf | handleStringStream
#}
#
#
#enumTalos() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/talos --json=stream | jq .lines | fzf | handleStringStream
#}
#
#enumBoxSvc() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/box-microservice --json=stream | jq .lines | fzf | handleStringStream
#}
#
#enumAngelia() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/angelia --json=stream | jq .lines | fzf | handleStringStream
#}
#
#enumZeus() {
#  sg scan -r /Users/re4388/project/personal/nodejs/ast-grep0/my_rule_folder/file_all_enum.yml /Users/re4388/project/work/zeus --json=stream | jq .lines | fzf | handleStringStream
#}