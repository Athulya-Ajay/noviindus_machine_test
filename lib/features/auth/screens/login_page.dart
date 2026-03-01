import 'package:flutter/material.dart';
import 'package:noviindus_test_app/constants/app_colors.dart';
import 'package:noviindus_test_app/features/auth/model/country_model.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Country> countryList = [
      Country(name: "India", code: "IN", dialCode: "+91"),
      Country(name: "United States", code: "US", dialCode: "+1"),
      Country(name: "United Kingdom", code: "GB", dialCode: "+44"),
      Country(name: "UAE", code: "AE", dialCode: "+971"),
      Country(name: "Australia", code: "AU", dialCode: "+61"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              const Text(
                "Enter Your\nMobile Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Lorem ipsum dolor sit amet consectetur.",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: const Color(0xFF1C1C1C),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          return ListView.builder(
                            itemCount: countryList.length,
                            itemBuilder: (context, index) {
                              final country = countryList[index];
                              return ListTile(
                                title: Text(
                                  country.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Text(
                                  country.dialCode,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                onTap: () {
                                  authProvider.setCountryCode(country.dialCode);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          Text(
                            authProvider.countryCode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: TextField(
                        controller: authProvider.phoneController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        onChanged: (value) {
                          authProvider.validatePhone(value);
                        },
                        decoration: const InputDecoration(
                          counterText: "",
                          hintText: "Enter Mobile Number",
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Center(
                child: authProvider.isLoading 
                ? CircularProgressIndicator(color: Colors.red,)
                : GestureDetector(
                  onTap: authProvider.isValid
                      ? () async {
                          await authProvider.verifyOtp(context);
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: authProvider.isValid
                                ? Colors.white
                                : Colors.white38,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: authProvider.isValid
                                ? AppColors.primaryRed
                                : AppColors.primaryRed.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}