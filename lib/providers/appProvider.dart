import 'package:flutter/cupertino.dart';

import '../models/rdv_model.dart';

class AppProvider with ChangeNotifier {
  List<String> _mesRdv = [];
  int _count = 0;

  int get count => _count;

  set count(int count) {
    _count = count;
    notifyListeners();
  }

  List<String> get mesRdv => _mesRdv;

  void addRdv(String newRdv) {
    _mesRdv.add(newRdv);
    notifyListeners();
  }

  // set mesRdv(List<String> mesRdv) {
  //   _mesRdv = mesRdv;
  //   notifyListeners();
  // }
}
