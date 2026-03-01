import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:noviindus_test_app/features/auth/model/otp_model.dart';
import 'package:noviindus_test_app/features/auth/service/auth_service.dart';
import 'package:noviindus_test_app/features/home/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  final AuthService _authService = AuthService();

  String _countryCode = "+91";
  bool _isValid = false;
  bool _isLoading = false;

  OtpVerifyModel otpResponse = OtpVerifyModel();

  String get countryCode => _countryCode;
  bool get isValid => _isValid;
  bool get isLoading => _isLoading;

  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  void validatePhone(String value) {
    _isValid = value.length == 10;
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context) async {
  try {
    _isLoading = true;
    notifyListeners();

    otpResponse = await _authService.verifyOtp(
      countryCode: _countryCode,
      phone: phoneController.text,
    );

    if (otpResponse.status == true) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("access_token", otpResponse.token!.access!);
      await prefs.setString("refresh_token", otpResponse.token!.refresh!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP verified successfully"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("OTP verification failed"),
          backgroundColor: AppColors.primaryRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  } catch (e) {
    debugPrint("OTP Verify Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong. Please try again."),
        backgroundColor: AppColors.primaryRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  String get fullPhoneNumber => "$_countryCode${phoneController.text}";

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}