import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_widget/core_selector/selector_bottom_sheet.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_widget/core_selector/selector_model.dart';

import '../../../dynamic_form_features/dynamic_form_network/dio_option.dart';
import '../../../dynamic_form_features/dynamic_form_utilities/util.dart';
import '../../dynamic_form_enum/type_data.dart';
import '../../dynamic_form_event/map_change.dart';
import '../core_text_field.dart';

class OneUiSelector extends StatefulWidget {
  const OneUiSelector({
    super.key,
    this.title,
    this.borderRadius,
    this.initValue,
    this.contentValidateEmpty,
    this.titleColor,
    this.titleSize,
    this.errorBorderColor,
    this.focusBorderColor,
    this.borderColor,
    this.contentPadding,
    this.hintText,
    this.hintSize,
    this.hintColor,
    this.textSize,
    this.textColor,
    this.isRequired,
    this.enable,
    this.maxLines,
    this.isShowSearch,
    this.dataSrc,
    this.url,
    this.hardData,
    this.onChanged,
    this.partnerMap,
    this.hasTitle,
    this.titleFontWeight,
    this.suffixIconWidth,
    this.suffixIconColor,
    this.request,
  });

  final String? title;
  final double? borderRadius;
  final SelectorModel? initValue;
  final String? contentValidateEmpty;
  final Color? titleColor;
  final double? titleSize;
  final Color? errorBorderColor;
  final Color? focusBorderColor;
  final Color? borderColor;
  final double? contentPadding;
  final String? hintText;
  final double? hintSize;
  final Color? hintColor;
  final double? textSize;
  final Color? textColor;
  final bool? isRequired;
  final bool? enable;
  final int? maxLines;
  final bool? isShowSearch;
  final String? dataSrc;
  final String? url;
  final List<SelectorModel>? hardData;
  final Function(SelectorModel?)? onChanged;
  final SelectorModel? partnerMap;
  final bool? hasTitle;
  final FontWeight? titleFontWeight;
  final double? suffixIconWidth;
  final Color? suffixIconColor;
  final String? request;

  @override
  State<OneUiSelector> createState() => _OneUiSelectorState();
}

class _OneUiSelectorState extends State<OneUiSelector> {
  late SelectorModel? _initValue;
  late List<SelectorModel>? _data;
  late Dio dio;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initValue = widget.initValue;
    if (!(widget.dataSrc == TypeData.dataSrc.value)) {
      setState(() {
        _data = widget.hardData;
      });
    } else {
      _data = [];
    }
  }

  Future<List<SelectorModel>> getDataFromApi() async {
    final url = widget.partnerMap == null
        ? widget.url!
        : '${widget.url!}${widget.request}';
    widget.partnerMap == null ? widget.url! : '${widget.url!}${widget.request}';
    dio = DioOption().createDio();
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<SelectModelResponse>(Options(
      method: 'GET',
    ).compose(dio.options, url)));
    return SelectModelResponse.fromJson(result.data!).data;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextField(context);
  }

  Widget _buildTextField(BuildContext context) {
    return OneUiTextFormField(
      title: widget.title,
      borderRadius: widget.borderRadius,
      initValue: _initValue?.name,
      contentValidateEmpty: widget.contentValidateEmpty,
      titleColor: widget.titleColor,
      titleSize: widget.titleSize,
      errorBorderColor: widget.errorBorderColor,
      focusBorderColor: widget.focusBorderColor,
      borderColor: widget.borderColor,
      contentPadding: widget.contentPadding,
      hintText: widget.hintText,
      hintSize: widget.hintSize,
      hintColor: widget.hintColor,
      textSize: widget.textSize,
      textColor: widget.textColor,
      isRequired: widget.isRequired,
      enable: true,
      readOnly: true,
      maxLines: widget.maxLines,
      onTap: () async {
        if (widget.dataSrc == TypeData.dataSrc.value) {
          final result =
          await getDataFromApi();
          setState(() {
            _data = result;
          });
        }
        onTapSelector(context);
      },
      hasTitle: widget.hasTitle,
      controller: textController,
      titleFontWeight: widget.titleFontWeight,
      suffixIcon: buildSuffixIcon(),
      suffixIconWidth: widget.suffixIconWidth,
    );
  }

  Widget buildSuffixIcon() {
    return Container(
      padding: const EdgeInsets.all(6),
      child: SvgPicture.asset(
        'assets/images/ic_arrow_dow_outline.svg',
        colorFilter: ColorFilter.mode(
            widget.suffixIconColor ?? const Color(0xff696969), BlendMode.srcIn),
      ),
    );
  }

  void onTapSelector(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minHeight = screenHeight / 2;
    final maxHeight = screenHeight * 2 / 3;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
            minHeight: minHeight,
            maxHeight: maxHeight,
          ),
          child: SelectorBottomSheet(
            textColor: widget.textColor,
            textSize: widget.textSize,
            data: _data,
            intValue: _initValue,
            isShowSearch: widget.isShowSearch,
            onChange: (value) {
              if (value != null) {
                setState(() {
                  _initValue = value;
                });
                textController.text = _initValue?.name ?? _initValue?.ten ?? '';
                widget.onChanged?.call(value);
              }
            },
          ),
        );
      },
    );
  }
}

