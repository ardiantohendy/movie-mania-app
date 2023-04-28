import 'package:flutter/material.dart';

class Movies {
  final int id;
  final String poster_path;
  final String title;
  final int vote_average;

  const Movies(
      {required this.id,
      required this.poster_path,
      required this.title,
      required this.vote_average});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
        id: json['mal_id'],
        poster_path: json['image_url'],
        title: json['title'],
        vote_average: json['score']);
  }
}
