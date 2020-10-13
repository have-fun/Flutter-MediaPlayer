import 'package:media_player/data/model/song.dart';
import 'package:media_player/data/source/remote/song_remote_ds.dart';

class MockSongRemoteDs extends SongRemoteDs {
  MockSongRemoteDs() : super(null, null);

  @override
  Future<Iterable<Song>> searchAsync(String term) async {
    return [
      Song(id: 1, name: 'name1-$term', artist: 'artist-1', album: 'album-1', artworkUrl: 'http://test.com/artwork-1'),
      Song(id: 2, name: 'name2-$term', artist: 'artist-2', album: 'album-2', artworkUrl: 'http://test.com/artwork-2')
    ];
  }
}