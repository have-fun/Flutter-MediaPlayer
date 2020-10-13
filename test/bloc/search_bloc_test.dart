import 'package:fake_async/fake_async.dart';
import 'package:media_player/bloc/search_bloc.dart';
import 'package:media_player/data/model/song.dart';
import 'package:media_player/data/song_repo.dart';
import 'package:test/test.dart';

import '../test_helpers/mock_song_remote_db.dart';

void main() {
  SearchBloc searchBloc;

  setUp(() {
    searchBloc = SearchBloc(SongRepo(MockSongRemoteDs()));
  });

  test('searchAsync() should add search results to stream', () {
    Iterable<Song> results;

    fakeAsync((async) {
      searchBloc.searchAsync('nice song');

      searchBloc.songsStream.listen((event) {
        results = event;
      });

      async.flushMicrotasks();

      expect(results, isNotNull);
      expect(results.length, equals(2));
      expect((results as List)[0].name, equals('name1-nice song'));
      expect((results as List)[1].name, equals('name2-nice song'));
    });
  });
}