import 'dart:convert';

import 'package:equatable/equatable.dart';

class SelectorModel extends Equatable{
  SelectorModel({
    this.id,
    this.name,
    this.ten,
    this.code,
    this.ma,
    this.label,
    this.value,
  });

  final int? id;
  final String? name;
  final String? ten;
  final String? code;
  final String? ma;
  final String? label;
  final String? value;

  factory SelectorModel.fromJson(Map<String, dynamic> json) => SelectorModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        ten: json['ten'] as String?,
        code: json['code'] as String?,
        ma: json['ma'] as String?,
        label: json['label'] as String?,
        value: json['value'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'ten': ten,
        'code': code,
        'ma': ma,
        'label': label,
        'value': value,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  static List<SelectorModel> convertToSelectedModelList(
    List<Map<String, dynamic>>? maps,
  ) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((e) => SelectorModel.fromJson(e)).toList();
  }
}
// To parse this JSON data, do
//
//     final selectModelResponse = selectModelResponseFromJson(jsonString);

SelectModelResponse selectModelResponseFromJson(String str) =>
    SelectModelResponse.fromJson(json.decode(str));

String selectModelResponseToJson(SelectModelResponse data) =>
    json.encode(data.toJson());

class SelectModelResponse {
  String errCode;
  String message;
  List<SelectorModel> data;

  SelectModelResponse({
    required this.errCode,
    required this.message,
    required this.data,
  });

  factory SelectModelResponse.fromJson(Map<String, dynamic> json) =>
      SelectModelResponse(
        errCode: json["err_code"],
        message: json["message"],
        data: List<SelectorModel>.from(
            json["data"].map((x) => SelectorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

