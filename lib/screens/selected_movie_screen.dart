import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/models/model.dart';

class SelectedMovieScreen extends StatelessWidget {
  int id;
  String poster_path;
  String backdrop_path;
  String title;
  String overview;
  double vote_average;

  final String imageUrl = "https://image.tmdb.org/t/p/w500";

  SelectedMovieScreen(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.title,
      required this.overview,
      required this.vote_average});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 41, 51),
        ),
        child: ListView(
          children: [
            Container(
              height: 368.8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18.9),
                  bottomRight: Radius.circular(18.9),
                ),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl + backdrop_path),
                    fit: BoxFit.fill),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 28.8, left: 28.8, right: 28.8, bottom: 28.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10.8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.8),
                            color: const Color.fromARGB(255, 31, 190, 36)),
                        padding: const EdgeInsets.all(6.6),
                        child: Text(
                          "vote average: ${vote_average.toString()}",
                          style: GoogleFonts.lato(
                              fontSize: 16.8, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12.8),
              padding:
                  EdgeInsets.only(top: 10, bottom: 18, left: 5.6, right: 5.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.9),
                color: const Color.fromARGB(255, 64, 64, 77),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5.6, right: 16.8),
                    height: 185,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.9),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              imageUrl + poster_path),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 19.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5.6, right: 5.6),
                        child: Text(
                          "Synopsis",
                          style: GoogleFonts.lato(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15.6,
                      ),
                      Container(
                        width: 235.5,
                        child: Text(
                          overview,
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
