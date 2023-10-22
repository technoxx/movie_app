// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/movieList.dart';
import 'package:movie_app/widgets/search.dart';
import 'package:movie_app/widgets/top_rated.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  List topratedmovies = [];
  final String apikey = "95250ca9960f616956cbddd73c7783aa";
  final readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NTI1MGNhOTk2MGY2MTY5NTZjYmRkZDczYzc3ODNhYSIsInN1YiI6IjY1MjQwOThmNzQ1MDdkMDBjNTdkNzFhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oSWqqnMtH5nW2WsA420bANAovghG2gv9n4EdcPsoQiM";

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();

    setState(() {
      topratedmovies = topratedresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobilebackgroundcolor,
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: maincolor,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: mobilebackgroundcolor,
                  radius: 60,
                  child: Icon(
                    CupertinoIcons.person,
                    size: 50,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                leading: Icon(CupertinoIcons.person),
                title: Text(
                  'Edit Profile',
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                leading: Icon(CupertinoIcons.settings_solid),
                title: Text('Settings'),
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.arrow_down_right),
              title: Text('Sign Out'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: ModifiedText(
          text: "Search",
          size: 20,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchMovie(movies: topratedmovies),
                );
              },
              icon: const Icon(CupertinoIcons.search)),
        ],
      ),
      body: ListView(
        children: [
          TopRatedMovies(toprated: topratedmovies),
        ],
      ),
    );
  }
}

class SearchMovie extends SearchDelegate {
  List movies;
  SearchMovie({
    required this.movies,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(CupertinoIcons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(CupertinoIcons.arrow_left),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MovieModel> allmovies = [];
    for (var index = 0; index < movies.length; index++) {
      allmovies.add(MovieModel(
          name: movies[index]['title'],
          posterUrl: movies[index]['poster_path'],
          rating: movies[index]['vote_average'].toString(),
          releaseDate: movies[index]['release_date']));
    }
    return SearchFunc(
      allmovies: allmovies,
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MovieModel> allmovies = [];
    for (var index = 0; index < movies.length; index++) {
      allmovies.add(MovieModel(
          name: movies[index]['title'],
          description: movies[index]['overview'],
          bannerUrl: movies[index]['backdrop_path'],
          posterUrl: movies[index]['poster_path'],
          rating: movies[index]['vote_average'].toString(),
          releaseDate: movies[index]['release_date']));
    }
    return SearchFunc(
      allmovies: allmovies,
      query: query,
    );
  }
}
