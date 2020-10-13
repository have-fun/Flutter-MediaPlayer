import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:media_player/common/settings.dart';
import 'package:media_player/data/model/song.dart';

class SongRemoteDs {

  final http.Client _httpClient;
  final Settings _settings;

  SongRemoteDs(this._httpClient, this._settings);

  Future<Iterable<Song>> searchAsync(String term) async {
    final searchApiEndpoint = '${_settings.baseUrl}&term=$term';

    var url = Uri.encodeFull(searchApiEndpoint);

    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error searching songs - ${response.statusCode}");
    }

    final map = jsonDecode(response.body);
    return (map['results'] as List).map((jsonSong) => Song.fromJson(jsonSong));
  }
}