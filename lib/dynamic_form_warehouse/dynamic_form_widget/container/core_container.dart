import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_vn_elife_app/dynamic_form_features/dynamic_form_utilities/color_app.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_generate/data_builder.dart';

import '../../../dynamic_form_features/dynamic_form_utilities/util.dart';

class CoreContainer extends StatelessWidget {
  const CoreContainer(
      {this.height,
      this.width,
      this.alignment,
      this.topPadding,
      this.bottomPadding,
      this.leftPadding,
      this.rightPadding,
      this.topMargin,
      this.bottomMargin,
      this.leftMargin,
      this.rightMargin,
      this.backGroundColor,
      this.topBorder,
      this.bottomBorder,
      this.leftBorder,
      this.rightBorder,
      this.topLeftRadius,
      this.topRightRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.imageUrl,
      this.imageAlignment,
      this.maxHeight,
      this.minHeight,
      this.maxWidth,
      this.minWidth,
      this.leftBorderColor,
      this.rightBorderColor,
      this.topBorderColor,
      this.bottomBorderColor,
      this.child,
      super.key});

  final double? height;
  final double? width;
  final Alignment? alignment;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final double? topMargin;
  final double? bottomMargin;
  final double? leftMargin;
  final double? rightMargin;
  final Color? backGroundColor;
  final double? topBorder;
  final double? bottomBorder;
  final double? leftBorder;
  final double? rightBorder;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final String? imageUrl;
  final Alignment? imageAlignment;
  final double? maxHeight;
  final double? minHeight;
  final double? maxWidth;
  final double? minWidth;
  final Color? leftBorderColor;
  final Color? rightBorderColor;
  final Color? topBorderColor;
  final Color? bottomBorderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: leftPadding ?? 12,
        right: rightPadding ?? 12,
        top: topPadding ?? 12,
        bottom: bottomPadding ?? 12,
      ),
      margin: EdgeInsets.only(
        left: leftMargin ?? 12,
        right: rightMargin ?? 12,
        top: topMargin ?? 12,
        bottom: bottomMargin ?? 12,
      ),
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      alignment: alignment,
      decoration: BoxDecoration(
        color: backGroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius ?? 8),
          topRight: Radius.circular(topRightRadius ?? 8),
          bottomLeft: Radius.circular(bottomLeftRadius ?? 8),
          bottomRight: Radius.circular(bottomRightRadius ?? 8),
        ),
        border: Border(
          top: BorderSide(
            color: topBorderColor ?? ColorApp.iconGrey,
            width: topBorder ?? 1,
          ),
          bottom: BorderSide(
            color: bottomBorderColor ?? ColorApp.iconGrey,
            width: bottomBorder ?? 1,
          ),
          left: BorderSide(
            color: leftBorderColor ?? ColorApp.iconGrey,
            width: leftBorder ?? 1,
          ),
          right: BorderSide(
            color: rightBorderColor ?? ColorApp.iconGrey,
            width: rightBorder ?? 1,
          ),
        ),
      ),
      child: child,
    );
  }
}

Widget containerBox(
  Item,
  Map<String, dynamic> map,
  StreamController<dynamic> streamController,
) {
  final height = Util.convertToDouble(Item['height']);
  final width = Util.convertToDouble(Item['width']);
  final alignment = Util.convertToAlignment(Item['alignment']);
  final topPadding = Util.convertToDouble(Item['topPadding']);
  final bottomPadding = Util.convertToDouble(Item['bottomPadding']);
  final leftPadding = Util.convertToDouble(Item['leftPadding']);
  final rightPadding = Util.convertToDouble(Item['rightPadding']);
  final topMargin = Util.convertToDouble(Item['topMargin']);
  final bottomMargin = Util.convertToDouble(Item['bottomMargin']);
  final leftMargin = Util.convertToDouble(Item['leftMargin']);
  final rightMargin = Util.convertToDouble(Item['rightMargin']);
  final backGroundColor =
      Util.convertFromHexToColor(Item['decoration']['color']);
  final topBorder = Util.convertToDouble(Item['decoration']['border']['top']);
  final bottomBorder =
      Util.convertToDouble(Item['decoration']['border']['bottom']);
  final leftBorder = Util.convertToDouble(Item['decoration']['border']['left']);
  final rightBorder =
      Util.convertToDouble(Item['decoration']['border']['right']);
  final topLeftRadius =
      Util.convertToDouble(Item['decoration']['borderRadius']['topLeft']);
  final topRightRadius =
      Util.convertToDouble(Item['decoration']['borderRadius']['topRight']);
  final bottomLeftRadius =
      Util.convertToDouble(Item['decoration']['borderRadius']['bottomLeft']);
  final bottomRightRadius =
      Util.convertToDouble(Item['decoration']['borderRadius']['bottomRight']);
  final imageUrl = Item['decoration']['image']['imageUrl'];
  final imageAlignment =
      Util.convertToAlignment(Item['decoration']['image']['alignment']);
  final maxHeight = Util.convertToDouble(Item['constrains']['maxHeight']);
  final minHeight = Util.convertToDouble(Item['constrains']['minHeight']);
  final maxWidth = Util.convertToDouble(Item['constrains']['maxWidth']);
  final minWidth = Util.convertToDouble(Item['constrains']['minWidth']);
  final leftBorderColor =
      Util.convertFromHexToColor(Item['decoration']['borderColor']['left']);
  final rightBorderColor =
      Util.convertFromHexToColor(Item['decoration']['borderColor']['right']);
  final topBorderColor =
      Util.convertFromHexToColor(Item['decoration']['borderColor']['top']);
  final bottomBorderColor =
      Util.convertFromHexToColor(Item['decoration']['borderColor']['bottom']);
  final components = Item['components'];
  final child =  widgetBuilder(components, map, streamController,1);
  return CoreContainer(
    height: height,
    width: width,
    alignment: alignment,
    topPadding: topPadding,
    bottomPadding: bottomPadding,
    leftPadding: leftPadding,
    rightPadding: rightPadding,
    topMargin: topMargin,
    bottomMargin: bottomMargin,
    leftMargin: leftMargin,
    rightMargin: rightMargin,
    backGroundColor: backGroundColor,
    topBorder: topBorder,
    bottomBorder: bottomBorder,
    leftBorder: leftBorder,
    rightBorder: rightBorder,
    topLeftRadius: topLeftRadius,
    topRightRadius: topRightRadius,
    bottomLeftRadius: bottomLeftRadius,
    bottomRightRadius: bottomRightRadius,
    imageUrl: imageUrl,
    imageAlignment: imageAlignment,
    maxHeight: maxHeight,
    minHeight: minHeight,
    maxWidth: maxWidth,
    minWidth: minWidth,
    leftBorderColor: leftBorderColor,
    rightBorderColor: rightBorderColor,
    topBorderColor: topBorderColor,
    bottomBorderColor: bottomBorderColor,
    child: child,
  );
}
