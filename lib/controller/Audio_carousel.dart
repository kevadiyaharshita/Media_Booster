import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';

class AudioCarousel extends ChangeNotifier {
  final CarouselController _audioCarouselController = CarouselController();

  int _crntIndex = 0;

  get getController {
    return _audioCarouselController;
  }

  setCurrentIndex(int index) {
    _crntIndex = index;
    notifyListeners();
  }

  get getCurrentIndex {
    return _crntIndex;
  }
}
