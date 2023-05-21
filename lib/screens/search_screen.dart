import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                      const EdgeInsets.only(top: 38.8, left: 28.8, right: 28.8),
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
                  child: const TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 60, 60, 60),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(
                            top: 0, left: 8.2, bottom: 0, right: 8.2),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 161, 160, 160)),
                        hintText: "Search anything..."),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
