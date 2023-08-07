import 'package:flutter/material.dart';
import 'package:icream/screens/icream_cart/icream_cart.dart';
import 'package:icream/screens/icream_category/icream_category.dart';
import 'package:icream/screens/icream_home/icream_home.dart';
import 'package:icream/screens/icream_profile/icream_profile.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 0;

  setNavIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  selectBottomNavItems(index) {
    switch (index) {
      case 0:
        return const ICreamHome();
      case 1:
        return const ICreamCategory();
      case 2:
        return const ICreamCart();
      case 3:
        return const ICreamProfile();
      default:
        return Container();
    }
  }
}
