import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus_test_app/constants/app_constants.dart';
import 'package:noviindus_test_app/features/home/model/home_model.dart';

class HomeService {
  Future<HomeModel> fetchHomeDetails() async {
    final url = Uri.parse("${AppConstants.baseUrl}/home");
    debugPrint("HOME API $url");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return HomeModel.fromJson(jsonData);
      } else {
        debugPrint("Status Code: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
        throw Exception("Failed to load home data");
      }
    } catch (e) {
      debugPrint("Home API Error: $e");
      rethrow;
    }
  }
}