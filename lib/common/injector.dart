library dependency_injector;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player/bloc/player_bloc.dart';
import 'package:media_player/bloc/search_bloc.dart';
import 'package:media_player/data/song_repo.dart';
import 'package:media_player/data/source/remote/song_remote_ds.dart';
import 'package:meta/meta.dart';

class Injector extends InheritedWidget {
  final SongRemoteDs songRemoteDs;
  final AudioPlayer audioPlayer;

  final SongRepo songRepo;
  final SearchBloc searchBloc;
  final PlayerBloc playerBloc;

  Injector._create({
    Key key,
    @required this.songRepo,
    @required this.songRemoteDs,
    @required this.audioPlayer,
    @required Widget child,
  })
    : playerBloc = PlayerBloc(audioPlayer),
      searchBloc = SearchBloc(songRepo),
      super(key: key, child: child);

  factory Injector({
    Key key,
    @required SongRemoteDs songRemoteDs,
    @required AudioPlayer audioPlayer,
    @required Widget child,
  }) {
    return Injector._create(key: key,
      songRepo: SongRepo(songRemoteDs),
      songRemoteDs: songRemoteDs,
      audioPlayer: audioPlayer,
      child: child);
  }

  static Injector of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Injector>();

  @override
  bool updateShouldNotify(Injector oldWidget) => songRepo != oldWidget.songRepo;
}
