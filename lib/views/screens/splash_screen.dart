import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/app_route.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBg,
      body: Center(
        child: Lottie.asset(
          AssetPaths.weather,
          width: 120,
          height: 120,
        ),
      ),
    );
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.offNamed(AppRoute.homeScreen);
    }
  }
}
