import 'package:flutter/material.dart';
import 'package:modern_weather_getx/utils/app_color.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    required this.placeName,
    required this.onTap,
  });

  final String placeName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        placeName,
        style: const TextStyle(
          color: AppColor.white,
        ),
      ),
      leading: const Icon(
        Icons.location_on_outlined,
        color: AppColor.white,
      ),
    );
  }
}
