import 'package:flutter/material.dart';
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
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: provider.categories.map((category) {
            final isSelected =
                provider.selectedCategories.contains(category);

            return ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => provider.toggleCategory(category),
              selectedColor: Colors.red.withOpacity(0.2),
              backgroundColor: Colors.black26,
              labelStyle: TextStyle(
                color: isSelected ? Colors.red : Colors.white70,
              ),
              side: const BorderSide(color: Colors.red),
            );
          }).toList(),
        ),
      ],
    );
  }
}