import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 48.8, left: 28.8, right: 28.8),
                child: Text(
                  "MovieMania",
                  style: GoogleFonts.lato(
                    fontSize: 56.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //desc app

            Align(
              alignment: Alignment.center,
              child: Padding(
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
            ),

            //custom tab bar

            Container(
              height: 40,
              margin: EdgeInsets.only(top: 28.8, left: 14.4),
              child: DefaultTabController(
                length: 5,
                child: TabBar(
                  labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                  indicatorPadding: EdgeInsets.only(left: 14.4, right: 14.4),
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
                        child: const Text("Now Playing"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Upcoming"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Popular Movies"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Popular Series"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: const Text("Trending Movies"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
