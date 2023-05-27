import 'package:movie_mania_app/models/model.dart';
import 'package:movie_mania_app/repository/repository.dart';
import 'package:tmdb_api/tmdb_api.dart';

class RepositorySearch {
  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

  var data = [];
  List<MoviesClass> listOfMovie = [];

  loadSearch(String query) async {
    Map loadSearch = await tmdbWithCustomLogs.v3.search.queryMulti(query);
  }
}
