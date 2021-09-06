cat << EOF
===================================
EOF

echo 'use eb to run `nvim ~/.bash_profile'

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
            echo "you chose choice $REPLY which is $opt"
						echo $datetime
						echo $workspace
            break
            ;;
        "imaging-library")
            echo "you chose choice $REPLY which is $opt"
            break
            ;;
        "view-service")
					  echo 
						git clone https://stash.imgdev.bioclinica.com/scm/vf/view-service.git ${workspace}${datetime}_view-service
						# cd $workspace$time-view-service
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

