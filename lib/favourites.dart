import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    final movies = provider.favourites;
    return Scaffold(
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              tileColor: maincolor,
              title: ModifiedText(
                text: movie,
                size: 20,
              ),
              trailing: IconButton(
                  onPressed: () {
                    provider.addFavourites(movie);
                  },
                  icon: provider.isFavourite(movie)
                      ? Icon(CupertinoIcons.heart_fill)
                      : Icon(CupertinoIcons.heart)),
            ),
          );
        },
      ),
    );
  }
}
