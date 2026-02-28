import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String userName = "Maria";
  int selectedIndex = 0;

  final List<String> categories = [
    "All Categories",
    "Trending",
    "Explore",
  ];

  void selectCategory(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}