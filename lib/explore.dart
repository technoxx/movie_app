import 'package:flutter/material.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/widgets/latest.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Explore extends StatefulWidget {
  Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  List latestmovies = [];
  List popularmovies = [];
  final String apikey = "95250ca9960f616956cbddd73c7783aa";
  final readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NTI1MGNhOTk2MGY2MTY5NTZjYmRkZDczYzc3ODNhYSIsInN1YiI6IjY1MjQwOThmNzQ1MDdkMDBjNTdkNzFhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oSWqqnMtH5nW2WsA420bANAovghG2gv9n4EdcPsoQiM";

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map popularresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map latestresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      popularmovies = popularresult['results'];
      latestmovies = latestresult['results'];
    });
    print(latestmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobilebackgroundcolor,
      body: SafeArea(
          child: ListView(
        children: [
          LatestMovies(popularmovies: latestmovies),
          TrendingMovies(popularmovies: popularmovies),
        ],
      )),
    );
  }
}
