import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_io_builder/utils/utils.dart';
import 'package:form_io_builder/widgets/image_field.dart';

import '../dynamic_form_widget/core_button.dart';
import '../dynamic_form_widget/core_selector/core_selector.dart';
import '../dynamic_form_widget/core_text.dart';
import '../dynamic_form_widget/core_text_field.dart';
import '../dynamic_form_widget/html_widget.dart';
import '../dynamic_form_widget/size.dart';
import '../dynamic_form_widget/table_widget.dart';
import 'layout_widget.dart';

List<Widget> dataBuilder(
    jsons, Map<String, dynamic> map, StreamController<dynamic> streamController,
    {pType = 1, show = false}) {
  List<Widget> listD = [];
  if (jsons != null && jsons.length > 0) {
    printO("List Json length ${jsons.length}");
    jsons.forEach((element) {
      listD.add(
        widgetBuilder(element, map,streamController, pType , show: show),
      );
    });
  } else {
    listD.add(const SizedBox());
  }

  return listD;
}

Widget widgetBuilder(itemJson, Map<String, dynamic> map,
    StreamController<dynamic> streamController, pType,
    {row, show = false}) {
  var widget;

  printO("Widegt Type ${itemJson['type']}  && Label ${itemJson['label']}");
  switch (itemJson['type']) {
    case "columns":
      widget = columns(itemJson, map, streamController, show: show);
      break;
    case "size":
      widget = size(itemJson, map);
    case "mobiletext":
      widget = text(itemJson, map);

    case "textfield":
      // if(settingRes.formTypeShow.value)
      //    widget =HtmlField(ItemJson, map, pType, row: row);
      //   else
      widget = textField(itemJson, map, streamController);
      break;

    case "password":
      // if(settingRes.formTypeShow.value)
      //   widget =HtmlField(ItemJson, map, pType, row: row);
      // else
      widget = textFieldPassword(itemJson, map, streamController);
      break;
    case "button":
      widget = button(itemJson, map);
      break;
    case "select":
      widget = selectorBox(itemJson, map, streamController);

    case "table":
      widget = tableShow(itemJson, map);
      break;

    case "panel":
      widget = panel(itemJson, map, streamController, show: show);
      break;

    case "htmlelement":
      widget = htmlElement(itemJson, pType);
      break;

    case "tabs":
      widget = taps(itemJson, map, streamController, show: show);

      break;

    case "fieldset":
      widget = fieldSet(itemJson, map, streamController, show: show);
      break;

    case "well":
      widget = panel(itemJson, map, streamController, show: show);
      break;

    case "content":
      widget = const SizedBox();
      break;

    case "tags":
      widget = const SizedBox();
      break;

    case "survey":
      widget = const SizedBox();
      break;

    case "container":
      widget = panel(itemJson, map, streamController, show: show);
      break;

    case "datamap":
      widget = const SizedBox();
      break;

    case "datagrid":
      widget = gridDataW(itemJson, map, streamController, show: show);
      break;

    case "editgrid":
      widget = panel(itemJson, map, streamController, show: show);
      break;

    case 'file':
      widget = image_wedgit(itemJson, map, pType, show: show);
      break;

    default:
      widget = const SizedBox();
      break;
  }
  return widget;
}
