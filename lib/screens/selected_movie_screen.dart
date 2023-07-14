import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/models/model.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../repository/repository.dart';

class SelectedMovieScreen extends StatefulWidget {
  int id;
  String poster_path;
  String backdrop_path;
  String title;
  String name;
  String overview;
  double vote_average;
  String release_date;

  SelectedMovieScreen(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.title,
      required this.name,
      required this.overview,
      required this.vote_average,
      required this.release_date});

  @override
  State<SelectedMovieScreen> createState() => _SelectedMovieScreenState();
}

class _SelectedMovieScreenState extends State<SelectedMovieScreen> {
  String videoKey = "";
  final String imageUrl = "https://image.tmdb.org/t/p/w500";
  final String videoUrl = "https://www.youtube.com/watch?v=";
  int listVideoLength = 0;

  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

  late YoutubePlayerController _controller;

  Future<dynamic> loadVideo() async {
    final gettingMovie =
        await tmdbWithCustomLogs.v3.movies.getVideos(widget.id);

    final videoId = YoutubePlayer.convertUrlToId(
        videoUrl + gettingMovie["results"][0]["key"]);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false, disableDragSeek: true),
    );

    listVideoLength = gettingMovie["results"].length;

    return listVideoLength;
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    // print("My video key: " + videoKey);

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                        image: CachedNetworkImageProvider(
                            imageUrl + widget.backdrop_path),
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
                                top: 28.8,
                                left: 28.8,
                                right: 28.8,
                                bottom: 28.8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (widget.title != null)
                                      ? widget.title
                                      : widget.name,
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
                                    "${widget.release_date}",
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
                                imageUrl + widget.poster_path),
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
                            width: currentWidth < 370 ? 175 : 225,
                            child: Text(
                              widget.overview,
                              style: GoogleFonts.lato(
                                fontSize: currentWidth < 370 ? 11 : 13,
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
                              "rating: ${widget.vote_average}",
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
              ),

              //video page

              FutureBuilder(
                future: loadVideo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: const LinearProgressIndicator(
                          color: Colors.black,
                          backgroundColor: Colors.white,
                        )); // Tampilkan loading spinner saat proses fetch data masih berjalan
                  }
                  if (snapshot.hasError) {
                    return Container();
                  }
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 12.8),
                    padding: EdgeInsets.all(5.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.9),
                      color: const Color.fromARGB(255, 64, 64, 77),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12.8),
                          child: Text(
                            "VIDEO",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.6),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 12.8, right: 12.8),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                          ),
                        ),
                        const SizedBox(height: 10.6),
                        Container(
                          height: 57.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
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
                              GestureDetector(
                                onTap: () {},
                                child: Transform.rotate(
                                  angle: 3.1,
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.6),
                      ],
                    ),
                  );
                },
              ),

              Container(
                margin: const EdgeInsets.only(top: 12.8),
                padding: const EdgeInsets.all(5.8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 31, 31, 31),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 18.9),
                      child: Text(
                        "MovieMania",
                        style: GoogleFonts.notoSerif(
                          fontSize: currentWidth < 370 ? 14.6 : 16.6,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, bottom: 6),
                      height: 1,
                      width: 250,
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.9),
                      child: Text(
                        "Developed by Ardianto_Hendy\nsuported by The Movie Database\n2023",
                        style: GoogleFonts.lato(
                          fontSize: currentWidth < 370 ? 9.6 : 10.6,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
