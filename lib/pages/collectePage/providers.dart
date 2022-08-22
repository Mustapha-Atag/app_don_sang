import 'package:flutter/foundation.dart';

import '../../models/collecte_model.dart';

class PanelProvider with ChangeNotifier {
  int _panelContent = 0;
  bool _isPanelOpen = false;
  Map<String, dynamic> _selectedCollecte = {};

  Map<String, dynamic> get selectedCollecte => _selectedCollecte;

  set selectedCollecte(Map<String, dynamic> selectedCollecte) {
    _selectedCollecte = selectedCollecte;
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
