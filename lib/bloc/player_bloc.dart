import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:media_player/data/model/song.dart';

class PlayerBloc {
  final _songController = StreamController<Song>();
  final _stateController = StreamController<bool>();
  final AudioPlayer _audioPlayer;

  Stream<Song> _songStream;
  Stream<bool> _stateStream;

  Song _currentSong;
  bool _isCompleted = false;
  bool _isPlaying = false;

  PlayerBloc(this._audioPlayer) {
    _songStream = _songController.stream.asBroadcastStream();
    _stateStream = _stateController.stream.asBroadcastStream();

    _audioPlayer.onPlayerCompletion.listen((event) {
      _songController.sink.add(null);
      _stateController.sink.add(false);
      _isCompleted = true;
      _isPlaying = false;
    });
  }

  Stream<Song> get playingSong => _songStream;

  Stream<bool> get isPlaying => _stateStream;

  void play(Song song) {
    _isCompleted = false;
    _isPlaying = true;
    _currentSong = song;

    _audioPlayer.play(song.previewUrl);

    _songController.sink.add(song);
    _stateController.sink.add(true);
  }

  void pause() {
    _isPlaying = false;
    _audioPlayer.pause();
    _stateController.sink.add(false);
  }
  
  void resume() {
    // If the playing has been completed, play again from the beginning.
    if (_isCompleted) {
      if (_currentSong != null) {
        play(_currentSong);
        _isPlaying = true;
      }
    }
    else {
      _audioPlayer.resume();
      _isPlaying = true;
    }

    _stateController.sink.add(_isPlaying);
  }

  void notifyNewSearch() {
    if (!_isPlaying) {
      _stateController.sink.add(null);
    }
  }

  void dispose() {
    _songController.close();
    _stateController.close();
  }
}
