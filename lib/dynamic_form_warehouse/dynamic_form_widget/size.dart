import 'package:flutter/cupertino.dart';

Widget size(Item, Map<String, dynamic> map){
  final height = Item['height'];
  final width = Item['width'];
  return SizedBox(
    height: height,
    width: width,
  );
}