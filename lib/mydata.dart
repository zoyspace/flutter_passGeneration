import 'package:flutter/foundation.dart';

class MyData with ChangeNotifier {
  double _value = 0.5;
  // getter
  double get value => _value;
  // setter
  set value(double value) {
    _value = value;
    notifyListeners();
  }
}
