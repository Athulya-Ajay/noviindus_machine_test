import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:noviindus_test_app/features/home/model/home_model.dart';
import 'package:noviindus_test_app/features/home/widgets/video_card.dart';

class MyFeedPage extends StatelessWidget {
  const MyFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        elevation: 0,
        title: const Text(
          "My Feed",
          style: TextStyle(color: AppColors.primarywhite),
        ),
        iconTheme: const IconThemeData(color: AppColors.primarywhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (_, index) => VideoCard(index: index, result: Results(),),
        ),
      ),
    );
  }
}