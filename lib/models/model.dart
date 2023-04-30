import 'package:flutter/material.dart';

class MoviesClass {
  final int id;
  final String poster_path;
  final String title;
  final int vote_average;

  const MoviesClass(
      {required this.id,
      required this.poster_path,
      required this.title,
      required this.vote_average});
}
