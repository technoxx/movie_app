// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_app/description.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/movieList.dart';

class SearchFunc extends StatefulWidget {
  List<MovieModel> allmovies;
  final String query;
  SearchFunc({Key? key, required this.allmovies, required this.query})
      : super(key: key);

  @override
  State<SearchFunc> createState() => _SearchFuncState();
}

class _SearchFuncState extends State<SearchFunc> {
  late List<MovieModel> moviesList = List.from(widget.allmovies);
  void updateList(String value) {
    setState(() {
      moviesList = widget.allmovies
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    updateList(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    updateList(widget.query);
    return Container(
      color: mobilebackgroundcolor,
      child: moviesList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : moviesList!.length == 0
              ? Center(
                  child: Text("Oops! couldn't find the movie"),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: moviesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Description(
                                        name: moviesList[index].name,
                                        bannerUrl:
                                            "https://image.tmdb.org/t/p/w500/" +
                                                moviesList[index].bannerUrl,
                                        posterUrl:
                                            "https://image.tmdb.org/t/p/w500/" +
                                                moviesList[index].posterUrl,
                                        description:
                                            moviesList[index].description,
                                        rating:
                                            moviesList[index].rating.toString(),
                                        releaseDate:
                                            moviesList[index].releaseDate,
                                      ))));
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 70,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: moviesList[index].posterUrl == null
                                        ? Container()
                                        : FadeInImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500/' +
                                                    moviesList[index]
                                                        .posterUrl),
                                            fit: BoxFit.cover,
                                            placeholder: AssetImage(
                                                'assets/images/loading.gif'),
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          moviesList[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            ModifiedText(
                                              text:
                                                  moviesList[index].releaseDate,
                                            ),
                                            const Flexible(
                                                fit: FlexFit.tight,
                                                child: SizedBox()),
                                            const Icon(Icons.star,
                                                color: Colors.yellow),
                                            Text(moviesList[index]
                                                .rating
                                                .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Divider(
                                color: maincolor,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
