

tracks = read.delim("lastfmplayscomplete.csv",encoding="UTF-8")

summary(tracks)

tracksperartist<-aggregate(tracks$playcount,list(tracks$artist),sum)

names(tracksperartist) <- c("artist","playcount")
