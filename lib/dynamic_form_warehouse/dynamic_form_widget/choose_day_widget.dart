// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_vn_elife_app/dynamic_form_features/dynamic_form_extensions/extension_context.dart';

import '../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import '../../dynamic_form_features/dynamic_form_utilities/date_util.dart';

class ChooseDayWidget extends StatefulWidget {
  late DateTime? selectedDate;
  late String hintText;
  final bool isRequired;
  final ValueChanged? onChangedDay;
  final bool isShowHideIcon;
  final bool isYear;

  ChooseDayWidget({
    super.key,
    this.onChangedDay,
    this.isRequired = false,
    this.hintText = "",
    this.selectedDate,
    this.isShowHideIcon = false,
    this.isYear = false,
  });

  @override
  State<ChooseDayWidget> createState() => _ChooseDayWidgetState();
}

class _ChooseDayWidgetState extends State<ChooseDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        SizedBox(
            // height: 40,
            child: InkWell(
                onTap: () {
                  if (widget.isYear) {
                    _selectTimeYear();
                  } else {
                    _selectTime();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                          widget.hintText == ""
                              ? DateUtil.stringFromDate(
                                  widget.isYear ? "yyyy" : "dd/MM/yyyy",
                                  widget.selectedDate ?? DateTime.now())
                              : widget.hintText,
                          style: widget.hintText == ""
                              ? context.getTextTheme().headlineMedium
                              : context.getiInputDecorationTheme().hintStyle),
                      const Spacer(),
                      Visibility(
                        visible: widget.isShowHideIcon,
                        child: const Icon(
                          Icons.calendar_month,
                          color: ColorApp.textLightGrey,
                        ),
                      )
                    ],
                  ),
                ))),
      ],
    );
  }

  Future<void> _selectTime() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        confirmText: "XÁC NHẬN",
        cancelText: "HUỶ",
        helpText: "CHỌN NGÀY",
        firstDate: DateTime(1900),
        fieldHintText: "dd/MM/yyyy",
        lastDate: DateTime(2099));
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.hintText = "";
        widget.selectedDate = picked;
      });
      widget.onChangedDay!(DateUtil.stringFromDate(
          "dd/MM/yyyy", widget.selectedDate ?? DateTime.now()));
    }
  }

  Future<void> _selectTimeYear() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("CHỌN NĂM"),
              content: SizedBox(
                  width: 300,
                  height: 300,
                  child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year + 100, 1),
                      currentDate: DateTime.now(),
                      selectedDate: widget.selectedDate ?? DateTime.now(),
                      onChanged: (DateTime dateTime) {
                        setState(() {
                          widget.hintText = "";
                          widget.selectedDate = dateTime;
                        });
                        widget.onChangedDay!(DateUtil.stringFromDate(
                            "yyyy", widget.selectedDate ?? DateTime.now()));
                        context.popNav();
                      })));
        });
  }
}

class ChooseWidget extends StatefulWidget {
  late DateTime? selectedDate;
  late String hintText;
  final bool isRequired;
  final ValueChanged? onChangedDay;
  final bool isShowHideIcon;
  final bool isYear;
  final bool isReadOnly;
  final double width;
  final double height;
  final String? Function(String?)? validator;
  final DateTime? lastDate;

  ChooseWidget({
    super.key,
    this.onChangedDay,
    this.isRequired = false,
    this.hintText = "",
    this.selectedDate,
    this.isShowHideIcon = false,
    this.isYear = false,
    this.isReadOnly = false,
    this.width = 100,
    this.height = 40,
    this.validator,
    this.lastDate,
  });

  @override
  State<ChooseWidget> createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = widget.selectedDate == null
        ? ''
        : DateUtil.stringFromDate(
            widget.isYear ? "yyyy" : "dd/MM/yyyy",
            widget.selectedDate ??
                DateUtil.previousNumberDay(DateTime.now(), 1));
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          child: Column(
            children: [
              TextFormField(
                validator: widget.validator,
                controller: controller,
                readOnly: true,
                style: context.getTextTheme().headlineMedium,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: Visibility(
                    visible: widget.isShowHideIcon,
                    child: const Icon(Icons.calendar_month,
                        color: ColorApp.textLightGrey),
                  ),
                  filled: true,
                  fillColor: widget.isReadOnly
                      ? const Color(0xffF3F5F9)
                      : Colors.white, //
                ),
              ),
            ],
          ),
        ),
        InkWell(
            onTap: () {
              if (widget.isYear) {
                _selectTimeYear();
              } else {
                _selectTime();
              }
            },
            child: Container(
              color: Colors.transparent,
              height: widget.height,
              width: double.infinity,
            )),
      ],
    );
  }

  Future<void> _selectTime() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        confirmText: "XÁC NHẬN",
        cancelText: "HUỶ",
        helpText: "CHỌN NGÀY",
        // fieldHintText: widget.isYear ? "yyyy" : "dd/MM/yyyy",
        fieldLabelText: 'Nhập ngày',
        errorFormatText: 'Vui lòng nhập đúng định dạng!',
        errorInvalidText: 'Dữ liệu không hợp lệ',
        firstDate: DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2099));
    if (picked != null && picked != widget.selectedDate) {
      controller.text = DateUtil.stringFromDate(
          widget.isYear ? "yyyy" : "dd/MM/yyyy", picked);
      widget.selectedDate = picked;
      widget.onChangedDay!(DateUtil.stringFromDate(
          widget.isYear ? "yyyy" : DateUtil.FORMAT_DAY_HOUR_APP_T,
          widget.selectedDate ??
              DateUtil.previousNumberDay(DateTime.now(), 1)));
    }
  }

  Future<void> _selectTimeYear() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("CHỌN NĂM"),
              content: SizedBox(
                  width: 300,
                  height: 300,
                  child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: widget.lastDate ??
                          DateTime(DateTime.now().year + 100, 1),
                      currentDate: DateTime.now(),
                      selectedDate: widget.selectedDate ?? DateTime.now(),
                      onChanged: (DateTime dateTime) {
                        controller.text = DateUtil.stringFromDate(
                            widget.isYear ? "yyyy" : "dd/MM/yyyy", dateTime);
                        widget.selectedDate = dateTime;
                        widget.onChangedDay!(DateUtil.stringFromDate(
                            "yyyy",
                            widget.selectedDate ??
                                DateUtil.previousNumberDay(DateTime.now(), 1)));
                        context.popNav();
                      })));
        });
  }
}
