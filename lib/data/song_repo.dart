import 'package:media_player/data/source/remote/song_remote_ds.dart';

import 'model/song.dart';

class SongRepo {
  final SongRemoteDs _songRemoteDs;

  SongRepo(this._songRemoteDs);

  Future<Iterable<Song>> searchAsync(String term) => _songRemoteDs.searchAsync(term);

}