import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/views/widgets/search_list_item.dart';

class SearchScreen extends SearchDelegate {
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
          color: AppColor.white,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: AppColor.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    globalController.getSuggestions(query);
    return searchListWidget(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    globalController.getSuggestions(query);
    return searchListWidget(context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.darkSecondary,
      ),
      scaffoldBackgroundColor: AppColor.darkBg,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColor.white),
        labelStyle: TextStyle(color: AppColor.white),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColor.white,
        ),
      ),
    );
  }

  Widget searchListWidget(BuildContext context) {
    return Obx(
      () {
        if (query.isEmpty) {
          globalController.clearSuggestions();
        }

        if (globalController.getIsSearching().value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.white,
            ),
          );
        }

        List<Widget> listItems = [currentLocationButton(context)];

        if (globalController.getSuggestionsList().isNotEmpty) {
          listItems.addAll(globalController.getSuggestionsList().map((suggestion) {
            String placeName = suggestion['description'];
            return SearchListItem(
              placeName: placeName,
              onTap: () async {
                globalController.setSelectedPlace(placeName);
                close(context, placeName);
              },
            );
          }).toList());
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return listItems[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: AppColor.dividerLine.withAlpha(120),
                height: 1,
              );
            },
          ),
        );
      },
    );
  }

  Widget currentLocationButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          close(context, "current_location_call");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.darkBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: AppColor.dividerLine,
              width: 1,
            ),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColor.white,
            ),
            SizedBox(width: 8),
            Text(
              "Use My Current Location",
              style: TextStyle(
                color: AppColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
