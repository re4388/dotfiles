
You need to have below setup in wsl
```
# re4388 @ LAPTOP-UO6DJS4G in ~/projects/script [19:35:49]
$ tree                                                                                                                                         [Thu Aug 26 19:35:49 2021]
.
└── qb.sh
```

inside qb.sh
```
#!/bin/bash

QURL=$1
QTITLE=$2
QSELECTED=$3
QCOMMANDLINE=$4
QHTMLPATH=`wslpath $5`
QTEXTPATH=`wslpath $6`

# below here, I use a heredoc to create a Hugo leaf bundle
echo ${QURL}
echo QTITLE
echo QSELECTED
echo QCOMMANDLINE
echo QHTMLPATH
echo QTEXTPATH
```

remember to use `chmod +x qb.sh`