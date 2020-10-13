import 'package:flutter/material.dart';
import 'package:media_player/bloc/player_bloc.dart';
import 'package:media_player/bloc/search_bloc.dart';
import 'package:media_player/common/injector.dart';
import 'package:media_player/data/model/song.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc _searchBloc;
  PlayerBloc  _playerBloc;

  @override
  Widget build(BuildContext context) {
    _searchBloc ??= Injector.of(context).searchBloc;
    _playerBloc ??= Injector.of(context).playerBloc;

    return Scaffold(
      appBar: AppBar(title: Text('Media Player')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: Key('searchField'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search artist',
              ),
              onSubmitted: (String value) async {
                _searchBloc.searchAsync(value);
                _playerBloc.notifyNewSearch();
              },),
            _buildSearchResults()
          ],
        ),
      ),
    bottomSheet: _buildPlayerController());
  }

  Widget _buildSearchResults() {
    return StreamBuilder(
      stream: _searchBloc.songsStream,
      builder: (context, AsyncSnapshot<Iterable<Song>> snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            child: ListView(
              children: snapshot.data.map((song) => _buildSongItem(song)).toList())
          );
        }
        else if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.all(30.0),
            child: Text('An error has occurred.')
          );
        }
        else {
          return SizedBox.shrink();
        }
      }
    );
  }

  Widget _buildSongItem(Song song) {
    return Builder(
      builder: (BuildContext context) {
        return Card(
          child:
          InkWell(
            onTap: () => _playerBloc.play(song),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(song.artworkUrl)
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(song.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(song.artist),
                        Text(song.album)
                      ]
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: StreamBuilder(
                      stream: _playerBloc.playingSong,
                      builder: (context, AsyncSnapshot<Song> snapshot) {
                        if (snapshot.hasData && song.id == snapshot.data.id) {
                          return Icon(Icons.music_note);
                        }
                        else {
                          return SizedBox.shrink();
                        }
                      }
                    )
                  )
                ]
              )
            )));
      });
  }

  Widget _buildPlayerController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: _playerBloc.isPlaying,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return InkWell(
                  onTap: () => _playerBloc.pause(),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.pause),
                  )
                );
              }

              return InkWell(
                onTap: () => _playerBloc.resume(),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.play_arrow),
                )
              );
            }

            return SizedBox.shrink();
          },
        )
      ]);
  }

  @override
  void dispose() {
    _searchBloc?.dispose();
    _playerBloc?.dispose();

    super.dispose();
  }
}
