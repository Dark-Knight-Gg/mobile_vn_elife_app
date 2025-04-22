// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import '../../dynamic_form_features/dynamic_form_utilities/util.dart';
import 'core_text.dart';

class OneUiTextFormField extends StatefulWidget {
  OneUiTextFormField({
    super.key,
    this.title,
    this.contentPadding,
    this.borderRadius,
    this.isRequired,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.enable,
    this.maxLength,
    this.hintText,
    this.onTap,
    this.titleSize,
    this.titleColor,
    this.contentValidateEmpty,
    this.hintSize,
    this.hintColor,
    this.errorBorderColor,
    this.focusBorderColor,
    this.borderColor,
    this.initValue,
    this.isPassword,
    this.textSize,
    this.textColor,
    this.readOnly,
    this.maxLines,
    this.hasTitle,
    this.controller,
    this.titleFontWeight,
    this.suffixIconWidth,
  });

  final String? title;
  final double? contentPadding;
  final bool? isRequired;
  final Function(String value)? onChanged;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? titleSize;
  final Color? titleColor;
  final bool? enable;
  final int? maxLength;
  Function()? onTap;
  final String? hintText;
  final String? contentValidateEmpty;
  final double? hintSize;
  final Color? hintColor;
  final Color? errorBorderColor;
  final Color? focusBorderColor;
  final Color? borderColor;
  final String? initValue;
  final bool? isPassword;
  final double? textSize;
  final Color? textColor;
  final bool? readOnly;
  final int? maxLines;
  final bool? hasTitle;
  final TextEditingController? controller;
  final FontWeight? titleFontWeight;
  final double? suffixIconWidth;

  @override
  State<OneUiTextFormField> createState() => _OneUiTextFormFieldState();
}

