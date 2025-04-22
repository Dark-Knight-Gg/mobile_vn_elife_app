import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dynamic_form_features/dynamic_form_utilities/color_app.dart';
import 'dynamic_form_warehouse/dynamic_form_widget/core_text.dart';

ThemeData theme(
    {required String fontName,
    required String package,
    required color,
    required bool useMaterial3}) {
  return ThemeData(
    useMaterial3: useMaterial3,
    scaffoldBackgroundColor: color,
    fontFamily: fontName,
    appBarTheme: appBarTheme(),
    package: package,
    textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    canvasColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    checkboxTheme: checkboxTheme(),
    radioTheme: radioTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    cardTheme: cardTheme(),
  );
}

CheckboxThemeData checkboxTheme() {
  return CheckboxThemeData(
    fillColor: MaterialStateProperty.all(ColorApp.color1856BD),
  );
}

RadioThemeData radioTheme() {
  return RadioThemeData(
    fillColor: MaterialStateProperty.all(ColorApp.color036BCB),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    // content padding
    errorMaxLines: 2,
    contentPadding: const EdgeInsets.all(8),
    // hint style
    hintStyle:
        OneUiText().getRegularStyle(color: ColorApp.colorADB5BE, fontSize: 14),
    labelStyle:
        OneUiText().getMediumStyle(color: ColorApp.textDefault, fontSize: 14),
    errorStyle: OneUiText().getRegularStyle(color: Colors.red),
    // enabled border style
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorApp.colorCFDAEC, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    // focused border style
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorApp.colorCFDAEC, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    // error border style
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorApp.colorCFDAEC, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    // focused border style
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorApp.colorCFDAEC, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8))),
  );
}

TextTheme textTheme() {
  return
      //  TextTheme(
      //   bodyLarge: OneUiText.textStyleThem(),
      //   // bodyMedium: OneUiText.textStyleThem(),
      TextTheme(
    displayLarge:
        OneUiText().getSemiBoldStyle(color: ColorApp.textDefault, fontSize: 20),
    headlineLarge:
        OneUiText().getSemiBoldStyle(color: ColorApp.textDefault, fontSize: 16),
    headlineMedium:
        OneUiText().getRegularStyle(color: ColorApp.textDefault, fontSize: 14),
    titleMedium:
        OneUiText().getMediumStyle(color: ColorApp.textDefault, fontSize: 16),
    titleSmall:
        OneUiText().getRegularStyle(color: ColorApp.textDefault, fontSize: 16),
    bodyLarge: OneUiText().getRegularStyle(color: ColorApp.color7D8798),
    bodySmall: OneUiText().getRegularStyle(color: Colors.white),
    bodyMedium:
        OneUiText().getMediumStyle(color: ColorApp.textDefault, fontSize: 14),
    labelMedium: OneUiText().getMediumStyle(color: Colors.white, fontSize: 14),
    labelLarge: OneUiText().getRegularStyle(color: ColorApp.textDefault),
    labelSmall:
        OneUiText().getBoldStyle(color: ColorApp.textDefault, fontSize: 12),
  );
}

CardTheme cardTheme() {
  return const CardTheme(
      surfaceTintColor: Colors.white,
      color: ColorApp.colorF3F5F9,
      shadowColor: ColorApp.color000000,
      elevation: 4);
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    scrolledUnderElevation: 0,
    // Không cho app bar bị đổi sẫm màu khi vuốt lên
    color: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
    systemOverlayStyle:
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
}

ButtonThemeData buttonTheme() {
  return const ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: ColorApp.textDefault,
    buttonColor: ColorApp.textDefault,
    splashColor: ColorApp.textDefault,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle:
              OneUiText().getMediumStyle(color: Colors.white, fontSize: 14),
          backgroundColor: ColorApp.color1856BD,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: ColorApp.color1856BD))));
}
