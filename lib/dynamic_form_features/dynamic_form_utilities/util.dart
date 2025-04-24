// ignore_for_file: unnecessary_import, unrelated_type_equality_checks

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../dynamic_form_utilities/constants.dart';

class Util {
  static String orEmpty(dynamic constant) {
    if (constant != null && constant is String) {
      return constant;
    } else {
      return Constants.empty;
    }
  }

  static num orZero(dynamic constant) {
    if (constant != null && constant is num) {
      return constant;
    } else {
      return Constants.zero;
    }
  }

  static int orZeroInt(dynamic constant) {
    if (constant != null && constant is int) {
      return constant;
    } else {
      return Constants.zero;
    }
  }

  static bool orDefaultBool(dynamic constant) {
    if (constant != null && constant is bool) {
      return constant;
    } else {
      return Constants.defaultBool;
    }
  }

  static List orEmptyList(dynamic constant) {
    if (constant != null && constant is List && constant.isNotEmpty) {
      return constant;
    } else {
      return [];
    }
  }

  static Color? convertFromHexToColor(String? hex) {
    final buffer = StringBuffer();
    if (hex == null) return null;
    if (hex.contains('#') && (hex.length == 6 || hex.length == 7)) {
      buffer.write(hex.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16) + 0xFF000000);
    }
    return null;
  }

  static FontWeight convertFromStringToFontWeight(String? fontWeight) {
    if (fontWeight == null) return FontWeight.w400;
    if (fontWeight.toUpperCase() == 'NORMAL') {
      return FontWeight.w400;
    } else if (fontWeight.toUpperCase() == 'MEDIUM') {
      return FontWeight.w500;
    } else if (fontWeight.toUpperCase() == 'BOLD') {
      return FontWeight.w600;
    } else {
      return FontWeight.w400;
    }
  }

  static String getRequest(List<Map<String, dynamic>>? request,
    Map<String, dynamic>? partnerMap,
  ) {
    if (request == null) {
      return '';
    }
    if (request.isEmpty) {
      return '';
    }
    String result = '';
    request.forEachIndexed(
      (index, element) {
        if (index == 0) {
          result = '?${element['key']}=${partnerMap?[element['value']]}';
        } else {
          result = '$result&${element['key']}=${partnerMap?[element['value']]}';
        }
      },
    );
    return result;
  }
}
