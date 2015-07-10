import urllib.request
import xml.etree.ElementTree as ET
import codecs


def trackparse(track):
        name = track.find("name")
        if name == None: name = ""
        else: name = name.text
        playcount = track.find("playcount")
        if playcount == None: playcount = "0"
        else: playcount = playcount.text
        artist = track.find("artist/name")
        if artist == None: artist = ""
        else: artist = artist.text
        album = track.find("album/name")
        if album == None: album = ""
        else: album = album.text
        return "{}\t{}\t{}\t{}\n".format(name,artist,album,playcount)



limit = 100
lastfmurlfirst="http://ws.audioscrobbler.com/2.0/?method=library.gettracks&api_key=89c1a90ec683b109a540bb287de37d35&user=stunglan&limit={}".format(limit)

tracksxml = urllib.request.urlopen(lastfmurlfirst).read()
lfm = ET.fromstring(tracksxml)
tracksnodes = lfm[0]
page = tracksnodes.get("page")
totalpages = int(tracksnodes.get("totalPages"))
total = tracksnodes.get("total")

print("found {} pages and {} songs".format(totalpages,total))

# totalpages=50

i = 0
error = False
with codecs.open("lastfmplays.csv","w","UTF-8") as fb:
    fb.write("name\tartist\talbum\tplaycount\n")
    while (int(page) <= totalpages) and not error:
        print("page number {}".format(page))
        for track in tracksnodes:
            i = i + 1
            fb.write(trackparse(track))
        page = str(int(page)+1)
        lastfmurlnext="{}&page={}".format(lastfmurlfirst,page)
        try:
            response = urllib.request.urlopen(lastfmurlnext)
        except urllib.error.URLError as e:
            print(e.reason)
            error = True
        else:
            tracksxml = response.read()
            lfm = ET.fromstring(tracksxml)
            tracksnodes = lfm[0]

print("wrote {} songs".format(i))
