import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:noviindus_test_app/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoUploadService {

  Future<bool> uploadFeed({
    required File video,
    required File image,
    required String description,
    required String category,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("${AppConstants.baseUrl}/my_feed"),
    );

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    request.fields["desc"] = description;
    request.fields["category"] = category;

    request.files.add(
      await http.MultipartFile.fromPath("video", video.path),
    );

    request.files.add(
      await http.MultipartFile.fromPath("image", image.path),
    );

    final response = await request.send();
    return response.statusCode == 200 || response.statusCode == 201|| response.statusCode == 202;
  }
}