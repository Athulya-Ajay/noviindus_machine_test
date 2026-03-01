import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoUploadProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? videoFile;
  File? thumbnailFile;

  final TextEditingController descriptionController = TextEditingController();

  final List<String> categories = [
    "Physics",
    "Artificial Intelligence",
    "Mathematics",
    "Chemistry",
    "Micro Biology",
  ];

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  void selectCategory(int index) {
    _selectedCategory = categories[index];
    notifyListeners();
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      videoFile = File(video.path);
      notifyListeners();
    }
  }

  Future<void> pickThumbnail() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      thumbnailFile = File(image.path);
      notifyListeners();
    }
  }

  // void toggleCategory(String category) {
  //   selectedCategories.contains(category)
  //       ? selectedCategories.remove(category)
  //       : selectedCategories.add(category);
  //   notifyListeners();
  // }

  void clearAll() {
    videoFile = null;
    thumbnailFile = null;
    descriptionController.clear();
    _selectedCategory = null;
    notifyListeners();
  }
}