import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/data/model/weather_data_hourly.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/views/widgets/hourly_list_item_details.dart';

class HourlyWeatherWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyWeatherWidget({super.key, required this.weatherDataHourly});

  @override
  State<HourlyWeatherWidget> createState() => _HourlyWeatherWidgetState();
}

class _HourlyWeatherWidgetState extends State<HourlyWeatherWidget> {
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    List<double> tempData =
        widget.weatherDataHourly.hourly.take(12).map((hourly) => hourly.temp!.toDouble()).toList();
    List<int> timeData =
        widget.weatherDataHourly.hourly.take(12).map((hourly) => hourly.dt!).toList();
    List<double> windSpeed = widget.weatherDataHourly.hourly
        .take(12)
        .map((hourly) => hourly.windSpeed!.toDouble())
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText(),
        dividerHeader(),
        hourlyList(),
        graphForecast(timeData, tempData, windSpeed),
      ],
    );
  }

  Widget headerText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: const Text(
        "Today",
        style: TextStyle(
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget dividerHeader() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
      width: double.maxFinite,
      height: 1,
      color: AppColor.dividerLine.withAlpha(60),
    );
  }

  Widget hourlyList() {
    return Container(
      height: 125,
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 12
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.only(left: 15, right: 5),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.dividerLine.withAlpha(70),
                    ),
                  ],
                  gradient: cardIndex.value == index
                      ? const LinearGradient(
                          colors: [
                            AppColor.firstGradientColor,
                            AppColor.secondGradientColor,
                          ],
                        )
                      : null,
                ),
                child: HourlyListItemDetails(
                  temp: widget.weatherDataHourly.hourly[index].temp!,
                  timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                  weatherIcon: widget.weatherDataHourly.hourly[index].weather![0].icon!,
                  textColor: cardIndex.value == index
                      ? AppColor.white
                      : AppColor.dividerLine.withAlpha(220),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget graphForecast(List<int> timeData, List<double> tempData, List<double> windSpeed) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColor.dividerLine.withAlpha(70),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 3),
            child: Text(
              "24-Hour Graph Forecast",
              style: TextStyle(
                color: AppColor.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 1,
            width: 180,
            decoration: BoxDecoration(
              color: AppColor.dividerLine.withAlpha(100),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
              width: 12 * 70.0,
              height: 140,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 70,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < timeData.length) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "${tempData[index].round()}°",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 2,
                                ),
                                children: [
                                  TextSpan(
                                    text: "\n${windSpeed[index]}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " km/h",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(150),
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\n${formatTimestamp(timeData[index])}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Text('');
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: const LineTouchData(enabled: false),
                  minX: 0,
                  maxX: (tempData.length - 1).toDouble(),
                  minY: tempData.reduce((a, b) => a < b ? a : b) - 2,
                  maxY: tempData.reduce((a, b) => a > b ? a : b) + 2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: tempData
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                          .toList(),
                      isCurved: true,
                      barWidth: 4,
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColor.firstGradientColor.withAlpha(50),
                      ),
                      color: Colors.transparent,
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.firstGradientColor,
                          AppColor.secondGradientColor,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 4,
                          color: AppColor.white,
                          strokeWidth: 1,
                          strokeColor: AppColor.firstGradientColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.j().format(dateTime); // 'j' format outputs '9 PM'
  }
}
