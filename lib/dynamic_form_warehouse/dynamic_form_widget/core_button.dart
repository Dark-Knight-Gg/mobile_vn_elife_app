// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import '../../dynamic_form_features/dynamic_form_utilities/util.dart';
import 'core_text.dart';

class OneUiButton extends StatelessWidget {
  OneUiButton({
    super.key,
    this.title,
    required this.onPress,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.shadowColor,
    this.sizeIcon,
    this.titleSize,
    this.titleColor,
    this.iconColor,
    this.maxLineTextButton,
    this.borderRadius,
    this.borderWidth,
    this.margin,
  });

  late String? title;
  final Function()? onPress;
  final Color? backgroundColor;
  late Color? borderColor;
  final double? width;
  final double? height;
  late Color? shadowColor;
  late double? borderWidth;
  final Color? iconColor;
  final Color? titleColor;
  final double? sizeIcon;
  final double? titleSize;
  final int? maxLineTextButton;
  final double? margin;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.all(margin ?? 16),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorApp.brand,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: shadowColor ?? Colors.transparent,
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          title ?? '',
          maxLines: maxLineTextButton ?? 1,
          overflow: TextOverflow.ellipsis,
          style: OneUiText.textStyle(
            titleSize ?? 14,
            FontWeight.w500,
            titleColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget button(Item, Map<String, dynamic> map) {
  final title = Item['title'];
  final backgroundColor = Util.convertFromHexToColor(Item['backgroundColor']);
  final borderColor = Util.convertFromHexToColor(Item['borderColor']);
  final width = Util.convertToDouble(Item['width']);
  final height = Util.convertToDouble(Item['height']);
  final shadowColor = Util.convertFromHexToColor(Item['shadowColor']);
  final sizeIcon = Item['sizeIcon'].toDouble();
  final titleSize = Util.convertToDouble(Item['titleSize']);
  final titleColor = Util.convertFromHexToColor(Item['titleColor']);
  final iconColor = Util.convertFromHexToColor(Item['iconColor']);
  final borderRadius = Util.convertToDouble(Item['borderRadius']);
  final borderWith = Util.convertToDouble(Item['borderWidth']);
  final margin = Util.convertToDouble(Item['margin']);
  return OneUiButton(
    title: title,
    onPress: () {},
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    width: width,
    height: height,
    shadowColor: shadowColor,
    sizeIcon: sizeIcon,
    titleSize: titleSize,
    titleColor: titleColor,
    iconColor: iconColor,
    maxLineTextButton: 1,
    borderRadius: borderRadius,
    borderWidth: borderWith,
    margin: margin,
  );
}
