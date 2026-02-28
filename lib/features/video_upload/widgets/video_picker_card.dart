import 'package:flutter/material.dart';
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
          border: Border.all(color: Colors.white24),
          color: Colors.black26,
        ),
        child: provider.videoFile == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, color: Colors.white70, size: 28),
                  SizedBox(height: 10),
                  Text(
                    "Select a video from Gallery",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              )
            : const Center(
                child: Icon(
                  Icons.video_library,
                  color: Colors.red,
                  size: 40,
                ),
              ),
      ),
    );
  }
}