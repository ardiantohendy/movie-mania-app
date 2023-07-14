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
import 'package:movie_mania_app/screens/search_screen.dart';
import 'package:movie_mania_app/screens/selected_movie_screen.dart';
import 'package:movie_mania_app/widgets/bottom_navigation_bar.dart';
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
      // bottomNavigationBar: const ,
      bottomNavigationBar: const BottomNavigationBarMovies(),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                      },
                      child: Container(
                        height: 57.7,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x080a0928),
                        ),
                        child: SvgPicture.asset('assets/svg/icon_search.svg'),
                      ),
                    )
                  ],
                ),
              ),

              // title app

              Padding(
                padding:
                    const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Text(
                  "MovieMania",
                  style: GoogleFonts.notoSerif(
                    fontSize: currentWidth < 370 ? 46.6 : 52.6,
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
                    labelPadding:
                        const EdgeInsets.only(left: 14.4, right: 14.4),
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
                          child: const Text("Trending"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text("Top Rated"),
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
                height: currentWidth < 370 ? 400.5 : 428.5,
                child: TabBarView(controller: _tabController, children: [
                  FutureBuilder(
                      future: getMovies.getTrending(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(120.8),
                            child: const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ); // Tampilkan loading spinner saat proses fetch data masih berjalan
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
                                              name: getMovies
                                                  .listTrending[index].name,
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
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imageUrl +
                                                            getMovies
                                                                .listTrending[
                                                                    index]
                                                                .poster_path),
                                                fit: BoxFit.fill)),
                                      ),
                                    )),
                          ),
                        );
                      }),
                  FutureBuilder(
                      future: getMovies.getTopRatedList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(120.8),
                            child: const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ); // Tampilkan loading spinner saat proses fetch data masih berjalan
                        }
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        if (!snapshot.hasData) {
                          return Text("Error: Ther is no data");
                        }
                        // return Text(getMovies.listMovies.length.toString());
                        return Container(
                          height: currentWidth < 370 ? 400.5 : 428.5,
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
                                              name: getMovies
                                                  .listTopRatedMovies[index]
                                                  .name,
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
                      future: getMovies.getPopularMovieList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(120.8),
                            child: const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          );
                          // Tampilkan loading spinner saat proses fetch data masih berjalan
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
                                              id: getMovies
                                                  .listPopular[index].id,
                                              poster_path: getMovies
                                                  .listPopular[index]
                                                  .poster_path,
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
                                              name: getMovies
                                                  .listPopular[index].name,
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
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imageUrl +
                                                            getMovies
                                                                .listPopular[
                                                                    index]
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
              Container(
                child: FutureBuilder(
                    future: getMovies.getTopRatedList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: const EdgeInsets.all(120.8),
                          child: const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        );
                        // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return Text("Error: Ther is no data");
                      }
                      return Padding(
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
                      );
                    }),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Text(
                  "Upcoming Movies",
                  style: GoogleFonts.notoSerif(
                    fontSize: currentWidth < 370 ? 26.6 : 33.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                height: currentWidth < 370 ? 188.8 : 208.8,
                child: FutureBuilder(
                    future: getMovies.getUpcomingMovieList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: const EdgeInsets.all(120.8),
                          child: const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        ); // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return const Text("Error: Ther is no data");
                      }
                      return ListView.builder(
                          itemCount: getMovies.listUpcoming.length,
                          padding: const EdgeInsets.only(left: 28.8, right: 12),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SelectedMovieScreen(
                                      id: getMovies.listUpcoming[index].id,
                                      poster_path: getMovies
                                          .listUpcoming[index].poster_path,
                                      backdrop_path: getMovies
                                          .listUpcoming[index].backdrop_path,
                                      title:
                                          getMovies.listUpcoming[index].title,
                                      overview: getMovies
                                          .listUpcoming[index].overview,
                                      vote_average: getMovies
                                          .listUpcoming[index].vote_average,
                                      release_date: getMovies
                                          .listUpcoming[index].release_date,
                                      name: getMovies.listUpcoming[index].name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: currentWidth < 370 ? 188.8 : 208.8,
                                width: 118,
                                margin:
                                    const EdgeInsets.only(right: 10.8, top: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.6),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            imageUrl +
                                                getMovies.listUpcoming[index]
                                                    .poster_path),
                                        fit: BoxFit.fill)),
                              ),
                            );
                          });
                    }),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Text(
                  "Now Playing",
                  style: GoogleFonts.notoSerif(
                    fontSize: currentWidth < 370 ? 26.6 : 33.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                height: currentWidth < 370 ? 188.8 : 208.8,
                child: FutureBuilder(
                    future: getMovies.getNowPlaying(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: const EdgeInsets.all(120.8),
                          child: const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        ); // Tampilkan loading spinner saat proses fetch data masih berjalan
                      }
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return const Text("Error: Ther is no data");
                      }

                      return ListView.builder(
                          itemCount: getMovies.listNowPlaying.length,
                          padding: const EdgeInsets.only(left: 28.8, right: 12),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SelectedMovieScreen(
                                      id: getMovies.listNowPlaying[index].id,
                                      poster_path: getMovies
                                          .listNowPlaying[index].poster_path,
                                      backdrop_path: getMovies
                                          .listNowPlaying[index].backdrop_path,
                                      title:
                                          getMovies.listNowPlaying[index].title,
                                      overview: getMovies
                                          .listNowPlaying[index].overview,
                                      vote_average: getMovies
                                          .listNowPlaying[index].vote_average,
                                      release_date: getMovies
                                          .listNowPlaying[index].release_date,
                                      name:
                                          getMovies.listNowPlaying[index].name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: currentWidth < 370 ? 188.8 : 208.8,
                                width: 118,
                                margin:
                                    const EdgeInsets.only(right: 10.8, top: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.6),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            imageUrl +
                                                getMovies.listNowPlaying[index]
                                                    .poster_path),
                                        fit: BoxFit.fill)),
                              ),
                            );
                          });
                    }),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Text(
                  "Popular TV Show",
                  style: GoogleFonts.notoSerif(
                    fontSize: currentWidth < 370 ? 26.6 : 33.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                height: currentWidth < 370 ? 188.8 : 208.8,
                child: FutureBuilder(
                  future: getMovies.getTvPopular(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        padding: const EdgeInsets.all(120.8),
                        child: const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ); // Tampilkan loading spinner saat proses fetch data masih berjalan
                    }
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    if (!snapshot.hasData) {
                      return const Text("Error: Ther is no data");
                    }
                    return ListView.builder(
                        itemCount: getMovies.listTvPopular.length,
                        padding: const EdgeInsets.only(left: 28.8, right: 12),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectedMovieScreen(
                                    id: getMovies.listTvPopular[index].id,
                                    poster_path: getMovies
                                        .listTvPopular[index].poster_path,
                                    backdrop_path: getMovies
                                        .listTvPopular[index].backdrop_path,
                                    title: getMovies.listTvPopular[index].title,
                                    overview:
                                        getMovies.listTvPopular[index].overview,
                                    vote_average: getMovies
                                        .listTvPopular[index].vote_average,
                                    release_date: getMovies
                                        .listTvPopular[index].release_date,
                                    name: getMovies.listTvPopular[index].name,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: currentWidth < 370 ? 188.8 : 208.8,
                              width: 118,
                              margin:
                                  const EdgeInsets.only(right: 10.8, top: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.6),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          imageUrl +
                                              getMovies.listTvPopular[index]
                                                  .poster_path),
                                      fit: BoxFit.fill)),
                            ),
                          );
                        });
                  },
                ),
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
