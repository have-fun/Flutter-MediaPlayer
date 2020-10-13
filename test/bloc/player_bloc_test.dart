import 'package:audioplayers/audioplayers.dart';
import 'package:media_player/bloc/player_bloc.dart';
import 'package:media_player/data/model/song.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_helpers/mock_audio_player.dart';
import '../test_helpers/mock_stream.dart';

void main() {
  PlayerBloc playerBloc;
  AudioPlayer mockAudioPlayer;

  setUp(() {
    mockAudioPlayer = MockAudioPlayer();
    when(mockAudioPlayer.onPlayerCompletion).thenAnswer((_) => MockStream<void>());

    playerBloc = PlayerBloc(mockAudioPlayer);
  });

  test('play() should play the song', () {
    playerBloc.play(Song(previewUrl: 'song-url'));

    verify(mockAudioPlayer.play('song-url'));
  });

  test('pause() should play the song', () {
    playerBloc.pause();

    verify(mockAudioPlayer.pause());
  });

  test('resume() should resume', () {
    playerBloc.resume();

    verify(mockAudioPlayer.resume());
  });
}