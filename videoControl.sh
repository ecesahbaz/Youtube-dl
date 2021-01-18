#! /bin/bash



youtubedl() {
  youtube-dl --get-id --batch-file="youtube.txt" > updateId.txt  #The command to get the id of the videos from the channel url in youtube.txt file
}

youtubedl

if diff -q firstId.txt updateId.txt > /dev/null ;  then  #The diff -g command works according to the difference between the two files.If there is no difference, it continues without output.
  echo "Files are the same.Nothing new." >> /home/ece/Desktop/cron.log
else
  echo  "Files are different.New video added." >> /home/ece/Desktop/cron.log
  echo -e "New video:\c" >> /home/ece/Desktop/cron.log
  grep -Fxvf firstId.txt updateId.txt  #The difference in the file is output with the grep command.
  echo "Grep is done." >> /home/ece/Desktop/cron.log
  grep -Fxvf firstId.txt updateId.txt  > /home/ece/Desktop/video/grepId.txt  #Output is printed to the grepId file.
  echo "Export to grepId finished." >> /home/ece/Desktop/cron.log
  youtube-dl -f best --batch-file="grepId.txt" >> /home/ece/Desktop/cron.log  #Output is download.
  youtube-dl --get-filename --batch-file="grepId.txt" > /home/ece/Desktop/video/uploads.txt
  youtube-dl --get-id --batch-file="updateId.txt" > firstId.txt  #Finally the two files become equal.
  
fi 