import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:noviindus_test_app/features/feeds/provider/feed_provider.dart';
import 'package:noviindus_test_app/features/home/widgets/video_card.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({super.key});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FeedProvider>().fetchMyFeed();
    });
  }

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
      body: Consumer<FeedProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.feedModel.results.isEmpty) {
            return const Center(
              child: Text(
                "No feeds available",
                style: TextStyle(color: AppColors.primarywhite),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: provider.feedModel.results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (_, index) {
                final result = provider.feedModel.results[index];
                return VideoCard(
                  index: index,
                  result: result,
                );
              },
            ),
          );
        },
      ),
    );
  }
}