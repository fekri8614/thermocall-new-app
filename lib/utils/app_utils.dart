import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static final AppUtils _instance = AppUtils._();
  factory AppUtils() => _instance;

  static void toastShort(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 14,
      textColor: Colors.black,
      backgroundColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void toastLong(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.black,
      fontSize: 14,
      backgroundColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static String convertToIranTime(String utcTime) {
    // Parse the ISO 8601 date string to DateTime object in UTC
    DateTime dateTimeUtc = DateTime.parse(utcTime).toUtc();

    // Define Iran's time zone offset (UTC+3:30)
    const Duration iranTimeOffset = Duration(hours: 3, minutes: 30);

    // Convert the UTC time to Iran's local time
    DateTime iranTime = dateTimeUtc.add(iranTimeOffset);

    // Format the time to show only hour and minute
    String formattedTime = DateFormat('HH:mm').format(iranTime);

    return formattedTime;
  }

  static String convertToNowIranTime(String utcTime) {
    // Parse the ISO 8601 date string to DateTime object in UTC
    DateTime dateTimeUtc = DateTime.parse(utcTime).toUtc();

    // Define Iran's time zone offset (UTC+3:30)
    const Duration iranTimeOffset = Duration(hours: 3, minutes: 30);

    // Convert the UTC time to Iran's local time
    DateTime iranTime = dateTimeUtc.add(iranTimeOffset);

    // Get the current time in Iran's local time
    DateTime nowTime = DateTime.now().toUtc().add(iranTimeOffset);

    // Calculate the difference between now and the given Iran time
    Duration difference = nowTime.difference(iranTime);

    // Calculate days, hours, and minutes
    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);

    // Format the difference as days, hours, and minutes
    String formattedDayTime = '$days days, $hours:$minutes hrs';
    String formattedHourTime = '$hours:$minutes hrs';
    String formattedMinuteTime = '$minutes mins';

    if (days > 0) {
      return formattedDayTime;
    } else if (days < 0) {
      return formattedHourTime;
    } else if (days < 1 && hours < 1) {
      return formattedMinuteTime;
    }

    return "no-fprmatted-data";
  }
}
