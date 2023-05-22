import 'package:flutter/material.dart';

class MoviesClass {
  final int id;
  final String poster_path;
  final String backdrop_path;
  final String title;
  final String overview;
  final double vote_average;
  final String release_date;
  final List genre_ids;

  const MoviesClass(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.title,
      required this.overview,
      required this.vote_average,
      required this.release_date,
      required this.genre_ids});

  factory MoviesClass.fromJson(Map<String, dynamic> json) {
    return MoviesClass(
        id: json["id"],
        poster_path: json["poster_path"],
        backdrop_path: json["backdrop_path"],
        title: json["title"],
        overview: json["overview"],
        vote_average: json["vote_average"],
        release_date: json["release_date"],
        genre_ids: json["genre_ids"]);
  }
}
