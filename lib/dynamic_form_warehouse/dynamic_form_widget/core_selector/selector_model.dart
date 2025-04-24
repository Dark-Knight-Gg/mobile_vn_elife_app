import 'dart:convert';

import 'package:equatable/equatable.dart';

class SelectorModel extends Equatable{
  SelectorModel({
    this.id,
    this.name,
    this.ten,
    this.code,
    this.ma,
  });

  final int? id;
  final String? name;
  final String? ten;
  final String? code;
  final String? ma;

  factory SelectorModel.fromJson(Map<String, dynamic> json) => SelectorModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        ten: json['ten'] as String?,
        code: json['code'] as String?,
        ma: json['ma'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'ten': ten,
        'code': code,
        'ma': ma,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
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

/*class Data {
  String? lastModifiedDate;
  int id;
  String name;
  String code;
  String? address;
  int status;
  String? provinceId;
  String? districtId;
  String? communeId;
  String? provinceName;
  DateTime? communeName;
  int? agencyType;
  String? phone;
  String path;
  int capdonviId;
  int loaicoquanId;
  String? diemthuchien;
  String? createdBy;
  String? lastModifiedBy;
  String? email;

  Data({
    this.lastModifiedDate,
    required this.id,
    required this.name,
    required this.code,
    this.address,
    required this.status,
    this.provinceId,
    this.districtId,
    this.communeId,
    this.provinceName,
    this.communeName,
    this.agencyType,
    this.phone,
    required this.path,
    required this.capdonviId,
    required this.loaicoquanId,
    this.diemthuchien,
    this.createdBy,
    this.lastModifiedBy,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lastModifiedDate: json["lastModifiedDate"],
    id: json["id"],
    name: json["name"],
    code: json["code"],
    address: json["address"],
    status: json["status"],
    provinceId: json["provinceId"],
    districtId: json["districtId"],
    communeId: json["communeId"],
    provinceName: json["provinceName"],
    communeName: json["communeName"] == null ? null : DateTime.parse(json["communeName"]),
    agencyType: json["agencyType"],
    phone: json["phone"],
    path: json["path"],
    capdonviId: json["capdonviId"],
    loaicoquanId: json["loaicoquanId"],
    diemthuchien: json["diemthuchien"],
    createdBy: json["createdBy"],
    lastModifiedBy: json["lastModifiedBy"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "lastModifiedDate": lastModifiedDate,
    "id": id,
    "name": name,
    "code": code,
    "address": address,
    "status": status,
    "provinceId": provinceId,
    "districtId": districtId,
    "communeId": communeId,
    "provinceName": provinceName,
    "communeName": communeName?.toIso8601String(),
    "agencyType": agencyType,
    "phone": phone,
    "path": path,
    "capdonviId": capdonviId,
    "loaicoquanId": loaicoquanId,
    "diemthuchien": diemthuchien,
    "createdBy": createdBy,
    "lastModifiedBy": lastModifiedBy,
    "email": email,
  };
}*/
