import 'package:intl/intl.dart';

class ConstFunction{
  static String getFormatTime(int timeStamp, String formatName ){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formatTime = DateFormat(formatName).format(time);
    return formatTime;
  }
}