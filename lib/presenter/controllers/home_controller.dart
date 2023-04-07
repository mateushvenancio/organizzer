import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final pageController = PageController();
  int bottomBarIndex = 0;

  setBottomBarIndex(int value) {
    bottomBarIndex = value;
    _animateTo(value);
    notifyListeners();
  }

  _animateTo(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }
}
