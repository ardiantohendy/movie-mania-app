import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mania_app/screens/selected_movie_screen.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../repository/repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final String imageUrl = "https://image.tmdb.org/t/p/w500";
String query = "";

class _SearchScreenState extends State<SearchScreen> {
  List<MoviesClass> _movies = [];
  TextEditingController _searchController = TextEditingController();

  Future<void> _searchMovies(String query) async {
    String apiKey = "5648e7528631713eb23947dc0c8bbbc7";
    String url =
        'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$query';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Mengubah data JSON menjadi daftar objek Movie
      List<MoviesClass> movies = [];
      for (var item in data['results']) {
        MoviesClass movie = MoviesClass.fromJson(item);
        movies.add(movie);
      }

      // Mengupdate state dengan daftar film yang ditemukan
      setState(() {
        _movies = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 40, 41, 51),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 58.8, left: 28.8, right: 28.8),
                child: Text(
                  "Search Movie",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.notoSerif(
                    // fontSize: currentWidth < 370 ? 46.6 : 52.6,
                    fontSize: 24.4,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 18.8, left: 28.8, right: 28.8),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 60, 60, 60),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: const EdgeInsets.only(
                        top: 0, left: 8.2, bottom: 0, right: 8.2),
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 161, 160, 160)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        String query = _searchController.text.trim();
                        _searchMovies(query);
                      },
                    ),
                    suffixIconColor: Colors.white,
                    hintText: "Search anything...",
                  ),
                  onSubmitted: (value) {
                    String query = value.trim();
                    _searchMovies(query);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    MoviesClass movie = _movies[index];
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 59, 59, 59),
                        ),
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 0, bottom: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SelectedMovieScreen(
                                  id: movie.id,
                                  poster_path: movie.poster_path,
                                  backdrop_path: movie.backdrop_path,
                                  title: movie.title,
                                  overview: movie.overview,
                                  vote_average: movie.vote_average,
                                  release_date: movie.release_date,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                            title: Text(
                              movie.title != null ? movie.title : movie.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              movie.release_date != null
                                  ? movie.release_date
                                  : (movie.first_air_date != null
                                      ? movie.first_air_date
                                      : "Unknown"),
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: Text(
                              movie.vote_average.toString(),
                              style: TextStyle(color: Colors.amber),
                            ),
                            leading: movie.poster_path != null
                                ? Image.network(imageUrl + movie.poster_path)
                                : Image.asset("assets/images/browser.png"),
                          ),
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
