
library(dplyr)
library(ggplot2)

setwd("~/Google Drive/src/lastfm/")

setwd("~/Google Drive/src/lastfm/")

tracks = read.delim("exported_tracks.txt",quote = "", encoding="utf-8", sep = "\t", header = FALSE,stringsAsFactors = FALSE)
names(tracks) <- c("timestamp","title","artist","album", "trackmbid", "artistmbid", "albummbid")
tracks$date <- as.POSIXct(tracks$timestamp, origin="1970-01-01")
tracks$year <- as.numeric(format(as.POSIXct(tracks$timestamp,origin="1970-01-01"),format="%Y"))
tracks$month <- as.numeric(format(as.POSIXct(tracks$timestamp,origin="1970-01-01"),format="%m"))
tracks$day <- as.numeric(format(as.POSIXct(tracks$timestamp,origin="1970-01-01"),format="%d"))
tracks$weekday <- format(as.POSIXct(tracks$timestamp,origin="1970-01-01"),format="%a")

str(tracks)

head(tracks,15)
nrow(tracks)

summary()

head(select(filter(tracks, year==2013, month==07 ), title, album, artist),15)

by_month <- group_by(tracks, year, month )

plays <- summarise(by_month,
                   count = n(),
                   n_distinct(artist),
                   first(title)
                   )
plot(plays)

