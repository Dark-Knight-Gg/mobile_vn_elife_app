import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_vn_elife_app/dynamic_form_features/dynamic_form_utilities/color_app.dart';

import '../../../dynamic_form_features/dynamic_form_utilities/util.dart';

class CoreSvgIcon extends StatelessWidget {
  const CoreSvgIcon({
    this.width,
    this.height,
    this.svgUrl,
    this.alignment,
    this.iconColor,
    this.fit = BoxFit.contain,
    this.svgIconSource,
    super.key,
  });

  final double? width;
  final double? height;
  final String? svgUrl;
  final Alignment? alignment;
  final Color? iconColor;
  final BoxFit? fit;
  final String? svgIconSource;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: svgIconSource != null
          ? SvgPicture.string(
              svgIconSource!,
              width: width,
              height: height,
              colorFilter: ColorFilter.mode(
                iconColor ?? ColorApp.brand,
                BlendMode.srcIn,
              ),
              fit: fit ?? BoxFit.fill,
            )
          : SvgPicture.asset(
              svgUrl ?? '',
              width: width,
              height: height,
              colorFilter: ColorFilter.mode(
                iconColor ?? ColorApp.brand,
                BlendMode.srcIn,
              ),
              fit: fit ?? BoxFit.fill,
            ),
    );
  }
}

Widget svgIcon(
  Item,
  Map<String, dynamic> map,
  StreamController<dynamic> streamController,
) {
  final height = Util.convertToDouble(Item['height']);
  final width = Util.convertToDouble(Item['width']);
  final alignment = Util.convertToAlignment(Item['alignment']);
  final iconColor = Util.convertFromHexToColor(Item['iconColor']);
  final svgIconSource = Item['svgIconSource'];
  final svgUrl = Item['svgUrl'];
  final fit = Util.convertToBoxFit(Item['fit']);
  return CoreSvgIcon(
    height: height,
    width: width,
    alignment: alignment,
    iconColor: iconColor,
    svgIconSource: svgIconSource,
    svgUrl: svgUrl,
    fit: fit,
  );
}
