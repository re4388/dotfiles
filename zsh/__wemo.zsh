
function wemosql() {
#  alias gcsp='bash -c '\''cd /Users/josh/Documents/wemo/gcp/local-cloudsql-proxy && bash launchV2.sh josh.tsai $@'\'' _'
    cd /Users/re4388/project/work/local-cloudsql-proxy
    echo "${wemo_account_pass}" | pbcopy
    /Users/re4388/project/work/local-cloudsql-proxy/launchV2.sh ben.hu prod qat
}




function wemosqlqat() {
#  alias gcsp='bash -c '\''cd /Users/josh/Documents/wemo/gcp/local-cloudsql-proxy && bash launchV2.sh josh.tsai $@'\'' _'
    cd /Users/re4388/project/work/local-cloudsql-proxy
    echo "${wemo_account_pass}" | pbcopy
    /Users/re4388/project/work/local-cloudsql-proxy/launchV2.sh ben.hu qat
}

function wemosqlprod() {
#  alias gcsp='bash -c '\''cd /Users/josh/Documents/wemo/gcp/local-cloudsql-proxy && bash launchV2.sh josh.tsai $@'\'' _'
    cd /Users/re4388/project/work/local-cloudsql-proxy
    echo "${wemo_account_pass}" | pbcopy
    /Users/re4388/project/work/local-cloudsql-proxy/launchV2.sh ben.hu prod
}




