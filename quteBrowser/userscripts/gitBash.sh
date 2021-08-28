
QURL=$1
QTITLE=$2
MainNoteBook=cbf01dd1401843b7b375e698606977da
fromQBNoteBook=aed7746eeab64317ae855893905f623f

# use below script run in gitbash to check the parent_id
# just use a note in that parent/notebook and the output will show you the parent id
# curl http://localhost:41184/notes/99a3a7e964b24594b278633b59ad19ad?token=23cb4f16bdb5306263d2405bbca50534b7b0337998abae926061f64fb8784a5d31063bc88d1074e3679133e1f93b62169ff129ed4288df1094c6c4e5b737371c

# echo ${QURL}
# echo ${QTITLE}

asus_token=e9639d07316a709e94b61c0eb478d3adcbd51121a75170c0417de4e2969619b3930646be7c4d0df96a68758702fbb2dba1dfa565a914ca13fb9c883ea1f974bb
wits_token=23cb4f16bdb5306263d2405bbca50534b7b0337998abae926061f64fb8784a5d31063bc88d1074e3679133e1f93b62169ff129ed4288df1094c6c4e5b737371c

echo $HOME
echo $USERNAME

if [ "${USERNAME}" = "re438" ]; then
  echo "asus detected"
  token=$asus_token
fi

if [ "${USERNAME}" = "tp2011002" ]; then
  echo "wits detected"
  token=$wits_token
fi

echo $token

function createJoplinNoteWithTitleAndUrl(){
# add space before below backsplash
curl --data '{ "title":"'"$QTITLE"'","parent_id":"'"$fromQBNoteBook"'","body":"['"$QTITLE"']('"$QURL"')"}' \
http://localhost:41184/notes?\
token=$1
}

createJoplinNoteWithTitleAndUrl $token

#################### reference ##################
# curl --data '{ "title": "From Qb2","parent_id":"cbf01dd1401843b7b375e698606977da","body":"XX22"}' http://localhost:41184/notes?token=23cb4f16bdb5306263d2405bbca50534b7b0337998abae926061f64fb8784a5d31063bc88d1074e3679133e1f93b62169ff129ed4288df1094c6c4e5b737371c
# curl --data '{ "title":"'"$QTITLE"'","parent_id":"cbf01dd1401843b7b375e698606977da","body":"['"$QTITLE"']('"$QURL"')"}' http://localhost:41184/notes?token=23cb4f16bdb5306263d2405bbca50534b7b0337998abae926061f64fb8784a5d31063bc88d1074e3679133e1f93b62169ff129ed4288df1094c6c4e5b737371c


