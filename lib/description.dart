// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/favourite_provider.dart';
import 'package:provider/provider.dart';

class Description extends StatelessWidget {
  String name, description, bannerUrl, posterUrl, rating, releaseDate;
  Description({
    super.key,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.rating,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ModifiedText(
                          text: "Rating - " + rating + " ⭐",
                          size: 15,
                        ),
                      )),
                  Positioned(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(CupertinoIcons.xmark),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                ModifiedText(
                  text: name ?? 'Loading...',
                  size: 25,
                ),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                IconButton(
                    onPressed: () {
                      provider.addFavourites(name);
                    },
                    icon: provider.isFavourite(name)
                        ? Icon(
                            CupertinoIcons.heart_fill,
                            color: maincolor,
                            size: 30,
                          )
                        : Icon(
                            CupertinoIcons.heart,
                            size: 30,
                          )),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: ModifiedText(
                text: "Released on - " + releaseDate,
                size: 15,
                color: maincolor,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 200,
                  child: Image.network(posterUrl),
                ),
                Expanded(
                  child: SizedBox(
                    height: 140,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          description,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
