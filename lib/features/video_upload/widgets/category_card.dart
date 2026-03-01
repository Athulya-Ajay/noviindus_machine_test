import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../provider/video_upload_provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoUploadProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories This Project",
          style: TextStyle(color: AppColors.primarywhite),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final isSelected =
                  provider.selectedCategory == provider.categories[index];

              return GestureDetector(
                onTap: () => provider.selectCategory(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryRed
                        : AppColors.bgBlack,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlack
                          : AppColors.primaryRed,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    provider.categories[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primarywhite
                          : AppColors.lightGrey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}