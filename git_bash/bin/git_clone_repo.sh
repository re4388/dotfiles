#!/bin/sh

set -e

cat << EOF
===================================
EOF

echo 'git-bash config  ~/.bash_profile'
echo 'zsh config       ~/.zshrc'

cat << EOF
===================================
EOF

workspace='/c/link/ws/'
datetime=`date +"%Y-%m-%d-%H-%M-%S"`

# function extra_repo_from(){
# }



PS3='Please enter your choice: '
options=(
  "view-webapp"
  "imaging-library"
  "view-service"
  "enter_repo_git_link"
  "Quit"
)

select opt in "${options[@]}"
do
    case $opt in
        "view-webapp")
            dir=${workspace}${datetime}_view-webapp
            git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git $dir
 						cd $dir
						npm i
            break
            ;;
        "imaging-library")
            dir=${workspace}${datetime}_imaging-library
            git clone https://stash.imgdev.bioclinica.com/scm/vf/imaging-library.git $dir
						cd $dir
						npm i
            break
            ;;
        "view-service")
            dir=${workspace}${datetime}_view-service
						echo $dir
						git clone https://stash.imgdev.bioclinica.com/scm/vf/view-service.git $dir
						cd $dir
						npm i
            break
            ;;
        "enter_repo_git_link")
						read -p "enter repo git: :" repo_dot_git_link  
						# below syntax get the last substring by `/` delimiter
						repo_name=${repo_dot_git_link##*/}
						dir=${workspace}${datetime}_${repo_name}
						git clone ${repo_dot_git_link} ${dir}
						cd $dir
            break
            ;;
        "Quit")
            echo "Quit"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
