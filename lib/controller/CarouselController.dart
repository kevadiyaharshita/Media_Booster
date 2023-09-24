import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:provider/provider.dart';

import '../utils/Audio_Songs.dart';
import '../utils/Movie_Modal.dart';

class Carousel_Controller extends ChangeNotifier {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  List<Movie_Modal> _allSongs = [];
  String selectedMovieName = '';
  List<Movie_Modal> _allFavouriteSong = [];
  int _favCurrent = 0;

  setSelectedMovieName({required String movieName}) {
    selectedMovieName = movieName;
    notifyListeners();
  }

  String get getSelectedMovieName {
    return selectedMovieName;
  }

  setCurrentIndex(int index) {
    _current = index;
    notifyListeners();
  }

  get getCurrentIndex {
    return _current;
  }

  get getController {
    return _carouselController;
  }

  List get getAllSongs {
    return _allSongs;
  }

  setAllSong({required String movie}) {
    // print("Called..");

    _allSongs.clear();
    Audio_Songs.map((e) {
      if (e['movie'] == movie) {
        Movie_Modal m = Movie_Modal.fromMap(data: e);
        _allSongs.add(m);
      }
    }).toList();

    // notifyListeners();
  }

  String setSinger({required List<String> name}) {
    String s_name = "";
    name.forEach(
      (element) {
        s_name = s_name + element + ', ';
      },
    );
    return s_name;
  }

  setAllFavouriteSong() {
    _allSongs.clear();
    Audio_Songs.map(
      (e) {
        if (FavouriteController.allFavourite.contains(e['title'])) {
          Movie_Modal m = Movie_Modal.fromMap(data: e);
          _allFavouriteSong.add(m);
        }
      },
    ).toList();
    // FavouriteController.isTappaed = false;
  }

  get getallFavouriteSong {
    return _allFavouriteSong;
  }

  setfavCurrent({required int index}) {
    _favCurrent = index;
    notifyListeners();
  }

  get getfavCurrent {
    return _favCurrent;
  }
}
