import 'package:flutter/material.dart';
import 'package:mobile_vn_elife_app/dynamic_form_features/dynamic_form_extensions/extension_context.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_widget/core_selector/selector_model.dart';
import '../../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import '../core_text.dart';
import '../core_text_field.dart';

class SelectorBottomSheet extends StatefulWidget {
  const SelectorBottomSheet({
    this.intValue,
    this.data,
    this.onChange,
    this.textSize,
    this.textColor,
    this.isShowSearch,
    super.key,
  });

  final SelectorModel? intValue;
  final List<SelectorModel>? data;
  final Function(SelectorModel? value)? onChange;
  final double? textSize;
  final Color? textColor;
  final bool? isShowSearch;

  @override
  State<SelectorBottomSheet> createState() => _SelectorBottomSheetState();
}

class _SelectorBottomSheetState extends State<SelectorBottomSheet> {
  late List<SelectorModel>? _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isShowSearch == true) ...[
          buildSearchWidget(),
        ],
        Expanded(
          child: ListView.builder(
            itemCount: _data?.length,
            itemBuilder: (context, index) {
              final item = _data?[index];
              final isSelected = item?.id == widget.intValue?.id;
              return buildItemSelector(item, isSelected);
            },
          ),
        ),
      ],
    );
  }

  Widget buildItemSelector(SelectorModel? model, bool isSelected) {
    return InkWell(
      onTap: () {
        widget.onChange?.call(model);
        context.popNav();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? ColorApp.colorF0F6FF : Colors.white,
        ),
        child: OneUiText.textWidget(
          title: model?.name ?? model?.ten ?? '',
          fontSize: widget.textSize ?? 14,
          color: isSelected
              ? ColorApp.brand
              : widget.textColor ?? ColorApp.color1A2A45,
        ),
      ),
    );
  }

  Widget buildSearchWidget() {
    return OneUiTextFormField(
      prefixIcon: buildPrefixIcon(),
      maxLines: 1,
      hintText: 'Tìm kiếm',
      readOnly: false,
      enable: true,
      borderColor: ColorApp.color928E85,
      errorBorderColor: ColorApp.color928E85,
      focusBorderColor: ColorApp.color928E85,
      contentValidateEmpty: '',
      onChanged: (value) {
        handleSearch(value);
      },
    );
  }

  Widget buildPrefixIcon() {
    return const Icon(
      Icons.search_outlined,
      color: ColorApp.color928E85,
      size: 16,
    );
  }

  void handleSearch(String keySearch) {
    final localData = widget.data;
    if (localData != null) {
      final newData = [
        ...localData.where((element) =>
            element.name!.contains(keySearch) ||
            element.ten!.contains(keySearch))
      ];
      setState(() {
        _data = newData;
      });
      return;
    }
  }
}
