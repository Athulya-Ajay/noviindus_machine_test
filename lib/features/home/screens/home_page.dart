import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/home/provider/home_provider.dart';
import 'package:noviindus_test_app/features/home/widgets/video_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: Colors.red,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Welcome back to Section",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/150?img=5",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          final isSelected = provider.selectedIndex == index;

                          return GestureDetector(
                            onTap: () => provider.selectCategory(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.red
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                provider.categories[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => VideoCard(index: index),
                      separatorBuilder: (_, index) => SizedBox(height: 20),
                      itemCount: 4,
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