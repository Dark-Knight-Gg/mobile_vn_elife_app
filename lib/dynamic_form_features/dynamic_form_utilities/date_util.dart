import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static String FORMAT_HOUR_SECONDS = 'HH:ss';
  static String FORMAT_DAY_HOUR = 'dd/MM/yyyy HH:ss';
  static String FORMAT_DMY = 'dd/MM/yyyy';
  static String FORMAT_DAY_HOUR_APP = 'yyyy-mm-dd hh:mm:ss';
  static String FORMAT_MONTH_YEAR = 'MMMM, yyyy';
  static String FORMAT_TODAY_SORT = 'EEE';
  static String FORMAT_TODAY_FULL = 'EEEE';
  static String languageCode = 'vi';
  static String FORMAT_DAY_HOUR_APP_T = "yyyy-MM-ddThh:mm:ss";
  static String FORMAT_DAY_HOUR_APP_T2 = "yyyy-MM-ddThh:mm:ss.000+00:00";
  static String FORMAT_DAY_HOUR_MINUTE = 'dd/MM/yyyy HH:mm';

  static String stringFromDate(String format, DateTime date,
      {String? languageCode}) {
    return DateFormat(format, languageCode ?? DateUtil.languageCode)
        .format(date.toUtc());
  }

  static String stringFromDateStringApp(String format, String date) {
    DateTime _date =
        DateUtil.dateFromString(DateUtil.FORMAT_DAY_HOUR_APP, date);
    return DateUtil.stringFromDate(format, _date);
  }

  static String stringFromDateString(String format, String date) {
    DateTime _date = DateUtil.dateFromString(DateUtil.FORMAT_DAY_HOUR, date);
    return DateUtil.stringFromDate(format, _date);
  }

  static DateTime dateFromString(String format, String date) {
    try {
      return DateFormat(format, DateUtil.languageCode)
          .parse(date, true)
          .toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  static String convertFormatDateString(
      String date, String actualFormat, String expectFormat,
      [bool isUtc = false]) {
    try {
      DateTime _date = DateTime.now();
      if (isUtc) {
        _date = DateFormat(actualFormat).parse(date).toUtc();
      } else {
        _date = DateFormat(actualFormat).parse(date);
      }

      return DateUtil.stringFromDateUS(expectFormat, _date);
    } catch (e) {
      return date;
    }
  }

//dungnh:  convert date String
  static String convertDateString(String format, String date) {
    try {
      final DateTime _date = DateFormat("yyyy-MM-ddThh:mm:SSSZ").parse(date);
      return DateUtil.stringFromDateUS(format, _date);
    } catch (e) {
      return date;
    }
  }

  static String convertAndAdd7Hours(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    dateTime = dateTime.add(const Duration(hours: 7));
    DateFormat dateFormat = DateFormat(DateUtil.FORMAT_DAY_HOUR_MINUTE);
    String formattedDateTime = dateFormat.format(dateTime);

    return formattedDateTime;
  }

  static String convertDateStringMutil(
      String format1, String format2, String date) {
    try {
      final DateTime _date = DateFormat(format1).parse(date);
      debugPrint("_date $_date");
      return DateUtil.stringFromDate(format2, _date);
    } catch (e) {
      debugPrint("_date $e");
      return date;
    }
  }

  static String convertDateString2(String format, String date) {
    try {
      var dateFormat = DateFormat(format);
      final DateTime _date = DateFormat("yyyy-MM-ddThh:mm:SSZ").parse(date);
      var dateFormat2 = DateFormat(
          "yyyy-MM-ddThh:mm:SS.SSS"); // you can change the format here
      var utcDate = dateFormat2.format(_date); // pass the UTC time here
      var localDate = dateFormat2.parse(utcDate, true).toLocal().toString();
      String createdDate = dateFormat.format(DateTime.parse(localDate));
      return createdDate;
    } catch (e) {
      return date;
    }
  }

  static String convertDate(
      String formatDate, String formatDateConvert, String date) {
    try {
      final DateTime _date = DateFormat(formatDate, "en_US").parse(date);
      return DateUtil.stringFromDateUS(formatDateConvert, _date);
    } catch (e) {
      return date;
    }
  }

  static String stringFromDateUS(String format, DateTime date) {
    return DateFormat(format, "en_US").format(date);
  }

  static int secondBetween(DateTime from, DateTime to) {
    from = DateTime(
        from.year, from.month, from.day, from.hour, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
    print("abc : ${to.difference(from).inSeconds}");
    return (to.difference(from).inSeconds / 3600).round();
  }

  static double compareDateWithStringFormat(
      String date1Input, String date2Input, String format) {
    DateTime dtDate1 = DateFormat(format).parse(date1Input);
    DateTime dtDate2 = DateFormat(format).parse(date2Input);
    if (dtDate1.compareTo(dtDate2) < 0) {
      print("DT1 là quá khứ DT2");
      return -1;
    } else if (dtDate1.compareTo(dtDate2) == 0) {
      return 0;
    } else {
      print("Day 1 là tương lai day 2");
      return 1;
    }
  }

  static double compareDateWithDateTime(
      DateTime date1Input, DateTime date2Input) {
    String date1 = DateFormat('yyyy-MM-dd').format(date1Input);
    String date2 = DateFormat('yyyy-MM-dd').format(date2Input);
    DateTime dtDate1 = DateTime.parse(date1);
    DateTime dtDate2 = DateTime.parse(date2);
    if (dtDate1.compareTo(dtDate2) < 0) {
      print("DT1 là quá khứ DT2");
      return -1;
    } else if (dtDate1.compareTo(dtDate2) == 0) {
      return 0;
    } else {
      print("Day 1 là tương lai day 2");
      return 1;
    }
  }

  static double compareDateWithString(String date1Input, String date2Input) {
    DateTime dtDate1 = DateFormat("dd/MM/yyyy").parse(date1Input);
    DateTime dtDate2 = DateFormat("dd/MM/yyyy").parse(date2Input);
    if (dtDate1.compareTo(dtDate2) < 0) {
      print("DT1 là quá khứ DT2");
      return -1;
    } else if (dtDate1.compareTo(dtDate2) == 0) {
      return 0;
    } else {
      print("Day 1 là tương lai day 2");
      return 1;
    }
  }

  static DateTime copyWith(DateTime date,
          {int? year,
          int? month,
          int? day,
          int? hour,
          int? minute,
          int? second,
          int? millisecond,
          int? microsecond}) =>
      _date(
          date.isUtc,
          year ?? date.year,
          month ?? date.month,
          day ?? date.day,
          hour ?? date.hour,
          minute ?? date.minute,
          second ?? date.second,
          millisecond ?? date.millisecond,
          microsecond ?? date.microsecond);

  static DateTime _date(bool utc, int year,
          [int month = 1,
          int day = 1,
          int hour = 0,
          int minute = 0,
          int second = 0,
          int millisecond = 0,
          int microsecond = 0]) =>
      utc
          ? DateTime.utc(
              year, month, day, hour, minute, second, millisecond, microsecond)
          : DateTime(
              year, month, day, hour, minute, second, millisecond, microsecond);

  ///  get preview day with number day
  static DateTime previousNumberDay(DateTime d, int numberPreview) {
    return copyWith(d, day: d.day - numberPreview);
  }
}
