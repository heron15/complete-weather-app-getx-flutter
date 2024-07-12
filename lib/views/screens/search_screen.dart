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
    return searchListWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    globalController.getSuggestions(query);
    return searchListWidget();
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

  Widget searchListWidget() {
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

        if (globalController.getSuggestionsList().isEmpty) {
          return const Center(
            child: Text(
              'No results found',
              style: TextStyle(color: AppColor.white),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemCount: globalController.getSuggestionsList().length,
            itemBuilder: (context, index) {
              String placeName = globalController.getSuggestionsList()[index]['description'];
              return SearchListItem(
                placeName: placeName,
                onTap: () async {
                  globalController.setSelectedPlace(placeName);
                  close(context, placeName);
                },
              );
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
}
