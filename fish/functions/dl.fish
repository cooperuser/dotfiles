function dl
	set code $argv[1]
	set artist $argv[2]
	set title $argv[3]
	set album $argv[4]

	echo "[$code] \"$artist - $title\" from $album"

	youtube-dl -x --audio-format mp3 "https://www.youtube.com/watch?v=$code" -o "$artist - $title.%(ext)s"
	id3v2 -a "$artist" -t "$title" -A "$album" "$artist - $title.mp3"
end

