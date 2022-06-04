import 'package:flutter/cupertino.dart';
import 'package:janajaldoot/ui/screens/home_screen/home_screen.dart';

import '../ui/screens/my_trip_screen/my_trip_screen.dart';

class UiController extends ChangeNotifier {
  int _navbarIndex = 1;
  Widget mainWidget = HomeScreen();
  int get navbarIndex => _navbarIndex;
  changeNavbarIndex(int index) {
    _navbarIndex = index;
    switch (_navbarIndex) {
      case 0:
        mainWidget = MyTripScreen();
        break;
      case 1:
        mainWidget = HomeScreen();
        break;
      case 2:
        mainWidget = Container();
        break;
      case 3:
        mainWidget = Container();
        break;
      case 4:
        mainWidget = Container();
        break;
      default:
        mainWidget = Container();
        break;
    }
    notifyListeners();
  }
}
