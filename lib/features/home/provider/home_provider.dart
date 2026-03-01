import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/home/model/home_model.dart';
import 'package:noviindus_test_app/features/home/service/home_service.dart';

class HomeProvider extends ChangeNotifier {
  String userName = "Maria";
  int selectedIndex = 0;

  final HomeService _homeService = HomeService();

  HomeModel _homeDetails = HomeModel(results: []);
  HomeModel get homeDetails => _homeDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<String> categories = [];

  void selectCategory(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> getHomeDetails() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _homeService.fetchHomeDetails();
      _homeDetails = response;

      categories = (response.categoryDict ?? [])
          .map((category) => category.title ?? "")
          .toList();
    } catch (e) {
      _error = e.toString();
      debugPrint("HomeProvider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
