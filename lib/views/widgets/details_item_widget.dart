import 'package:flutter/material.dart';
import 'package:modern_weather_getx/utils/app_color.dart';

class DetailsItemWidget extends StatelessWidget {
  final String icon;
  final String titleText;
  final String valueText;
  final String valueSubText;

  const DetailsItemWidget({
    super.key,
    required this.icon,
    required this.titleText,
    required this.valueText,
    required this.valueSubText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColor.dividerLine.withAlpha(70),
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                color: AppColor.white,
                colorBlendMode: BlendMode.srcIn,
              ),
              const SizedBox(width: 5),
              Text(
                titleText,
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            text: "$valueText ",
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: valueSubText,
                style: TextStyle(
                  color: AppColor.white.withAlpha(130),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
