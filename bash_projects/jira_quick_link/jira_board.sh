#!/bin/bash

# -e  Exit immediately if a command exits with a non-zero status.
set -e

json_path=~/projects/dotfiles/bash_projects/jira_quick_link/jira_ticket.json

####### main ########

function main(){
  if [ "${1}" = "show" ];then
    echo "Supported Ticket:"
    cat ${json_path} | jq . 
    exit 0
  elif [ "${1}" = "-h" ] || [ -z ${1} ];then
    echo "Accept argument: 'show', '<ticket-number>'"
    exit 0
  elif [ ! -z ${1} ];then
    # below line enable pipe in shell script
    shopt -s lastpipe
    cat ${json_path} | jq -r " .RAI_${1}.ticketNum" | read ticketNum
    cat ${json_path} | jq -r " .RAI_${1}.PR_Id" | read PR_Id
    cat ${json_path} | jq -r " .RAI_${1}.docTitle" | read docTitle
    cat ${json_path} | jq -r " .RAI_${1}.repo" | read repo
    cat ${json_path} | jq -r " .RAI_${1}.ticketFullName" | read ticketFullName
    cat ${json_path} | jq -r " .RAI_${1}.project_name" | read project_name
  else
    echo "something wrong"
    exit 1
  fi
}

main $1

####### assign url ########

if [ ${ticketNum} != null ]; then
  jira_url="https://jira.imgdev.bioclinica.com/browse/RAI-$ticketNum"
  jira_title=jira
fi


if [ ${PR_Id} != null ]; then
  # project_name could be VF or AI
  PR_url="https://stash.imgdev.bioclinica.com/projects/${project_name}/repos/${repo}/pull-requests/$PR_Id/overview"
  PR_title=stash
fi

if [ ${docTitle} != null ]; then
  doc_url="https://confluence.imgdev.bioclinica.com/pages/viewpage.action?spaceKey=VF&title=${docTitle}"
  doc_title=doc
fi


if [ ${repo} != null ]; then
  jenkin_url="https://jenkins.imgdev.bioclinica.com/view/VF_Dev/job/VF/job/(ci)${repo}/job/feature%252F${ticketFullName}/"
  jenkin_title=jenkins
fi


####### the UI part ########

function echoLink(){
  if [ -z ${1} ]; then
    echo "not implemented"
  else
    echo -e "\e]8;;${1}\a${2}\e]8;;\a"
  fi
}


cat << EOF
===================================
EOF

echoLink ${jira_url} ${jira_title}
echoLink ${PR_url} ${PR_title}
echoLink ${doc_url} ${doc_title}
echoLink ${jenkin_url} ${jenkin_title}

cat << EOF
===================================
EOF

############# ref ##############################

# echo -e "\e]8;;${jenkin_url}\a${jenkin_title}\e]8;;\a"
# echo "https://jenkins.imgdev.bioclinica.com/view/VF_Dev/job/VF/job/(ci)${repo}/job/feature%252F${ticketFullName}/"
# urlencode $jenkin_url
# urldecode $jenkin_url
# https://jenkins.imgdev.bioclinica.com/view/VF_Dev/job/VF/job/(ci)view-webapp/job/feature%252FRAI-3114-remove-unused-properties-in-dev-console/

# function printLink(){
#  printf "\e]8;;${1}\e\\${2}\e]8;;\a\\n"
# }
