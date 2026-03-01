import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFeedProvider extends ChangeNotifier {
  VideoPlayerController? _activeController;
  int? _activeIndex;

  int? get activeIndex => _activeIndex;

  void playVideo({
    required int index,
    required VideoPlayerController controller,
  }) {
    if (_activeController != null && _activeIndex != index) {
      _activeController!.pause();
    }

    _activeController = controller;
    _activeIndex = index;

    controller.play();
    notifyListeners();
  }

  void stopIfActive(int index) {
    if (_activeIndex == index) {
      _activeController?.pause();
      _activeIndex = null;
      notifyListeners();
    }
  }
}