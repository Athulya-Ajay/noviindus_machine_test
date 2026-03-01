import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:noviindus_test_app/features/feeds/screens/my_feed_page.dart';
import 'package:noviindus_test_app/features/home/provider/home_provider.dart';
import 'package:noviindus_test_app/features/home/widgets/video_card.dart';
import 'package:noviindus_test_app/features/video_upload/screens/video_upload_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<HomeProvider>();
      if (provider.homeDetails.results.isEmpty && !provider.isLoading) {
        provider.getHomeDetails();
      }
    });
    return Consumer<HomeProvider>(
      builder: (context, provider, state) {
        return Scaffold(
          backgroundColor: AppColors.bgBlack,
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: AppColors.primaryRed,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contex) => VideoUploadPage()),
              );
            },
            child: const Icon(Icons.add, color: AppColors.primarywhite),
          ),
          body: SafeArea(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello ${provider.userName}",
                                    style: const TextStyle(
                                      color: AppColors.primarywhite,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Welcome back to Section",
                                    style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MyFeedPage(),
                                    ),
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/150?img=5",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          provider.homeDetails.results.isEmpty
                              ? Text("No categories available right now")
                              : SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.categories.length,
                                    itemBuilder: (context, index) {
                                      final isSelected =
                                          provider.selectedIndex == index;

                                      return GestureDetector(
                                        onTap: () =>
                                            provider.selectCategory(index),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 12,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.primaryRed
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            border: Border.all(
                                              color: AppColors.darkGrey,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            provider.categories[index],
                                            style: TextStyle(
                                              color: isSelected
                                                  ? AppColors.primarywhite
                                                  : AppColors.darkGrey,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(height: 20),
                          provider.homeDetails.results.isEmpty
                              ? Text("No feed available right now")
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) => VideoCard(
                                    index: index,
                                    result: provider.homeDetails.results[index],
                                  ),
                                  separatorBuilder: (_, index) =>
                                      SizedBox(height: 20),
                                  itemCount:
                                      provider.homeDetails.results.length,
                                ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
