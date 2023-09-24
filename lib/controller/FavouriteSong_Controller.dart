import 'package:flutter/cupertino.dart';
import 'package:media_player/utils/Audio_Songs.dart';
import 'package:media_player/utils/Movie_Modal.dart';

class FavouriteController extends ChangeNotifier {
  static List<String> allFavourite = [];
  static bool isTappaed = false;
  List<Movie_Modal> allSongs = [];

  setIsTapped() {
    isTappaed = !isTappaed;
    notifyListeners();
  }

  get getisTapped {
    return isTappaed;
  }

  addFavouriteSong({required String title}) {
    if (allFavourite.contains(title)) {
      allFavourite.remove(title);
      Audio_Songs.forEach(
        (e) {
          if (e['title'] == title) {
            Movie_Modal mm = Movie_Modal.fromMap(data: e);
            allSongs.remove(mm);
          }
        },
      );
    } else {
      allFavourite.add(title);
      // print("AllSongtitle : ${allFavourite}");
      Audio_Songs.forEach(
        (e) {
          // print("Condition entered");
          if (e['title'] == title) {
            // print("Condition true");
            Movie_Modal mm = Movie_Modal.fromMap(data: e);
            allSongs.add(mm);
            print("Map Data : ${e['movie']}");
          }
        },
      );
    }
    notifyListeners();
  }

  get getFavouriteSong {
    return allFavourite;
  }

  bool checkFavouriteSong({required String title}) {
    if (allFavourite.contains(title)) {
      return true;
    } else {
      return false;
    }
  }
}
