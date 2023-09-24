import 'dart:developer';

import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime date = DateTime.now();

  List<String> greetings = [
    'Good morning',
    'Good afternoon',
    'Good evening',
    'Good night'
  ];
  int? _index = 0;

  DateTimeController() {
    print(".....................");
    checkTime();
  }

  checkTime() {
    print("...........Calledd..........");
    date = DateTime.now();
    if (date.hour >= 4 && date.hour < 12) {
      _index = 0;
      notifyListeners();
    } else if (date.hour >= 12 && date.hour < 18) {
      _index = 1;
      notifyListeners();
    } else if (date.hour >= 18 && date.hour < 22) {
      _index = 2;
      notifyListeners();
    } else if ((date.hour >= 22 && date.hour < 24) ||
        (date.hour > 0 && date.hour < 4)) {
      _index = 3;
      notifyListeners();
    } else {
      log("Not Matchedd.....${date.hour}");
    }
    // checkTime();
    Future.delayed(
      Duration(minutes: 10),
      () => checkTime(),
    );
  }

  get getIndex {
    return _index;
  }
}
