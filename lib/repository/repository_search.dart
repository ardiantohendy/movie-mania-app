import 'package:movie_mania_app/repository/repository.dart';
import 'package:tmdb_api/tmdb_api.dart';

class RepositorySearch {
  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

  loadSearch() async {}
}
