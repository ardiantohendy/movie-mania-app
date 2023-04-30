import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mania_app/data.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/model.dart';

const String apiKey = "5648e7528631713eb23947dc0c8bbbc7";
const String readAccessToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjQ4ZTc1Mjg2MzE3MTNlYjIzOTQ3ZGMwYzhiYmJjNyIsInN1YiI6IjYzNmY4M2UxMjQ5NWFiMDA4MjMxZDZhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Pr2eISej--mYzZeCWu4SDTa8zDg5H4XzUDniNhpvqXw";

class Repository {
  final _baseUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=${apiKey}&language=en-US&page=1";

  List<MoviesClass> listMovies = [];

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map nowPlaying = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    final thisData = nowPlaying["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          title: thisData[i]["title"],
          vote_average: i);

      listMovies.add(moviesClass);
    }

    print(listMovies[0].title);

    return listMovies;
  }
}
