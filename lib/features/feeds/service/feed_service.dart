import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noviindus_test_app/constants/app_constants.dart';
import 'package:noviindus_test_app/features/feeds/model/feed_model.dart';

class FeedService {
  Future<FeedModel> fetchMyFeed() async {
    final url = Uri.parse("${AppConstants.baseUrl}/my_feed");
    debugPrint("MY FEED API => $url");

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      if (token == null) {
        throw Exception("Access token not found");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return FeedModel.fromJson(jsonData);
      } else {
        debugPrint("Status Code: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
        throw Exception("Failed to load my feeds");
      }
    } catch (e) {
      debugPrint("MyFeed API Error: $e");
      rethrow;
    }
  }
}