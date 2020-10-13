class Song {
  final int id;
  final String name;
  final String artist;
  final String album;
  final String artworkUrl;
  final String previewUrl;

  Song({
    this.id,
    this.name,
    this.artist,
    this.album,
    this.artworkUrl,
    this.previewUrl
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['trackId'],
      name: json['trackName'],
      artist: json['artistName'],
      album: json['collectionName'],
      artworkUrl: json['artworkUrl60'],
      previewUrl: json['previewUrl']
    );
  }
}