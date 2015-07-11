setwd("~/Google Drive/src/lastfm/")

tracks = read.delim("lastfmplayscomplete.csv",quote = "",encoding="utf-8", sep = ";", header = FALSE)

summary(tracks)

names(tracks) <- c("title","albim","artist","date","timestamp")


idx <- grep("^1[[:digit:]]+$",tracks$title)

s <- paste(tracks$title[idx-1],tracks$albim[idx-1])
s



tracksperartist<-aggregate(tracks$playcount,list(tracks$artist),sum)

names(tracksperartist) <- c("artist","playcount")
