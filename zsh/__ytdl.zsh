


ytinfo(){
    if [ "$#" -ne 1 ]; then
          echo "need one input, youtube url"
          return
    fi

    cd /Users/re4388/project/personal/git-clone-pjt/youtube-dl

    # list 可以下載的選項
    python -m youtube_dl -F $1

    echo "use ytdl to download"
}


ytdl() {
    if [ "$#" -ne 1 ]; then
          echo "need one input, youtube url"
          return
    fi

    cd /Users/re4388/project/personal/git-clone-pjt/youtube-dl

#    # list 可以下載的選項
#    python -m youtube_dl -F $1
#
#    echo "continue(y/n)?"
#    read response
#
#    if [ "$response" = "y" ]; then
#      echo "gogo..."
#    elif [ "$response" = "n" ]; then
#      echo "退出..."
#      return
#    fi

    echo "step1: 開始下載..."
#    python -m youtube_dl -f 22 $1
#    python -m youtube_dl -f 160 $1  # for debug, small mp4
    python -m youtube_dl -f 'bestvideo[height<=1440]+bestaudio/best[height<=1440]' $1

    dl_result=$?

    if [ "$dl_result" -eq 0 ]; then
      echo "dl successfully."
    else
      echo "youtube_dl dl failed. Error code: $dl_result"
      return
    fi

    echo "下載完成..."



#    echo "step2: 確認當前 folder mp4 的個數應該是一個..."
#    local yt_dl_title=$(check_yt_dl_count_valid)
#    if [ "$yt_dl_title" -eq 1 ]; then
#      return 1
#    else
#      echo "個數正確..繼續..."
#    fi

#   不需要翻譯和改為一個變數了 XDDD
#    echo "step3: 如果是中文，重新命名為英文和轉為變數, 如果是英文，轉為變數"
#    local yt_dl_title_filename=$(basename "$yt_dl_title")
#    local var_result=$(translate_to_var "$yt_dl_title_filename")
#    mv "$yt_dl_title_filename" "$var_result.mp4"


    echo "step2: sync 到 stream vid"
    sync_mp4_and_mkv_to_stream
}



sync_mp4_and_mkv_to_stream(){
    sync_to_acer_vid_stream_mp4
    sync_to_acer_vid_stream_mkv
}


sync_to_acer_vid_stream_mkv(){
      # sync 到 stream vid
      scp /Users/re4388/project/personal/git-clone-pjt/youtube-dl/*mkv re4388@acer.tailbcab9.ts.net:/home/re4388/vid_stream
      scp_result=$?

      if [ $scp_result -eq 0 ]; then
        echo "mkv: scp run successfully."
        rm /Users/re4388/project/personal/git-clone-pjt/youtube-dl/*mkv
      else
        echo "mkv: failed. Error code: $scp_result"
      fi
}

sync_to_acer_vid_stream_mp4(){
      # sync 到 stream vid
      scp /Users/re4388/project/personal/git-clone-pjt/youtube-dl/*mp4 re4388@acer.tailbcab9.ts.net:/home/re4388/vid_stream
      scp_result=$?

      if [ $scp_result -eq 0 ]; then
        echo "mp4: scp run successfully."
        rm /Users/re4388/project/personal/git-clone-pjt/youtube-dl/*mp4
      else
        echo "mp4: failed. Error code: $scp_result"
      fi
}



################ no use below ################



ytdl_no_sync(){
    if [ "$#" -ne 1 ]; then
          echo "need one input, youtube url"
          return
    fi

    cd /Users/re4388/project/personal/git-clone-pjt/youtube-dl

    # list 可以下載的選項
    python -m youtube_dl -F $1

    echo "continue(y/n)?"
    read response

    if [ "$response" = "y" ]; then
      echo "開始下載..."
    elif [ "$response" = "n" ]; then
      echo "退出..."
      return 0
    fi

    # 下載
    python -m youtube_dl -f 22 $1
}





function check_yt_dl_count_valid(){
      local_dir="/Users/re4388/project/personal/git-clone-pjt/youtube-dl"
      files=("$local_dir"/*mp4 *mkv)

      # 检查文件列表的长度
      if [ "${#files[@]}" -eq 1 ]; then
        # 如果只有一个文件,则输出文件名
        echo "${files}"
      else
        # 如果不是只有一个文件,则退出并返回错误码
        echo "Error: Expected exactly one file, but found ${#files[@]} files."
        return
      fi
      # 確認file1只有一個檔案, 如果不是1個， stop, something wrong
}


translate_to_var(){
  if [ "$#" -ne 1 ]; then
        echo "need one input, chinese or English"
        return
  fi

  local lang=$(/Users/re4388/project/personal/lang/golang/chinese2Eng/chineseEngDetector $1)

  # 根据输入参数输出相应的信息
  case "$lang" in
    "English")
      local var=$(bun /Users/re4388/project/personal/lang/bun/bun_cli_0/poc/translate/eng_to_var.ts "$1")
      echo "$var"
      ;;
    "Chinese")
      local translated=$(bun /Users/re4388/project/personal/lang/bun/bun_cli_0/poc/translate/translateC2E.ts "$1")
      local var=$(bun /Users/re4388/project/personal/lang/bun/bun_cli_0/poc/translate/eng_to_var.ts "$translated")
      echo "$var"
      ;;
    *)
      echo "Invalid case, only allow Chinese or English to covert to variable"
      return 1
      ;;
  esac
}



