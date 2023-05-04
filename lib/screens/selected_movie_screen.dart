import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/models/model.dart';

class SelectedMovieScreen extends StatelessWidget {
  int id;
  String poster_path;
  String backdrop_path;
  String title;
  String overview;
  double vote_average;
  String release_date;

  final String imageUrl = "https://image.tmdb.org/t/p/w500";

  SelectedMovieScreen(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.title,
      required this.overview,
      required this.vote_average,
      required this.release_date});

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
                      image:
                          CachedNetworkImageProvider(imageUrl + backdrop_path),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 57.6,
                      margin: const EdgeInsets.only(
                          top: 28.8, left: 28.8, right: 28.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 57.7,
                              width: 57.6,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.6),
                                color: const Color(0x080a0928),
                              ),
                              child: SvgPicture.asset(
                                  'assets/svg/icon_left_arrow.svg'),
                            ),
                          ),
                          Container(
                            height: 57.7,
                            width: 57.6,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              color: const Color(0x080a0928),
                            ),
                            child: SvgPicture.asset(
                                'assets/svg/icon_heart_fill.svg'),
                          ),
                        ],
                      ),
                    ),

                    // title and date

                    Align(
                      alignment: Alignment.bottomLeft,
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
                                    borderRadius: BorderRadius.circular(12.8),
                                    color: Color.fromARGB(143, 96, 108, 96)),
                                padding: const EdgeInsets.all(8.6),
                                child: Text(
                                  "${release_date}",
                                  style: GoogleFonts.lato(
                                      fontSize: 16.8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            //2nd box

            Container(
              margin: const EdgeInsets.only(top: 12.8),
              padding: EdgeInsets.all(5.8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.9),
                color: const Color.fromARGB(255, 64, 64, 77),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5.6, right: 16.8),
                    height: 225,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.9),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              imageUrl + poster_path),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12.8, bottom: 12.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                          width: 225.5,
                          child: Text(
                            overview,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(
                          height: 10.6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.8),
                              color: const Color.fromARGB(255, 31, 190, 36)),
                          padding: const EdgeInsets.all(6.6),
                          child: Text(
                            "rating: ${vote_average}",
                            style: GoogleFonts.lato(
                                fontSize: 16.8,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
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
