import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  TopRatedMovies({super.key, required this.toprated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: "Top Rated Movies",
            size: 25,
            //color: maincolor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: toprated.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Description(
                                    name: toprated[index]['title'],
                                    bannerUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            toprated[index]['backdrop_path'],
                                    posterUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            toprated[index]['poster_path'],
                                    description: toprated[index]['overview'],
                                    rating: toprated[index]['vote_average']
                                        .toString(),
                                    releaseDate: toprated[index]
                                        ['release_date'],
                                  ))));
                    },
                    child: toprated[index]['title'] != null
                        ? Container(
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 10,
                                  color: maincolor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500" +
                                          toprated[index]['poster_path'],
                                    ))),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 300,
                                          child: ModifiedText(
                                            text: toprated[index]['title'] ??
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
                                            toprated[index]['vote_average']
                                                .toString(),
                                        size: 15,
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: ModifiedText(
                                      text: toprated[index]['release_date'],
                                      size: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
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
