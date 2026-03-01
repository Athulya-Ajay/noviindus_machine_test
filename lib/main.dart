import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noviindus_test_app/features/auth/provider/auth_provider.dart';
import 'package:noviindus_test_app/features/auth/screens/login_page.dart';
import 'package:noviindus_test_app/features/feeds/provider/feed_provider.dart';
import 'package:noviindus_test_app/features/home/provider/home_provider.dart';
import 'package:noviindus_test_app/features/home/provider/video_feed_provider.dart';
import 'package:noviindus_test_app/features/video_upload/provider/video_upload_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.light, 
      statusBarBrightness: Brightness.dark, 
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VideoFeedProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => VideoUploadProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}