// ignore_for_file: unnecessary_import, unrelated_type_equality_checks

import 'dart:convert';

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
    print('-----------requestStaert-------------$request');
    if (request == null) {
      return '';
    }
    if (request.isEmpty) {
      return '';
    }
    String result = '';
    print('-----------requestBetwent-------------$request');
    request.forEachIndexed(
      (index, element) {
        if (index == 0) {
          result = '?${element['key']}=${partnerMap?[element['value']]}';
        } else {
          result = '$result&${element['key']}=${partnerMap?[element['value']]}';
        }
      },
    );
    print('-----------requestEnd-------------$request');
    return result;
  }

  static List<Map<String, dynamic>>? convertToListMap(List<dynamic>? listDynamic) {
    if (listDynamic == null) {
      return null;
    }
/*    final jsonString =listDynamic.toString();
    final dynamicList = jsonDecode(jsonString);
    final List<Map<String, dynamic>> parsedList = (dynamicList as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();*/
    return listDynamic.map((e) => e as Map<String, dynamic>).toList();
/*    return parsedList;*/
  }

  static double? convertToDouble(dynamic value){
    if (value == null) return null;
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  static Alignment? convertToAlignment(String alignment){
    if (alignment == 'center') {
      return Alignment.center;
    } else if (alignment == 'centerLeft') {
      return Alignment.centerLeft;
    } else if (alignment == 'centerRight') {
      return Alignment.centerRight;
    }else if(alignment == 'topCenter'){
      return Alignment.topCenter;
    } else if (alignment == 'topLeft') {
      return Alignment.topLeft;
    } else if (alignment == 'topRight') {
      return Alignment.topRight;
    }else if(alignment == 'bottomLeft'){
      return Alignment.bottomCenter;
    }else if(alignment == 'bottomLeft'){
      return Alignment.bottomLeft;
    }else if(alignment == 'bottomRight'){
      return Alignment.bottomRight;
    }
    return null;
  }

  static BoxFit? convertToBoxFit(String? fit){
    if (fit == 'contain') {
      return BoxFit.contain;
    } else if (fit == 'cover') {
      return BoxFit.cover;
    } else if (fit == 'fill') {
      return BoxFit.fill;
    } else if (fit == 'fitHeight') {
      return BoxFit.fitHeight;
    } else if (fit == 'fitWidth') {
      return BoxFit.fitWidth;
    }
    return null;
  }

 }
