import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/text.dart';

class LatestMovies extends StatelessWidget {
  final List popularmovies;
  const LatestMovies({super.key, required this.popularmovies});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: ModifiedText(
              text: "Popular TV Shows",
              size: 25,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 190,
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
                                    name: popularmovies[index]['original_name'],
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
                                        ['first_air_date'],
                                  ))));
                    },
                    child: popularmovies[index]['original_name'] != null
                        ? Container(
                            width: 250,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: 250,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500" +
                                          popularmovies[index]['backdrop_path'],
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                                Container(
                                  child: ModifiedText(
                                    text:
                                        popularmovies[index]['original_name'] ??
                                            ModifiedText(
                                              text: "Loading...",
                                              size: 20,
                                            ),
                                    size: 20,
                                  ),
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
