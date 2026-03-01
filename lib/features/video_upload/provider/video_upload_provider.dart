import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import '../service/video_upload_service.dart';

class VideoUploadProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final VideoUploadService _service = VideoUploadService();

  File? videoFile;
  File? thumbnailFile;

  final TextEditingController descriptionController = TextEditingController();

  bool isUploading = false;

  final List<Map<String, String>> categories = [
    {"id": "1", "title": "Physics"},
    {"id": "2", "title": "Artificial Intelligence"},
    {"id": "3", "title": "Mathematics"},
    {"id": "4", "title": "Chemistry"},
    {"id": "5", "title": "Micro Biology"},
  ];

  List<String> selectedCategoryIds = [];

  void toggleCategory(String id) {
    selectedCategoryIds.contains(id)
        ? selectedCategoryIds.remove(id)
        : selectedCategoryIds.add(id);
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

  bool get isValid =>
      videoFile != null &&
      thumbnailFile != null &&
      descriptionController.text.isNotEmpty &&
      selectedCategoryIds.isNotEmpty;

  Future<bool> uploadFeed({required BuildContext context}) async {
    if (!isValid) return false;

    isUploading = true;
    notifyListeners();

    final success = await _service.uploadFeed(
      video: videoFile!,
      image: thumbnailFile!,
      description: descriptionController.text,
      category: selectedCategoryIds.join(","),
    );

    isUploading = false;
    notifyListeners();

    if (success) {
  clearAll();

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Feed uploaded successfully"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Feed upload failed,please try again"),
          backgroundColor: AppColors.primaryRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    return success;
  }

  void clearAll() {
    videoFile = null;
    thumbnailFile = null;
    descriptionController.clear();
    selectedCategoryIds.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
