Date="$(date)"
mkdir -p -- "$Date"
cd "$Date" 
export SSLKEYLOGFILE=$PWD/keylog.log
open -n /Applications/Firefox\ Developer\ Edition.app
