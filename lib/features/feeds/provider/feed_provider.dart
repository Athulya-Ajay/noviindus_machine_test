import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/feeds/model/feed_model.dart';
import 'package:noviindus_test_app/features/feeds/service/feed_service.dart';

class FeedProvider extends ChangeNotifier {
  final FeedService _feedService = FeedService();

  FeedModel _feedModel = FeedModel();
  FeedModel get feedModel => _feedModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchMyFeed() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _feedService.fetchMyFeed();
      _feedModel = response;
    } catch (e) {
      _error = e.toString();
      debugPrint("FeedProvider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}