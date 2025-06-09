import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_widget/core_text.dart';

import '../../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import '../../../dynamic_form_features/dynamic_form_utilities/util.dart';
import '../../dynamic_form_generate/data_builder.dart';

class CoreExpansion extends StatefulWidget {
  const CoreExpansion({
    this.child,
    this.startWithExpanded = true,
    this.headerCustom,
    this.title,
    this.titleSize,
    this.titleColor,
    this.titleFontWeight,
    this.titlePaddingTop,
    this.titlePaddingBottom,
    this.titlePaddingLeft,
    this.titlePaddingRight,
    this.titleBorderRadius,
    this.titleBackgroundColor,
    super.key,
  });

  final String? title;
  final double? titleSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final double? titlePaddingTop;
  final double? titlePaddingBottom;
  final double? titlePaddingLeft;
  final double? titlePaddingRight;
  final double? titleBorderRadius;
  final Color? titleBackgroundColor;
  final bool startWithExpanded;
  final Widget? child;
  final Widget? headerCustom;

  @override
  State<CoreExpansion> createState() => _CoreExpansionState();
}

class _CoreExpansionState extends State<CoreExpansion> {
  late bool _isExpand;

  @override
  void initState() {
    super.initState();
    _isExpand = widget.startWithExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpand = !_isExpand;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeader(),
          if (_isExpand) ...[
            widget.child ?? SizedBox.shrink(),
          ]
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return widget.headerCustom ??
        Container(
          padding: EdgeInsets.only(
            top: widget.titlePaddingTop ?? 12,
            bottom: widget.titlePaddingBottom ?? 12,
            left: widget.titlePaddingLeft ?? 24,
            right: widget.titlePaddingRight ?? 24,
          ),
          decoration: BoxDecoration(
            color: widget.titleBackgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(widget.titleBorderRadius ?? 8),
          ),
          child: Row(
            children: [
              Expanded(
                child: OneUiText.textWidget(
                  title: widget.title ?? '',
                  color: widget.titleColor,
                  fontSize: widget.titleSize,
                  fontWeight: widget.titleFontWeight,
                ),
              ),
              SizedBox(width: 16),
              SvgPicture.asset(
                _isExpand
                    ? 'assets/images/ic_arrow_up_outline.svg'
                    : 'assets/images/ic_arrow_down_outline.svg',
                width: 20,
                height: 20,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  ColorApp.iconGrey,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
  }
}

Widget expansion(
  Item,
  Map<String, dynamic> map,
  StreamController<dynamic> streamController,
) {
  final title = Item['header']['title'];
  final titleSize = Util.convertToDouble(Item['header']['titleSize']);
  final titleColor = Util.convertFromHexToColor(Item['header']['titleColor']);
  final titleFontWeight =
      Util.convertFromStringToFontWeight(Item['header']['titleFontWeight']);
  final titlePaddingTop =
      Util.convertToDouble(Item['header']['padding']['top']);
  final titlePaddingBottom =
      Util.convertToDouble(Item['header']['padding']['bottom']);
  final titlePaddingLeft =
      Util.convertToDouble(Item['header']['padding']['left']);
  final titlePaddingRight =
      Util.convertToDouble(Item['header']['padding']['right']);
  final titleBorderRadius =
      Util.convertToDouble(Item['header']['borderRadius']);
  final titleBackgroundColor =
      Util.convertFromHexToColor(Item['header']['backgroundColor']);
  final components = Item['components'];
  final child = widgetBuilder(components, map, streamController, 1);
  final headerComponents = Item['header']['headerComponents'];
  final headerCustom =
      widgetBuilder(headerComponents, map, streamController, 1);
  final startWithExpanded = Item['startWithExpanded'];

  return CoreExpansion(
    title: title,
    titleSize: titleSize,
    titleColor: titleColor,
    titleFontWeight: titleFontWeight,
    titlePaddingTop: titlePaddingTop,
    titlePaddingBottom: titlePaddingBottom,
    titlePaddingLeft: titlePaddingLeft,
    titlePaddingRight: titlePaddingRight,
    titleBorderRadius: titleBorderRadius,
    titleBackgroundColor: titleBackgroundColor,
    headerCustom: headerCustom,
    startWithExpanded: startWithExpanded,
    child: child,
  );
}
