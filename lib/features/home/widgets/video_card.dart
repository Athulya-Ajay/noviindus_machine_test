import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/home/model/home_model.dart';
import 'package:noviindus_test_app/features/home/provider/video_feed_provider.dart';
import 'package:noviindus_test_app/features/home/screens/full_screen_video.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final int index;
  final Results result;

  const VideoCard({
    super.key,
    required this.index, 
    required this.result,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.result.video ??  "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4")
      ..initialize().then((_) {
        setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _format(Duration d) =>
      '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoFeedProvider>();
    final isPlaying = provider.activeIndex == widget.index;

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
            AspectRatio(
              aspectRatio:
                  _initialized ? _controller.value.aspectRatio : 16 / 9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Thumbnail
                  if (!isPlaying)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.result.image ??
                        "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
        
                  // Video
                  if (_initialized)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: VideoPlayer(_controller),
                    ),
        
                  // Play Button
                  if (!isPlaying)
                    GestureDetector(
                      onTap: () {
                        provider.playVideo(
                          index: widget.index,
                          controller: _controller,
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(14),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
        
                  // Controls
                  if (isPlaying)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.black54,
                        child: Column(
                          children: [
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.red,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  '${_format(_controller.value.position)} / ${_format(_controller.value.duration)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FullScreenVideo(
                                          controller: _controller,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
             Text(widget.result.description ??
              "Description not available",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        );
      }
  }