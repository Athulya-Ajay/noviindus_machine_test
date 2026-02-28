import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final int index;
  const VideoCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anagha Krishna",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "5 days ago",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "LITERATURE\r\nBUSINESS\r\nDEVELOPMENT ASSOCIATE",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}