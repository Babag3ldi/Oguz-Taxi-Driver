import 'package:flutter/cupertino.dart';

class IndexProvider extends ChangeNotifier {
  int selectIndex = -1;
  void changeIndex(int x) {
    selectIndex = x;
    notifyListeners();
  }

  double sizeHeight(double sizeHeight) {
    switch (selectIndex) {
      case -1:
      case 0:
        return sizeHeight * 60;
      case 1:
        return sizeHeight * 60;
      case 2:
        return sizeHeight * 60;
      case 3:
        return 230;
      case 4:
        return 300;
      case 5:
        return 280;
      case 6:
        return 280;
      default:
        return sizeHeight * 60;
    }
  }

  backBottomSheet() {
    print("index=$selectIndex");
    switch (selectIndex) {
      case 0:
        selectIndex = -1;
        break;
      case 1:
      case 2:
      case 3:
      case 6:
        selectIndex = 0;
        break;
    }
    notifyListeners();
  }

  List<int> workingTarifs = [];

  addTarif(int x) {
    if (workingTarifs.contains(x)) {
      workingTarifs.remove(x);
    } else {
      workingTarifs.add(x);
    }
    notifyListeners();
  }

  removeTarif(int x) {
    workingTarifs.remove(x);
    notifyListeners();
  }
}
