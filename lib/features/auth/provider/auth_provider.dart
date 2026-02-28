import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  String _countryCode = "+91";
  bool _isValid = false;

  String get countryCode => _countryCode;
  bool get isValid => _isValid;

  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  void validatePhone(String value) {
    // Simple Indian validation (10 digits)
    if (value.length == 10) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }

  String get fullPhoneNumber => "$_countryCode${phoneController.text}";

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}