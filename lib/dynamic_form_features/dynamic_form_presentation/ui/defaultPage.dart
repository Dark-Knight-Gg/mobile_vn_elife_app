import 'package:flutter/material.dart';

import '../../../dynamic_form_warehouse/page_builder.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPage();
}

class _DefaultPage extends State<DefaultPage> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return buildPageGenerate();
  }

  Widget buildPageGenerate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildForm(),
        buildMenu(),
      ],
    );
  }

  Widget buildForm() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF0F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: PageBuilder(formData: formData, mapAnswers: mapAnswers),
    );
  }

  Widget buildMenu() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF0F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: PageBuilder(formData: menuData, mapAnswers: mapAnswers),
    );
  }

  Map<String, dynamic> mapAnswers = {
    "username": "",
    "password": "",
  };
  Map<String, dynamic>? menuData = {
    "display": "form",
    "components": [
      {
        "label": "Columns",
        "columns": [
          {
            "components": [
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 1",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page1",
              },
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 2",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page2",
              },
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 3",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page3",
              }
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          }
        ],
        "key": "columns",
        "type": "columns",
        "input": false,
        "tableView": false
      }
    ]
  };
  final formData = {
    "display": "form",
    "components": [
      {
        "label": "Columns",
        "columns": [
          {
            "components": [
              {
                "label": "Text Field",
                "applyMaskOn": "change",
                "tableView": true,
                "validateWhenHidden": false,
                "key": "username",
                "type": "username",
                "input": true,
                "hintTextFiled": "userName",
              },
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          },
          {
            "components": [
              {
                "label": "Text Field",
                "applyMaskOn": "change",
                "tableView": true,
                "validateWhenHidden": false,
                "key": "password",
                "type": "password",
                "input": true,
                "hintTextFiled": "password",
              }
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          },
        ],
        "key": "columns",
        "type": "columns",
        "input": false,
        "tableView": false
      }
    ]
  };
  final dataDemo = {
    "display": "form",
    "components": [
      {
        "label": "Columns",
        "columns": [
          {
            "components": [
              {
                "label": "Text Field",
                "applyMaskOn": "change",
                "tableView": true,
                "validateWhenHidden": false,
                "key": "username",
                "type": "username",
                "input": true,
                "hintTextFiled": "userName",
              },
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          },
          {
            "components": [
              {
                "label": "Text Field",
                "applyMaskOn": "change",
                "tableView": true,
                "validateWhenHidden": false,
                "key": "password",
                "type": "password",
                "input": true,
                "hintTextFiled": "password",
              }
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          },
          {
            "components": [
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 1",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page1",
              },
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 2",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page2",
              },
              {
                "icon": null,
                "labelColor": null,
                "labelSize": null,
                "labelFontWeight": null,
                "label": "Page 3",
                "key": "navigate",
                "type": "navigate",
                "pageRoute": "/Page3",
              }
            ],
            "width": 6,
            "offset": 0,
            "push": 0,
            "pull": 0,
            "size": "md",
            "currentWidth": 6
          }
        ],
        "key": "columns",
        "type": "columns",
        "input": false,
        "tableView": false
      }
    ]
  };
  final data = {
    "label": "Table",
    "cellAlignment": "left",
    "key": "table",
    "type": "table",
    "input": false,
    "tableView": false,
    "rows": [
      [
        {
          "components": [
            {
              "label": "Text Field",
              "applyMaskOn": "change",
              "tableView": true,
              "validateWhenHidden": false,
              "key": "username",
              "type": "username",
              "input": true
            },
            {
              "label": "Text Field",
              "applyMaskOn": "change",
              "tableView": true,
              "validateWhenHidden": false,
              "key": "password",
              "type": "password",
              "input": true
            }
          ]
        }
      ],
/*      [
        {
          "components": [
            {
              "label": "Data Grid",
              "reorder": false,
              "addAnotherPosition": "bottom",
              "layoutFixed": false,
              "enableRowGroups": false,
              "initEmpty": false,
              "tableView": false,
              "defaultValue": [{}],
              "validateWhenHidden": false,
              "key": "dataGrid",
              "type": "datagrid",
              "input": true,
              "components": [
                {
                  "label": "Page 1",
                  "key": "navigate",
                  "type": "navigate",
                  "pageRoute": "/Page1",
                },
                {
                  "label": "Page 2",
                  "key": "navigate",
                  "type": "navigate",
                  "pageRoute": "/Page2",
                },
                {
                  "label": "Page 3",
                  "key": "navigate",
                  "type": "navigate",
                  "pageRoute": "/Page3",
                }
              ]
            }
          ]
        }
      ]*/
    ],
    "numCols": 1,
    "numRows": 2
  };
}
