import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';

import '../utils/Audio_Songs.dart';
import '../utils/Movie_Modal.dart';

class Carousel_Controller extends ChangeNotifier {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  List<Movie_Modal> _allSongs = [];

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
}
