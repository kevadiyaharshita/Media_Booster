import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:media_player/components/Audio_Page.dart';
import 'package:media_player/components/Home_Music.dart';
import 'package:media_player/components/Favourite.dart';
import 'package:media_player/components/Video_Page.dart';

import '../components/CurrentPlaySongs.dart';

class Page_Controller extends ChangeNotifier {
  int _index = 0;

  Page_Controller() {
    log("hello.......................................................");
  }
  List allPages = [
    HomeMusic(),
    AudioPage(),
    CurrentPlaySongs(),
    VideoPage(),
    SettingPage(),
  ];

  changePage(int index) {
    _index = index;
    notifyListeners();
  }

  get getIndex {
    return _index;
  }
}
