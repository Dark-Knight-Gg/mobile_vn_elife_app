import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import 'core_button.dart';
import 'core_text.dart';

const DIALOG_SUCCESS = "DIALOG_SUCCESS";
const DIALOG_WARRING = "DIALOG_WARRING";
const DIALOG_ERROR = "DIALOG_ERROR";
const DIALOG_REMIND = "DIALOG_REMIND";

class OneUiDialog {
  static bool isCheckShowPopup = false;
  static showDialogByType(
      {required BuildContext context,
      required String type,
      String? title,
      String? titleAction,
      String? content,
      bool barrierDismissible = true,
      bool isHidenClose = false,
      Function()? buttonCallback}) {
    if (!isCheckShowPopup) {
      isCheckShowPopup = true;
      showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (BuildContext context) {
            return DialogByType(
              title: title ?? "Thông báo",
              content: content ?? '',
              type: type,
              buttonCallback: buttonCallback,
              isHidenClose: isHidenClose,
              titleAction: titleAction,
            );
          }).then((value) {
        isCheckShowPopup = false;
      });
    }
  }

  static showDialogModule({
    required BuildContext context,
    required Widget header,
    required Widget body,
    required List<Widget> actions,
    BorderRadiusGeometry? borderRadius,
    double elevation = 0,
    double? widthSize,
    double? heightSize,
    double minWidth = 280,
    double maxWidth = 400,
    double minHeight = 50,
    double maxHeight = double.infinity / 1.2,
    double blurRadius = 10,
    Color backgroundColor = Colors.transparent,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogModule(
              header: header,
              body: body,
              actions: actions,
              borderRadius: borderRadius,
              elevation: elevation,
              widthSize: widthSize,
              heightSize: heightSize,
              minWidth: minWidth,
              maxWidth: maxWidth,
              minHeight: minHeight,
              maxHeight: maxHeight,
              blurRadius: blurRadius,
              backgroundColor: backgroundColor,
              padding: padding);
        });
  }
}

class DialogByType extends StatefulWidget {
  final int colorShadow = 0xff595959;
  final String title, content;
  final String type;
  String? titleAction;
  Function()? buttonCallback;
  bool isHidenClose = false;

  DialogByType(
      {Key? key,
      required this.type,
      required this.title,
      this.content = "",
      this.buttonCallback,
      this.titleAction,
      this.isHidenClose = false})
      : super(key: key);

  @override
  DialogByTypeState createState() => DialogByTypeState();
}

class DialogByTypeState extends State<DialogByType> {
  bool get isHidenClose => widget.isHidenClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Color(widget.colorShadow),
                        offset: const Offset(0, 8),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 15),
                    child: SvgPicture.asset(
                        widget.type == DIALOG_SUCCESS
                            ? 'assets/images/ic_success_dialog.svg'
                            : widget.type == DIALOG_ERROR
                                ? 'assets/images/ic_error_dialog.svg'
                                : widget.type == DIALOG_WARRING
                                    ? 'assets/images/ic_warring_dialog.svg'
                                    : widget.type == DIALOG_REMIND
                                        ? 'assets/images/ic_remind.svg'
                                        : 'assets/images/ic_success_dialog.svg',
                        package: 'cdv_utilities',
                        width: 120,
                        height: 120),
                  ),
                  Text(widget.title,
                      style: OneUiText.common
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 20)),
                  const SizedBox(height: 8),
                  Text(widget.content,
                      style: OneUiText.common.copyWith(
                          color: ColorApp.textGrey,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: OneUiButton(
                      title: (widget.titleAction ?? '').isEmpty
                          ? widget.type == DIALOG_ERROR
                              ? 'Thử lại'
                              : 'Tiếp tục'
                          : widget.titleAction ?? '',
                      onPress: () {
                        Navigator.pop(context);
                        widget.buttonCallback != null
                            ? widget.buttonCallback!()
                            : null;
                      },
                      backgroundColor: const Color(0xFF1856BD),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 15,
                right: 15,
                child: Visibility(
                  visible: !isHidenClose,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close,
                          color: Color(0xFF6D6D6D))),
                )),
          ],
        ),
      ),
    );
  }
}

class DialogModule extends StatefulWidget {
  final int colorShadow = 0xff595959;
  final Widget header;
  final Widget body;
  final List<Widget> actions;
  final BorderRadiusGeometry? borderRadius;
  final double elevation;
  final double? widthSize;
  final double? heightSize;
  final double minWidth, maxWidth;
  final double minHeight, maxHeight;
  late double blurRadius;
  late Color backgroundColor;
  late EdgeInsetsGeometry padding;

  DialogModule(
      {Key? key,
      required this.header,
      required this.body,
      required this.actions,
      this.borderRadius,
      this.elevation = 0,
      this.widthSize,
      this.heightSize,
      this.minWidth = 280,
      this.maxWidth = 400,
      this.maxHeight = double.infinity / 1.2,
      this.minHeight = 50,
      this.blurRadius = 10,
      this.backgroundColor = Colors.transparent,
      this.padding = const EdgeInsets.all(16)})
      : super(key: key);

  @override
  DialogModuleState createState() => DialogModuleState();
}

class DialogModuleState extends State<DialogModule> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
      ),
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColor,
      child: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.widthSize ?? widget.minWidth,
        maxWidth: widget.widthSize ?? widget.maxWidth,
        minHeight: widget.heightSize ?? widget.minHeight,
        maxHeight: widget.heightSize ?? widget.maxHeight,
      ),
      child: Container(
        width: widget.widthSize,
        height: widget.heightSize,
        padding: widget.padding,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Color(widget.colorShadow),
                  offset: const Offset(0, 8),
                  blurRadius: widget.blurRadius),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.header,
            widget.body,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.actions,
            )
          ],
        ),
      ),
    );
  }
}
