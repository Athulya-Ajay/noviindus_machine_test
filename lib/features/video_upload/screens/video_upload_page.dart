import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../provider/video_upload_provider.dart';
import '../widgets/video_picker_card.dart';
import '../widgets/thumbnail_picker_card.dart';
import '../widgets/category_card.dart';

class VideoUploadPage extends StatelessWidget {
  const VideoUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoUploadProvider(),
      child: Scaffold(
        backgroundColor: AppColors.bgBlack,
        appBar: AppBar(
          backgroundColor: AppColors.bgBlack,
          elevation: 0,
          title: const Text(
            "Add Feeds",
            style: TextStyle(color: AppColors.primarywhite),
          ),
          leading: const BackButton(color: AppColors.primarywhite),
          actions: [
            Consumer<VideoUploadProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.isValid
                          ? AppColors.primaryRed
                          : AppColors.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: provider.isUploading
                        ? null
                        : () async {
                            final success =
                                await provider.uploadFeed(context: context);
                            if (success && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                    child: provider.isUploading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Share Post",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                  style: TextStyle(color: AppColors.primarywhite),
                ),
                const SizedBox(height: 8),

                Consumer<VideoUploadProvider>(
                  builder: (context, provider, _) {
                    return TextField(
                      controller: provider.descriptionController,
                      maxLines: 4,
                      style:
                          const TextStyle(color: AppColors.primarywhite),
                      decoration: InputDecoration(
                        hintText:
                            "Write something about this video...",
                        hintStyle:
                            const TextStyle(color: AppColors.lightGrey),
                        filled: true,
                        fillColor: AppColors.bgBlack,
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
      ),
    );
  }
}