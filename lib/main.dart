import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:media_player/common/injector.dart';
import 'package:media_player/data/source/remote/song_remote_ds.dart';

import 'common/routes.dart';
import 'common/settings.dart';
import 'features/search/search_page.dart';

void main() {
  runApp(MyApp(
    songRemoteDs: SongRemoteDs(Client(), Settings()),
    audioPlayer: AudioPlayer(),
  ));
}

class MyApp extends StatelessWidget {
  final SongRemoteDs songRemoteDs;
  final AudioPlayer audioPlayer;

  MyApp({Key key, this.songRemoteDs, this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Injector(
      songRemoteDs: songRemoteDs,
      audioPlayer: audioPlayer,
      child: MaterialApp(
        title: 'Media Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        initialRoute: Routes.searchPage,
        routes: {
          Routes.searchPage: (context) => SearchPage(),
        }
      ));
  }
}
