import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/video_upload_provider.dart';

class ThumbnailPickerCard extends StatelessWidget {
  const ThumbnailPickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoUploadProvider>();

    return GestureDetector(
      onTap: provider.pickThumbnail,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24),
          color: Colors.black26,
        ),
        child: provider.thumbnailFile == null
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, color: Colors.white70),
                  SizedBox(width: 10),
                  Text(
                    "Add a Thumbnail",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  provider.thumbnailFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
      ),
    );
  }
}