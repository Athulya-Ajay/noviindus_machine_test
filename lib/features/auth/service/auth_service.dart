import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus_test_app/constants/app_constants.dart';
import 'package:noviindus_test_app/features/auth/model/otp_model.dart';

class AuthService {
  Future<OtpVerifyModel> verifyOtp({
    required String countryCode,
    required String phone,
  }) async {
    final url = Uri.parse("${AppConstants.baseUrl}/otp_verified");
    debugPrint(url.toString());
    debugPrint(countryCode + " " + phone);

    final response = await http.post(
      url,
      body: {"country_code": countryCode, "phone": phone},
    );

    if (response.statusCode == 202) {
      final jsonData = jsonDecode(response.body);
      return OtpVerifyModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to verify OTP");
    }
  }
}