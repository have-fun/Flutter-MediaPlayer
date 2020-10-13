import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:media_player/main.dart';
import 'package:mockito/mockito.dart';

import 'test_helpers/mock_audio_player.dart';
import 'test_helpers/mock_song_remote_db.dart';
import 'test_helpers/mock_stream.dart';

// Widget testing for searching and showing results.
void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Show results test', (WidgetTester tester) async {
    final mockAudioPlayer = MockAudioPlayer();

    when(mockAudioPlayer.onPlayerCompletion).thenAnswer((_) => MockStream<void>());

    final myApp = MyApp(
      songRemoteDs: MockSongRemoteDs(),
      audioPlayer: mockAudioPlayer
    );

    await tester.pumpWidget(myApp);

    final searchField = find.byKey(Key('searchField'));

    // Verify that the search field is there.
    expect(searchField, findsOneWidget);

    // Trigger search action.
    await tester.enterText(searchField, 'my-song');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();

    // Verify that the results are shown.
    expect(find.text('name1-my-song'), findsOneWidget);
    expect(find.text('name2-my-song'), findsOneWidget);
  });
}
