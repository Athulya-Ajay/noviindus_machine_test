import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../provider/video_upload_provider.dart';

class VideoPickerCard extends StatelessWidget {
  const VideoPickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoUploadProvider>();

    return GestureDetector(
      onTap: provider.pickVideo,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkGrey),
          color: AppColors.bgBlack,
        ),
        child: provider.videoFile == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, color: AppColors.darkGrey, size: 28),
                  SizedBox(height: 10),
                  Text(
                    "Select a video from Gallery",
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                ],
              )
            : const Center(
                child: Icon(
                  Icons.video_library,
                  color: AppColors.primaryRed,
                  size: 40,
                ),
              ),
      ),
    );
  }
}