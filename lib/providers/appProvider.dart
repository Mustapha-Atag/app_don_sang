import 'package:flutter/cupertino.dart';

import '../models/rdv_model.dart';

class AppProvider with ChangeNotifier {
  List<Rdv> _mesRdv = [];
  int _count = 0;

  int get count => _count;

  set count(int count) {
    _count = count;
    notifyListeners();
  }

  List<Rdv> get mesRdv => _mesRdv;

  void add(Rdv newRdv) {
    _mesRdv.add(newRdv);
    notifyListeners();
  }

  set mesRdv(List<Rdv> mesRdv) {
    _mesRdv = mesRdv;
    notifyListeners();
  }
}
