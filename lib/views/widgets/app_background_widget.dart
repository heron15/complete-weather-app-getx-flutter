import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';

class AppBackgroundWidget extends StatelessWidget {
  final Widget child;
  final String iconName;

  const AppBackgroundWidget({
    super.key,
    required this.child,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath;
    double bgOpacity;
    if (iconName == "01d" ||
        iconName == "02d" ||
        iconName == "03d" ||
        iconName == "04d" ||
        iconName == "50d") {
      assetPath = AssetPaths.day;
    } else if (iconName == "01n" || iconName == "02n" || iconName == "50n") {
      assetPath = AssetPaths.night;
    } else if (iconName == "03n" || iconName == "04n") {
      assetPath = AssetPaths.nightClouds;
    } else if (iconName == "13d" || iconName == "13n") {
      assetPath = AssetPaths.snow;
    } else if (iconName == "09d" || iconName == "09n" || iconName == "10d" || iconName == "10n") {
      assetPath = AssetPaths.lightRain;
    } else {
      assetPath = AssetPaths.heavyRain;
    }
    if (assetPath == AssetPaths.day || assetPath == AssetPaths.snow) {
      bgOpacity = 0.70;
    } else {
      bgOpacity = 0.50;
    }
    return Stack(
      children: [
        Lottie.asset(
          assetPath,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.black.withOpacity(bgOpacity),
        ),
        child,
      ],
    );
  }
}
