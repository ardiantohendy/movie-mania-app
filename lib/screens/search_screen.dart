import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mania_app/models/model.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../repository/repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final String imageUrl = "https://image.tmdb.org/t/p/w500";
TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
    logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

List<MoviesClass> current_list = [];
List<MoviesClass> display_list = List.from(current_list);
String query = "";

loadSearch(query) async {
  Map loadSearch = await tmdbWithCustomLogs.v3.search.queryMulti(query);

  final thisData = loadSearch["results"];

  for (int i = 0; i < thisData.length; i++) {
    MoviesClass moviesClass = MoviesClass(
        id: thisData[i]["id"],
        poster_path: thisData[i]["poster_path"],
        backdrop_path: thisData[i]["backdrop_path"],
        title: thisData[i]["title"] ?? thisData[i]["title"],
        overview: thisData[i]["overview"],
        vote_average: thisData[i]["vote_average"].toDouble(),
        release_date:
            thisData[i]["release_date"] ?? thisData[i]["first_air_date"],
        genre_ids: thisData[i]["genre_ids"]);

    current_list.add(moviesClass);
  }

  return current_list;
}

class _SearchScreenState extends State<SearchScreen> {
  void updateList(String value) {
    setState(() {
      display_list = current_list
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
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
                  onChanged: (query) => updateList(query),
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
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    hintText: "Search anything...",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Expanded(
                child: FutureBuilder(
                  future: loadSearch(query),
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
                    return Expanded(
                      child: ListView.builder(
                        itemCount: display_list.length,
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Text(
                            display_list[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            display_list[index].release_date,
                            style: const TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            display_list[index].vote_average.toString(),
                            style: const TextStyle(color: Colors.amber),
                          ),
                          leading: Image.network(
                              imageUrl + display_list[index].poster_path),
                        ),
                      ),
                    );
                  },
                ),
              )
              // FutureBuilder(builder: )
            ],
          ),
        ),
      ),
    );
  }
}
