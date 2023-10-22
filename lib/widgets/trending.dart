import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';

class TrendingMovies extends StatelessWidget {
  final List popularmovies;
  const TrendingMovies({super.key, required this.popularmovies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: "Trending Movies",
            size: 25,
          ),
          Container(
            height: 300,
            child: ListView.builder(
                itemCount: popularmovies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Description(
                                    name: popularmovies[index]['title'],
                                    bannerUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            popularmovies[index]
                                                ['backdrop_path'],
                                    posterUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            popularmovies[index]['poster_path'],
                                    description: popularmovies[index]
                                        ['overview'],
                                    rating: popularmovies[index]['vote_average']
                                        .toString(),
                                    releaseDate: popularmovies[index]
                                        ['release_date'],
                                  ))));
                    },
                    child: popularmovies[index]['title'] != null
                        ? Container(
                            width: 140,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "https://image.tmdb.org/t/p/w500" +
                                        popularmovies[index]['poster_path'],
                                  ))),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: 300,
                                        child: ModifiedText(
                                          text: popularmovies[index]['title'] ??
                                              ModifiedText(
                                                text: "Loading...",
                                                size: 20,
                                              ),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    ModifiedText(
                                      text: "⭐ " +
                                          popularmovies[index]['vote_average']
                                              .toString(),
                                      size: 15,
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ModifiedText(
                                    text: popularmovies[index]['release_date'],
                                    size: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
