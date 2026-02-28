import 'package:flutter/material.dart';
import 'package:noviindus_test_app/features/home/provider/home_provider.dart';
import 'package:noviindus_test_app/features/home/screens/home_page.dart';
import 'package:noviindus_test_app/features/video_upload/screens/video_upload_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: VideoUploadPage(),
      ),
    );
  }
}