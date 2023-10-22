import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> _favourites = [];
  List<String> get favourites => _favourites;

  void addFavourites(String movie) {
    final isExist = _favourites.contains(movie);
    if (isExist) {
      _favourites.remove(movie);
    } else {
      _favourites.add(movie);
    }
    notifyListeners();
  }

  bool isFavourite(String movie) {
    final isExist = _favourites.contains(movie);
    return isExist;
  }

  void clearFavourites() {
    _favourites = [];
    notifyListeners();
  }
}
