
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

PS3='Please enter your choice: '
options=(
  "view-webapp"
  "imaging-library"
  "view-service"
  "Quit"
)

select opt in "${options[@]}"
do
    case $opt in
        "view-webapp")
            dir=${workspace}${datetime}_view-webapp
            git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git $dir
 						# cd $dir
						# npm i
            break
            ;;
        "imaging-library")
            dir=${workspace}${datetime}_imaging-library
            git clone https://stash.imgdev.bioclinica.com/scm/vf/imaging-library.git $dir
						# cd $dir
						# npm i
            break
            ;;
        "view-service")
					  echo
            dir=${workspace}${datetime}_view-service
						git clone https://stash.imgdev.bioclinica.com/scm/vf/view-service.git $dir
						# cd $dir
						# npm i
            break
            ;;
        "Quit")
            echo "you chose choice $REPLY which is $opt"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
