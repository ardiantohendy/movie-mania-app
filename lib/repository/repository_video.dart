import 'package:tmdb_api/tmdb_api.dart';

const String apiKey = "5648e7528631713eb23947dc0c8bbbc7";
const String readAccessToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjQ4ZTc1Mjg2MzE3MTNlYjIzOTQ3ZGMwYzhiYmJjNyIsInN1YiI6IjYzNmY4M2UxMjQ5NWFiMDA4MjMxZDZhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Pr2eISej--mYzZeCWu4SDTa8zDg5H4XzUDniNhpvqXw";

class RepositoryVides {
  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
}