Widget selectorBox(
  Item,
  Map<String, dynamic> map,
  StreamController<dynamic> streamController,
) {
  final title = Item['title'];
  final borderRadius = Item['borderRadius'];
  final initValue = map[Item['key']];
  final contentValidateEmpty = Item['contentValidateEmpty'];
  final titleColor = Util.convertFromHexToColor(Item['titleColor']);
  final titleSize = Item['titleSize'];
  final errorBorderColor = Util.convertFromHexToColor(Item['errorBorderColor']);
  final focusBorderColor = Util.convertFromHexToColor(Item['focusBorderColor']);
  final borderColor = Util.convertFromHexToColor(Item['borderColor']);
  final contentPadding = Item['contentPadding'];
  final hintText = Item['hintText'];
  final hintSize = Item['hintSize'];
  final hintColor = Util.convertFromHexToColor(Item['hintColor']);
  final textSize = Item['textSize'];
  final textColor = Util.convertFromHexToColor(Item['textColor']);
  final isRequired = Item['isRequired'];
  final enable = Item['enable'];
  final isShowSearch = Item['isShowSearch'];
  final dataSrc = Item['dataSrc'];
  final url = Item['data']['url'];
  final hardData = Item['data']['hardData'];
  final partnerMap = map[Item['partnerMap']] as SelectorModel?;
  final request =
      Util.getRequest(Item['data']['request'], partnerMap?.toJson());
  final hasTitle = Item['hasTitle'];
  final titleFontWeight =
      Util.convertFromStringToFontWeight(Item['titleFontWeight']);
  return OneUiSelector(
    title: title,
    borderRadius: borderRadius,
    initValue: initValue,
    contentValidateEmpty: contentValidateEmpty,
    titleColor: titleColor,
    titleSize: titleSize,
    errorBorderColor: errorBorderColor,
    focusBorderColor: focusBorderColor,
    borderColor: borderColor,
    contentPadding: contentPadding,
    hintText: hintText,
    hintSize: hintSize,
    hintColor: hintColor,
    textSize: textSize,
    textColor: textColor,
    isRequired: isRequired,
    enable: enable,
    maxLines: 1,
    isShowSearch: isShowSearch,
    dataSrc: dataSrc,
    url: url,
    hardData: hardData,
    onChanged: (value) {
      map[Item['key']] = value;
      streamController.sink.add(
        MapChange(
          {
            Item['key']: value,
          },
        ),
      );
    },
    partnerMap: partnerMap,
    hasTitle: hasTitle,
    titleFontWeight: titleFontWeight,
    request: request,
  );
}
