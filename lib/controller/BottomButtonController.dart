import 'package:flutter/cupertino.dart';

class BottomButtonController extends ChangeNotifier {
  bool _isCheck = false;

  setIsCheck() {
    if (!_isCheck) {
      _isCheck = true;
      notifyListeners();
    }
  }

  get getISCheck {
    return _isCheck;
  }
}
