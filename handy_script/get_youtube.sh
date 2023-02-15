#!/bin/bash
# Set the URL of the stream
URL='https://rr1---sn-45gx5nuvox-u2xe6.googlevideo.com/videoplayback?expire=1676359209&ei=yeHqY8LxLoe32roPq6WZiAQ&ip=210.68.225.17&id=o-ABZVxWCT6DWiM3cIunjijSx6gCorQgfgjEjZhbg-mMuJ&itag=140&source=youtube&requiressl=yes&mh=d1&mm=31%2C29&mn=sn-45gx5nuvox-u2xe6%2Csn-un57sne7&ms=au%2Crdu&mv=m&mvi=1&pl=19&initcwndbps=627500&vprv=1&mime=audio%2Fmp4&gir=yes&clen=229673259&dur=14191.431&lmt=1672488845691632&mt=1676337180&fvip=5&keepalive=yes&fexp=24007246&c=ANDROID&txp=5532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAK_ee82XLBE0frfajPiGLos4oQtF5INzO8Xdv5DxJmCTAiEAq7JGPNbk0SxjAd8Wil7v64CIkLfqtSlerWVAlrBWJX8%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhALCH-1CQ6JMR99-Pm1Jz9Fd5N6123fvsbhMcpEao1ewDAiArFnkLiRbRbBTMbYDTFFh-tdgyiwfBg5O0tMQM31GdGw%3D%3D'

# Get the total size of the stream
# The curl "-I" option in the curl command specifies that it should only return the header information
# The grep "-i" option is used to ignore case sensitivity
SIZE=$(curl -I $URL | grep -i Content-Length | awk '{print $2}')

# to remove white space, the error msg: 
# [zsh function throwing "Bad math expression: illegal character" error - Stack Overflow](https://stackoverflow.com/questions/53012287/zsh-function-throwing-bad-math-expression-illegal-character-error)
SIZE=$(echo "$SIZE" | tr -d '\r')

echo $SIZE

# Fetch the stream in 10 MB chunks and append the data to the output
# The curl -r option is used to specify the range of bytes to download.
for ((i = 0; i < $SIZE; i += 10000000))
do
	curl -r $i-$((i + 9999999)) $URL >> 'output.mp4'
done
