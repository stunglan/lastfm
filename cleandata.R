# clean the data


setwd("~/Google Drive/src/lastfm/")

tracks = read.delim("exported_tracks.txt",quote = "", encoding="utf-8", sep = "\t", header = FALSE,stringsAsFactors = FALSE)
names(tracks) <- c("timestamp","title","artist","album", "trackmbid", "artistmbid", "albummbid")
summary(tracks)



# find the lines with extra 

idx <- grep("^1[[:digit:]]+$",tracks$title)
tracks$title[1]
as.POSIXct(tracks$timestamp[1], origin="1970-01-01")


tracks$date <- as.POSIXct(tracks$timestamp, origin="1970-01-01")


for (i in idx)  {
  print(c(tracks$title[i],tracks$album[i],tracks$artist[i],tracks$date[i]) )
}


