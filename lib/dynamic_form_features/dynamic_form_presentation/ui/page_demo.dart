
import 'package:flutter/material.dart';

import '../../../dynamic_form_warehouse/dynamic_form_widget/core_selector/selector_model.dart';
import '../../../dynamic_form_warehouse/page_builder.dart';


class DemoPage extends StatefulWidget {
  const DemoPage({
    this.initData,
    super.key,
  });

  final Map<String, dynamic>? initData;
  @override
  State<DemoPage> createState() => _DefaultPage();
}

class _DefaultPage extends State<DemoPage> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return buildPageGenerate();
  }


  Widget buildPageGenerate() {
    return
      PageBuilder(
      formData: widget.initData ?? dataDemo,
      mapAnswers: mapAnswers,
      title: 'Gửi phản ánh kiến nghị',
      backgroundBodyColor: Colors.white,
    );
  }

  Map<String, dynamic> mapAnswers = {
    "user": '',
    "TTP": SelectorModel(),
    "QuanHuyen": SelectorModel(),
    "PhuongXa": SelectorModel(),
    "sonha": '',
    "sdt": '',
    "PAKNTitle": '',
    "PAKNContent": '',
  };

  Map<String, dynamic> dataDemo = {
    "display": "wizard",
    "components": [
      {
        "title": "Thông tin cơ quan tiếp nhận",
        "label": "Page 1",
        "type": "panel",
        "key": "page1",
        "components": [
          {
            "label": "Columns",
            "columns": [
              {
                "components": [
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "DTPAKN",
                    "title": "Đối tượng PAKN",
                    "type": "selectorBox",
                    "hintText": "Chọn đối tượng PAKN",
                    "dataSrc": "url",
                    "data": {
                      "url":
                          "https://ttdl-gateway.vnpt.vn/category/v1/category/by-code?code=DANTOC",
                      "headers": [
                        {"key": "", "value": ""}
                      ],
                      "request": null,
                    },
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "contentPadding": null,
                    "textSize": null,
                    "textColor": null,
                    "isRequired": true,
                    "enable": null,
                    "maxLines": null,
                    "isShowSearch": true,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "user",
                    "title": "Người dân",
                    "type": "textfield",
                    "contentPadding": null,
                    "isRequired": true,
                    "enable": true,
                    "maxLength": null,
                    "hintText": "Nhập tên người phản ánh",
                    "contentValidateEmpty":
                        "Tên người phản ánh không được để trống",
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "isPassword": false,
                    "textSize": null,
                    "textColor": null,
                    "readOnly": false,
                    "maxLines": 1,
                  },
                  {
                    "type": "text",
                    "key": "Address",
                    "title": "Địa chỉ",
                    "titleColor": "#000000",
                    "titleSize": 14.0,
                    "fontWeight": "bold",
                  },
                  {
                    "type": "size",
                    "key": "Height",
                    "height": 12.0,
                    "width": 12.0,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "TTP",
                    "title": "Tỉnh/thành phố",
                    "type": "selectorBox",
                    "hintText": "Chọn Tỉnh/thành phố",
                    "dataSrc": "url",
                    "data": {
                      "url":
                          "https://ttdl-gateway.vnpt.vn/category/v1/donvi-hanhchinh/tinh-tp",
                      "headers": [
                        {"key": "", "value": ""}
                      ],
                      "request": null,
                    },
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "contentPadding": null,
                    "textSize": null,
                    "textColor": null,
                    "isRequired": true,
                    "enable": null,
                    "maxLines": null,
                    "isShowSearch": true,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "partnerMap": "TTP",
                    "hasTitle": true,
                    "key": "QuanHuyen",
                    "title": "Quân/Huyện",
                    "type": "selectorBox",
                    "hintText": "Chọn Quận/Huyện",
                    "dataSrc": "url",
                    "data": {
                      "url":
                          "https://ttdl-gateway.vnpt.vn/category/v1/donvi-hanhchinh/quan-huyen",
                      "headers": [
                        {"key": "", "value": ""}
                      ],
                      "request": [
                        {"key": "tinhTpId", "value": "id"},
                        {"key": "tinhTpCode", "value": "ma"},
                      ]
                    },
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "contentPadding": null,
                    "textSize": null,
                    "textColor": null,
                    "isRequired": true,
                    "enable": null,
                    "maxLines": null,
                    "isShowSearch": true,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "partnerMap": "QuanHuyen",
                    "hasTitle": true,
                    "key": "PhuongXa",
                    "title": "Phường/Xã",
                    "type": "selectorBox",
                    "hintText": "Chọn Phường/Xã",
                    "dataSrc": "url",
                    "data": {
                      "url":
                          "https://ttdl-gateway.vnpt.vn/category/v1/donvi-hanhchinh/phuong-xa",
                      "headers": [
                        {"key": "", "value": ""}
                      ],
                      "request": [
                        {"key": "quanHuyenId", "value": "id"},
                        {"key": "quanHuyenCode", "value": "ma"},
                      ],
                    },
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "contentPadding": null,
                    "textSize": null,
                    "textColor": null,
                    "isRequired": true,
                    "enable": null,
                    "maxLines": null,
                    "isShowSearch": true,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "diachichitiet",
                    "title": "Địa chỉ chi tiết",
                    "type": "textfield",
                    "contentPadding": null,
                    "isRequired": true,
                    "enable": true,
                    "maxLength": null,
                    "hintText": "Nhập đại chỉ chi tiết",
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "isPassword": false,
                    "textSize": null,
                    "textColor": null,
                    "readOnly": false,
                    "maxLines": 1,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "sdt",
                    "title": "Số điện thoại",
                    "type": "textfield",
                    "contentPadding": null,
                    "isRequired": true,
                    "enable": true,
                    "maxLength": null,
                    "hintText": "Nhập số điện thoại",
                    "contentValidateEmpty": null,
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "isPassword": false,
                    "textSize": null,
                    "textColor": null,
                    "readOnly": false,
                    "maxLines": 1,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "sdt",
                    "title": "Email",
                    "type": "textfield",
                    "contentPadding": null,
                    "isRequired": false,
                    "enable": true,
                    "maxLength": null,
                    "hintText": "Nhập email",
                    "contentValidateEmpty": "",
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "isPassword": false,
                    "textSize": null,
                    "textColor": null,
                    "readOnly": false,
                    "maxLines": 1,
                  },
                  {
                    "titleColor": "#696969",
                    "titleSize": 14.0,
                    "titleFontWeight": "normal",
                    "hintSize": 14.0,
                    "borderRadius": 4.0,
                    "hintColor": "#92969C",
                    "hasTitle": true,
                    "key": "PAKNContent",
                    "title": "Nội dung",
                    "type": "textfield",
                    "contentPadding": null,
                    "isRequired": true,
                    "enable": true,
                    "maxLength": null,
                    "hintText": "Nhập nội dung",
                    "contentValidateEmpty": "Nội dung PAKN không được để trống",
                    "errorBorderColor": "#D4D7DA",
                    "focusBorderColor": "#D4D7DA",
                    "borderColor": "#D4D7DA",
                    "isPassword": false,
                    "textSize": null,
                    "textColor": null,
                    "readOnly": false,
                    "maxLines": 4,
                  },
                  {
                    "type": "text",
                    "key": "news",
                    "title":
                        "Nội dung này sẽ được công khai, vui lòng không ghi chi tiết thông tin cá nhân",
                    "titleColor": "#C10800",
                    "titleSize": 14.0,
                    "fontWeight": "normal",
                  },
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
        ],
        "input": false,
        "tableView": false,
        "breadcrumbClickable": true,
        "buttonSettings": {
          "previous": true,
          "cancel": true,
          "next": true
        },
        "navigateOnEnter": false,
        "saveOnEnter": false,
        "scrollToTop": false,
        "collapsible": false,
        "description": "Chưa thực hiện",
        "collapsed": false,
        "showtitleMenu": true,
        "titleMenu": "Các bước thực hiện",
        "customguide": "Hướng dẫn Công dân kiểm tra lại thông tin cơ quan tiếp nhận. Nhấn chọn Tiếp theo và thực hiện các bước để hoàn thành quá trình nộp hồ sơ.",
        "customConditional": "",
        "customperformed": "Đang thực hiện"
      },
    ]
  };
}
