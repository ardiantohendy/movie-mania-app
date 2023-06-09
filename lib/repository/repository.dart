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
  List<MoviesClass> listTvPopular = [];
  List<MoviesClass> listUpcoming = [];

  loadUpcomingMovies() async {
    Map upcomingMovies = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    final thisData = upcomingMovies["results"];
    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listUpcoming.length < 10) {
        listUpcoming.add(moviesClass);
      }
    }

    return listUpcoming;
  }

  loadPopularMovies() async {
    Map popularMovies = await tmdbWithCustomLogs.v3.movies.getPouplar();

    final thisData = popularMovies["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listPopular.length < 10) {
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
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listTopRated.length < 10) {
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
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listTrending.length < 10) {
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
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listNowPlayingMovies.length < 10) {
        listNowPlayingMovies.add(moviesClass);
      }
    }

    return listNowPlayingMovies;
  }

  loadTvPopular() async {
    Map tvPopular = await tmdbWithCustomLogs.v3.tv.getPouplar();

    final thisData = tvPopular["results"];

    for (var i = 0; i < thisData.length; i++) {
      MoviesClass moviesClass = MoviesClass(
          id: thisData[i]["id"],
          poster_path: thisData[i]["poster_path"],
          backdrop_path: thisData[i]["backdrop_path"],
          title: thisData[i]["title"] ?? thisData[i]["name"],
          overview: thisData[i]["overview"],
          vote_average: thisData[i]["vote_average"].toDouble(),
          release_date:
              thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
          genre_ids: thisData[i]["genre_ids"],
          name: thisData[i]["title"],
          first_air_date: thisData[i]["first_air_date"]);

      if (listTvPopular.length < 10) {
        listTvPopular.add(moviesClass);
      }
    }

    return listTvPopular;
  }
}
