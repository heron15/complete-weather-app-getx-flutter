import 'package:flutter/material.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPaths.noInternetIcon,
              height: 180,
              width: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text(
              "Oops, No Internet Connection!",
              style: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              textAlign: TextAlign.center,
              "Make Sure wifi or cellular data is turned on and then try again.",
              style: TextStyle(
                color: AppColor.dividerLine.withAlpha(200),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            Icon(
              Icons.refresh,
              color: AppColor.dividerLine.withAlpha(190),
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}