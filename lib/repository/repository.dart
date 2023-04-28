import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/model.dart';

class Repository {
  final _baseUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=5648e7528631713eb23947dc0c8bbbc7&language=en-US&page=1";

  Future getData() async {
    try {
      final resopnse = await http.get(Uri.parse(_baseUrl));

      if (resopnse.statusCode == 200) {
        Iterable it = jsonDecode(resopnse.body);
        List<Movies> movieDat = it.map((e) => Movies.fromJson(e)).toList();
        return movieDat;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