class _OneUiTextFormFieldState extends State<OneUiTextFormField> {
  TextEditingController _controller = TextEditingController();
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.hasTitle == true) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: RichText(
                text: TextSpan(
                  text: widget.title ?? '',
                  style: OneUiText.common.copyWith(
                    fontSize: widget.titleSize,
                    color: widget.titleColor ?? ColorApp.textDefault,
                    fontWeight: widget.titleFontWeight ?? FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: widget.isRequired ?? false ? ' *' : '',
                      style: OneUiText.common.copyWith(
                        color: const Color(0xFFFF0000),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Read only
          TextFormField(
            autovalidateMode: AutovalidateMode.onUnfocus,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines ?? 1,
            readOnly: widget.readOnly ?? false,
            onTap: widget.onTap,
            maxLength: widget.maxLength,
            enabled: widget.enable,
            obscureText: obscureText,
            controller: widget.controller ?? _controller,
            style: TextStyle(
              fontSize: widget.textSize ?? 14,
              color: widget.textColor ?? ColorApp.textDefault,
            ),
            validator: (value) {
              if (value != null) {
                if ((widget.isRequired ?? false) && value.isEmpty) {
                  return widget.contentValidateEmpty ??
                      'Vui lòng không để trống mục này!';
                }
              }
              return null;
            },
            decoration: InputDecoration(
              isDense: true,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: widget.hintColor ?? const Color(0xFF98A0AA),
                fontSize: widget.hintSize ?? 14,
              ),
              hintText: widget.hintText,
              filled: true,
              fillColor: widget.enable ?? false
                  ? Colors.white
                  : const Color(0xFFF3F5F9),
              suffixIconConstraints:
                  BoxConstraints(maxWidth: widget.suffixIconWidth ?? 32),
              suffixIcon: widget.suffixIcon /*?? buiSuffixIcon()*/,
              prefixIcon: widget.prefixIcon,
              contentPadding: widget.contentPadding != null
                  ? EdgeInsets.all(widget.contentPadding!)
                  : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.focusBorderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xffCFDAEC),
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
/*
  Widget buiSuffixIcon() {
    return InkWell(
      onTap: () {
        if (widget.isPassword ?? false) {
          setState(() {
            obscureText = !obscureText;
          });
          return;
        }
        if (!(_controller.text == '')) {
          _controller.text = '';
          return;
        }
      },
      child: SizedBox(
        width: 8,
        height: 8,
        child: widget.isPassword ?? false
            ? (obscureText
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off))
            : (!(_controller.text == '')
                ? const Icon(Icons.close)
                : const SizedBox.shrink()),
      ),
    );
  }*/
}

class OneUiTextFormFieldPassword extends StatelessWidget {
  OneUiTextFormFieldPassword({
    super.key,
    this.title,
    this.contentPadding,
    this.borderRadius,
    this.isRequired = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.enable,
    this.maxLength,
    this.hintText,
    this.onTap,
    this.titleSize,
    this.titleColor,
    this.contentValidateEmpty,
    this.hintSize,
    this.hintColor,
    this.errorBorderColor,
    this.focusBorderColor,
    this.borderColor,
  });

  final String? title;
  final double? contentPadding;
  late bool isRequired;
  final Function(String value)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final double? borderRadius;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? titleSize;
  final Color? titleColor;
  final bool? obscureText;
  final bool? enable;
  final int? maxLength;
  Function()? onTap;
  final String? hintText;
  final String? contentValidateEmpty;
  final double? hintSize;
  final Color? hintColor;
  final Color? errorBorderColor;
  final Color? focusBorderColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: RichText(
            text: TextSpan(
              text: title ?? '',
              style: OneUiText.common.copyWith(
                fontSize: titleSize,
                color: titleColor ?? ColorApp.textDefault,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: OneUiText.common.copyWith(
                    color: const Color(0xFFFF0000),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ],
            ),
          ),
        ),
        // Read only
        TextFormField(
          onTap: onTap,
          maxLength: maxLength,
          enabled: enable,
          obscureText: obscureText ?? false,
          controller: controller,
          style: const TextStyle(fontSize: 14, color: ColorApp.textDefault),
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: textInputAction ?? TextInputAction.next,
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            if (value != null) {
              if (isRequired && value.isEmpty) {
                return contentValidateEmpty ??
                    'Vui lòng không để trống mục này!';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: hintColor ?? const Color(0xFF98A0AA),
              fontSize: hintSize ?? 14,
            ),
            hintText: hintText,
            filled: true,
            fillColor: enable ?? false ? Colors.white : const Color(0xFFF3F5F9),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: contentPadding != null
                ? EdgeInsets.all(contentPadding!)
                : const EdgeInsets.only(left: 12, right: 12, top: 9, bottom: 9),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: errorBorderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: errorBorderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: focusBorderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xffCFDAEC),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget textFieldPassword(
  Item,
  Map<String, dynamic> map,
) {
  final title = Item['title'];
  final contentPadding = Item['contentPadding'];
  final borderRadius = Item['borderRadius'];
  final isRequired = Item['isRequired'];
  final hintText = Item['hintText'];
  final titleSize = Item['titleSize'];
  final titleColor = Util.convertFromHexToColor(Item['titleSize']);
  final contentValidateEmpty = Item['contentValidateEmpty'];
  final hintSize = Item(['hintSize']);
  final hintColor = Util.convertFromHexToColor(Item['hintColor']);
  final textSize = Item['textSize'];
  final textColor = Util.convertFromHexToColor(Item['textColor']);
  final hasTitle = Item['hasTitle'];
  return OneUiTextFormField(
    hasTitle: hasTitle,
    title: title,
    contentPadding: contentPadding,
    borderRadius: borderRadius,
    isRequired: isRequired,
    onChanged: (value) {
      map[Item['key']] = value;
    },
    hintText: hintText,
    titleSize: titleSize,
    titleColor: titleColor,
    contentValidateEmpty: contentValidateEmpty,
    hintSize: hintSize,
    hintColor: hintColor,
    initValue: map[Item['key']],
    isPassword: true,
    textSize: textSize,
    textColor: textColor,
    maxLines: 1,
  );
}

Widget textField(
  Item,
  Map<String, dynamic> map,
) {
  final title = Item['title'];
  final contentPadding = Item['contentPadding'];
  final borderRadius = Item['borderRadius'];
  final isRequired = Item['isRequired'];
  final hintText = Item['hintText'];
  final titleSize = Item['titleSize'];
  final titleColor = Util.convertFromHexToColor(Item['titleColor']);
  final contentValidateEmpty = Item['contentValidateEmpty'];
  final hintSize = Item['hintSize'];
  final hintColor = Util.convertFromHexToColor(Item['hintColor']);
  final textSize = Item['textSize'];
  final textColor = Util.convertFromHexToColor(Item['textColor']);
  final hasTitle = Item['hasTitle'];
  final enable = Item['enable'];
  final maxLength = Item['maxLength'];
  final errorBorderColor = Util.convertFromHexToColor(Item['errorBorderColor']);
  final focusBorderColor = Util.convertFromHexToColor(Item['focusBorderColor']);
  final borderColor = Util.convertFromHexToColor(Item['borderColor']);
  final isPassWord = Item['isPassword'];
  final readOnly = Item['readOnly'];
  final maxLines = Item['maxLines'];
  final titleFontWeight =
      Util.convertFromStringToFontWeight(Item['titleFontWeight']);
  return OneUiTextFormField(
    title: title,
    contentPadding: contentPadding,
    borderRadius: borderRadius,
    isRequired: isRequired,
    onChanged: (value) {
      map[Item['key']] = value;
    },
    enable: enable,
    maxLength: maxLength,
    hintText: hintText,
    onTap: () {},
    titleSize: titleSize,
    titleColor: titleColor,
    contentValidateEmpty: contentValidateEmpty,
    hintSize: hintSize,
    hintColor: hintColor,
    errorBorderColor: errorBorderColor,
    focusBorderColor: focusBorderColor,
    borderColor: borderColor,
    initValue: map[Item['key']],
    isPassword: isPassWord,
    textSize: textSize,
    textColor: textColor,
    readOnly: readOnly,
    maxLines: maxLines,
    hasTitle: hasTitle,
    titleFontWeight: titleFontWeight,
  );
}
