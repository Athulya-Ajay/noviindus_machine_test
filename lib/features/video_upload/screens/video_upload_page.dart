import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/video_upload/widgets/category_card.dart';
import 'package:provider/provider.dart';
import '../provider/video_upload_provider.dart';
import '../widgets/video_picker_card.dart';
import '../widgets/thumbnail_picker_card.dart';

class VideoUploadPage extends StatelessWidget {
  const VideoUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoUploadProvider(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0E0E0E),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0E0E0E),
          elevation: 0,
          leading: const BackButton(color: Colors.white),
          title: const Text("Add Feeds", style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton(
                onPressed: () {
                  // API upload later
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Share Post",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoPickerCard(),
              const SizedBox(height: 20),

              const ThumbnailPickerCard(),
              const SizedBox(height: 20),
              const Text(
                "Add Description",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),

              Consumer<VideoUploadProvider>(
                builder: (context, provider, _) {
                  return TextField(
                    controller: provider.descriptionController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Write something about this video...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              const CategoryCard(),
            ],
          ),
        ),
      ),
    );
  }
}
