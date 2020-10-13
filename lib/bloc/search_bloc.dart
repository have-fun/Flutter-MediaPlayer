import 'dart:async';

import 'package:media_player/data/model/song.dart';
import 'package:media_player/data/song_repo.dart';

class SearchBloc {
  final _controller = StreamController<Iterable<Song>>();
  Stream<Iterable<Song>> _stream;
  final SongRepo _songRepo;

  SearchBloc(this._songRepo) {
    _stream = _controller.stream.asBroadcastStream();
  }

  Stream<Iterable<Song>> get songsStream => _stream;

  void searchAsync(String term) async {
    try {
      final songs = (await _songRepo.searchAsync(term));
      _controller.sink.add(songs);
    } catch(e) {
      _controller.sink.addError(e);
    }
  }

  void dispose() {
    _controller.close();
  }
}