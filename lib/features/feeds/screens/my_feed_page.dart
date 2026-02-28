import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/home/widgets/video_card.dart';

class MyFeedPage extends StatelessWidget {
  const MyFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        title: const Text(
          "My Feed",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (_, index) => VideoCard(index: index),
        ),
      ),
    );
  }
}