import 'package:flutter/foundation.dart';

class FirstProvider with ChangeNotifier{
  int _index = 0;
  int get currentViewIndex => _index;
//TODO: Change mocked data to real logic
  void changeView(int index) {
    _index = index;
    notifyListeners();
  }

}