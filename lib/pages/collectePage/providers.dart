import 'package:flutter/foundation.dart';

import '../../models/collecte_model.dart';

class PanelProvider with ChangeNotifier {
  int _panelContent = 0;
  bool _isPanelOpen = false;
  Centre _selectdCenter = centres[0];

  Centre get selectdCenter => _selectdCenter;

  set selectdCenter(Centre selectdCenter) {
    _selectdCenter = selectdCenter;
    notifyListeners();
  }

  bool get isPanelOpen => _isPanelOpen;

  set isPanelOpen(bool isPanelOpen) {
    _isPanelOpen = isPanelOpen;
    notifyListeners();
  }

  int get panelContent => _panelContent;

  set panelContent(int panelContent) {
    _panelContent = panelContent;
    notifyListeners();
  }
}
