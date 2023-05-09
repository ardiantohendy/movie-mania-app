import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/connection/get_movies.dart';
import 'package:movie_mania_app/models/model.dart';
import 'package:movie_mania_app/repository/repository.dart';
import 'package:movie_mania_app/screens/selected_movie_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final String imageUrl = "https://image.tmdb.org/t/p/w500";
  final _pageController = PageController(viewportFraction: 0.887);

  Repository repository = Repository();
  GetMovies getMovies = GetMovies();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 41, 51),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //navigation drawer and user
            Container(
              height: 57.6,
              margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 57.7,
                    width: 57.6,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      color: Color(0x080a0928),
                    ),
                    child: SvgPicture.asset('assets/svg/icon_drawer.svg'),
                  ),
                  Container(
                    height: 57.7,
                    width: 57.6,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.6),
                      color: Color(0x080a0928),
                    ),
                    child: SvgPicture.asset('assets/svg/icon_user.svg'),
                  ),
                ],
              ),
            ),

            // title app

            Padding(
              padding:
                  const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
              child: Text(
                "MovieMania",
                style: GoogleFonts.lato(
                  fontSize: currentWidth < 370 ? 46.6 : 66.6,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            //desc app

            Padding(
              padding:
                  const EdgeInsets.only(top: 10.2, left: 28.8, right: 28.8),
              child: Text(
                "Nonton gratis gak pake karcis",
                style: GoogleFonts.lato(
                  fontSize: 14.8,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            //custom tab bar

            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 28.8, left: 14.4),
              child: DefaultTabController(
                length: 3,
                child: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.only(left: 14.4, right: 14.4),
                  indicatorPadding:
                      const EdgeInsets.only(left: 14.4, right: 14.4),
                  isScrollable: true,
                  labelColor: Colors.white,
                  indicator: MaterialIndicator(
                    color: Colors.white,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  unselectedLabelColor: Color(0xFF8a8a8a),
                  labelStyle: GoogleFonts.lato(
                      fontSize: 14, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: GoogleFonts.lato(
                      fontSize: 14, fontWeight: FontWeight.w700),
                  tabs: [
                    Tab(
                      child: Container(
                        child: const Text("Top Rated"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Trending"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Popular"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //List container with

            SizedBox(
              height: currentWidth < 370 ? 380.5 : 428.5,
              child: TabBarView(controller: _tabController, children: [
                FutureBuilder(
                    future: getMovies.getTopRatedList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return Text("Error: Ther is no data");
                      }
                      // return Text(getMovies.listMovies.length.toString());
                      return Container(
                        height: currentWidth < 370 ? 380.5 : 428.5,
                        margin: const EdgeInsets.only(top: 16),
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              getMovies.listTopRatedMovies.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectedMovieScreen(
                                            id: getMovies
                                                .listTopRatedMovies[index].id,
                                            poster_path: getMovies
                                                .listTopRatedMovies[index]
                                                .poster_path,
                                            backdrop_path: getMovies
                                                .listTopRatedMovies[index]
                                                .backdrop_path,
                                            title: getMovies
                                                .listTopRatedMovies[index]
                                                .title,
                                            overview: getMovies
                                                .listTopRatedMovies[index]
                                                .overview,
                                            vote_average: getMovies
                                                .listTopRatedMovies[index]
                                                .vote_average,
                                            release_date: getMovies
                                                .listTopRatedMovies[index]
                                                .release_date,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 28.8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.6),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  imageUrl +
                                                      getMovies
                                                          .listTopRatedMovies[
                                                              index]
                                                          .poster_path),
                                              fit: BoxFit.fill)),
                                    ),
                                  )),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: getMovies.getTrending(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return Text("Error: Ther is no data");
                      }
                      // return Text(getMovies.listMovies.length.toString());
                      return Container(
                        height: currentWidth < 370 ? 380.5 : 428.5,
                        margin: const EdgeInsets.only(top: 16),
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              getMovies.listTrending.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectedMovieScreen(
                                            id: getMovies
                                                .listTrending[index].id,
                                            poster_path: getMovies
                                                .listTrending[index]
                                                .poster_path,
                                            backdrop_path: getMovies
                                                .listTrending[index]
                                                .backdrop_path,
                                            title: getMovies
                                                .listTrending[index].title,
                                            overview: getMovies
                                                .listTrending[index].overview,
                                            vote_average: getMovies
                                                .listTrending[index]
                                                .vote_average,
                                            release_date: getMovies
                                                .listTrending[index]
                                                .release_date,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 28.8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.6),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  imageUrl +
                                                      getMovies
                                                          .listTrending[index]
                                                          .poster_path),
                                              fit: BoxFit.fill)),
                                    ),
                                  )),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: getMovies.getPopularMovieList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return Text("Error: Ther is no data");
                      }
                      // return Text(getMovies.listMovies.length.toString());
                      return Container(
                        height: currentWidth < 370 ? 380.5 : 428.5,
                        margin: const EdgeInsets.only(top: 16),
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              getMovies.listPopular.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectedMovieScreen(
                                            id: getMovies.listPopular[index].id,
                                            poster_path: getMovies
                                                .listPopular[index].poster_path,
                                            backdrop_path: getMovies
                                                .listPopular[index]
                                                .backdrop_path,
                                            title: getMovies
                                                .listPopular[index].title,
                                            overview: getMovies
                                                .listPopular[index].overview,
                                            vote_average: getMovies
                                                .listPopular[index]
                                                .vote_average,
                                            release_date: getMovies
                                                .listPopular[index]
                                                .release_date,
                                          ),
                                        ),
                                      );
                                      //)
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 28.8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.6),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  imageUrl +
                                                      getMovies
                                                          .listPopular[index]
                                                          .poster_path),
                                              fit: BoxFit.fill)),
                                    ),
                                  )),
                        ),
                      );
                    })
              ]),
            ),

            //dot slider

            Padding(
              padding: const EdgeInsets.only(top: 18.8, left: 28.8),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: getMovies.listPopular.length,
                effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xFF818181),
                    dotColor: Color(0xFFababab),
                    dotHeight: 4.8,
                    dotWidth: 6,
                    spacing: 4.8),
              ),
            )
          ],
        ),
      )),
    );
  }
}
