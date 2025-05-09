import 'package:flutter/cupertino.dart';

import '../../dynamic_form_features/dynamic_form_utilities/util.dart';

Widget size(Item, Map<String, dynamic> map){
  final height = Util.convertToDouble(Item['height']);
  final width = Util.convertToDouble(Item['width']);
  return SizedBox(
    height: height,
    width: width,
  );
}