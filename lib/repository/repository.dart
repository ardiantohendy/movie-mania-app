import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mania_app/data.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/model.dart';

const String apiKey = "5648e7528631713eb23947dc0c8bbbc7";
const String readAccessToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjQ4ZTc1Mjg2MzE3MTNlYjIzOTQ3ZGMwYzhiYmJjNyIsInN1YiI6IjYzNmY4M2UxMjQ5NWFiMDA4MjMxZDZhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Pr2eISej--mYzZeCWu4SDTa8zDg5H4XzUDniNhpvqXw";

class Repository {
  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

  List<MoviesClass> listNowPlayingMovies = [];
  List<MoviesClass> listTopRated = [];
  List<MoviesClass> listTrending = [];
  List<MoviesClass> listPopular = [];

  loadPopularMovies() async {
    Map popularMovies = await tmdbWithCustomLogs.v3.movies.getPouplar();

    final thisData = popularMovies["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          title: thisData[i]["title"],
          vote_average: i);
      if (listPopular.length < 20) {
        listPopular.add(moviesClass);
      }
    }
    return listPopular;
  }

  loadTopRatedMovies() async {
    Map topRatedMovies = await tmdbWithCustomLogs.v3.movies.getTopRated();

    final thisData = topRatedMovies["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          title: thisData[i]["title"],
          vote_average: i);
      if (listTopRated.length < 20) {
        listTopRated.add(moviesClass);
      }
    }
    return listTopRated;
  }

  loadTrendingMovies() async {
    Map trendingMovies = await tmdbWithCustomLogs.v3.trending.getTrending();

    final thisData = trendingMovies["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          title: thisData[i]["title"],
          vote_average: i);

      if (listTrending.length < 20) {
        listTrending.add(moviesClass);
      }
    }
    return listTrending;
  }

  loadNowPlaying() async {
    Map nowPlaying = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    final thisData = nowPlaying["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          title: thisData[i]["title"],
          vote_average: i);

      listNowPlayingMovies.add(moviesClass);
    }

    return listNowPlayingMovies;
  }
}
