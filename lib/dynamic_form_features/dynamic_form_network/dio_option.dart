// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, unused_local_variable, constant_identifier_names, unrelated_type_equality_checks, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../dynamic_form_utilities/util.dart';



const HANDLE401 =
    "Phiên đăng nhập bị hết hạn, vui lòng đăng nhập lại để sử dụng";
const NO_INTERNET =
    "Không thể kết nối tới máy chủ. Vui lòng kiểm tra lại kết nối Internet.";
const PROJECT_NAME_DEV = "vnpt_work_dev";
const PROJECT_NAME_PROD = "vnpt_work_prod";

class DioOption {
  Dio? client;
  int refreshTokenNumber = 0;

  Dio createDio({xFormUrl = false, addToken = true}) {
    refreshTokenNumber = 0;
    client = Dio();
    client!.options.connectTimeout = const Duration(milliseconds: 10000);
    client!.interceptors
      ..clear()
      ..add(QueuedInterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
        // options.headers.addAll({'Accept': '*/*'});
        // if (options.method == "GET") {
        if (xFormUrl == true) {
          options.headers
              .addAll({'content-type': 'application/x-www-form-urlencoded'});
        } else {
          options.headers
              .addAll({'Content-Type': 'application/json ; charset=utf-8'});
        }
        if (addToken) {
          getAccessToken(options);
        }

        // //setXAppData(options);
        return handler.next(options);
      }, onResponse: (Response response, handler) async {
        try {
          if (response.data is String) {
            try {
              response.data = json.decode(response.data);
            } catch (e) {
              debugPrint("Lôĩ dio $e");
            }
          }
        } catch (e) {
          debugPrint("Lôĩ dio $e");
        }

        return handler.next(response);
      }, onError: (DioException error, handler) async {
        // Do something with response error
        var connectInternet = true;
        try {
          final result = await InternetAddress.lookup('google.com.vn');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
        } on SocketException catch (_) {
          debugPrint('not connected');
          try {} on SocketException catch (_) {
            connectInternet = false;
          }
        }
        if (connectInternet == false) {
          error = error.copyWith(message: NO_INTERNET);
        } else {
          // error.error =
          //     "Có lỗi trong quá trình xử lý. Bạn vui lòng thực hiện lại hoặc báo với nhân viên kỹ thuật để được hỗ trợ";
          if (error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.connectionTimeout) {
            error =
                error.copyWith(message: "Đã hết thời gian kết nối tới máy chủ");
          } else if (error.type == DioExceptionType.badResponse) {
            switch (error.response!.statusCode) {
              // case 400:
              //  await refreshToken(addToken, error, handler);
              //  break
              case 401:
                // error.error = 'Trang truy cập bị từ chối.';
                // break;
                // await refreshToken(error);
                // return handler.next(error);
                error = error.copyWith(message: HANDLE401);
                return handler.next(initException(error));
              case 404:
                error =
                    error.copyWith(message: 'Trang truy cập không tồn tại.');
                return handler.next(initException(error));
              default:
                return handler.next(initException(error));
            }
          }
        }
        return handler.next(initException(error));
        // CustomDioError(error, error.requestOptions);
      }));
    client!.interceptors.add(
      LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
          logPrint: printWrapped),
    );
    if (Platform.isAndroid) {
      client?.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client =
              HttpClient(context: SecurityContext(withTrustedRoots: false));
          client.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return client;
        },
      );
    }
    return client!;
  }

  Future<void> getAccessToken(RequestOptions options) async {
    options.headers.addAll({'X-Authentication-Token': 'token'});
  }

  Future<void> setXAppData(RequestOptions options) async {
    List<Map<String, dynamic>> xdata = [];
    try {
      if (xdata.isNotEmpty) {
        options.headers.addAll({'x-app': json.encode(xdata)});
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  void printWrapped(Object object) {
    String text = object.toString();
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }
}

DioException initException(DioException dioError) {
  try {
    if (dioError.response != null) {
      if (dioError.response != null &&
          dioError.response!.data != null &&
          dioError.response!.data is Map<String, dynamic>) {
        dioError =
            dioError.copyWith(message: dioError.response!.data.toString());
        if (dioError.response!.statusCode == 401) {
          dioError = dioError.copyWith(message: HANDLE401);
        } else if (dioError.response!.statusCode == 400) {
          if ((dioError.response!.data as Map<String, dynamic>)
                  .containsKey("message") &&
              (dioError.response!.data['message'] is String) &&
              ((dioError.response!.data['message'] as String)
                      .contains('TRANSACTION') ||
                  (dioError.response!.data['message'] as String)
                      .contains('EXPIRED'))) {
            dioError = dioError.copyWith(message: HANDLE401);
            return dioError;
          }
          if ((dioError.response!.data as Map<String, dynamic>)
              .containsKey("title")) {
            dioError = dioError.copyWith(
                message: Util.orEmpty((dioError.response!.data
                    as Map<String, dynamic>)["title"]));
            return dioError;
          }
        } else {
          if ((dioError.response!.data as Map<String, dynamic>)
                  .containsKey("status") &&
              (dioError.response!.data["status"] is Map<String, dynamic>) &&
              (dioError.response!.data["status"] as Map<String, dynamic>)
                  .containsKey("message")) {
            dioError = dioError.copyWith(
                message: Util.orEmpty((dioError.response!.data["status"]
                    as Map<String, dynamic>)["message"]));
          }
          if ((dioError.response!.data as Map<String, dynamic>)
              .containsKey("msg")) {
            dioError = dioError.copyWith(
                message: Util.orEmpty(
                    (dioError.response!.data as Map<String, dynamic>)["msg"]));
          }
          if ((dioError.response!.data as Map<String, dynamic>)
              .containsKey("title")) {
            dioError = dioError.copyWith(
                message: Util.orEmpty((dioError.response!.data
                    as Map<String, dynamic>)["title"]));
            if ((dioError.response!.data as Map<String, dynamic>)
                    .containsKey("message") &&
                (dioError.response!.data['message'] is String) &&
                (dioError.response!.data['message'] as String)
                    .contains('error')) {
              // dioError = dioError.copyWith(
              //     message: Util.orEmpty((dioError.response!.data
              //     as Map<String, dynamic>)["message"]));
              return dioError.copyWith(
                  message: dioError.response!.data['message']);
            }
          }

          if ((dioError.response!.data as Map<String, dynamic>)
              .containsKey("message")) {
            dioError = dioError.copyWith(
                message: Util.orEmpty((dioError.response!.data
                    as Map<String, dynamic>)["message"]));
          }
          if ((dioError.response!.data as Map<String, dynamic>)
              .containsKey("detail")) {
            dioError = dioError.copyWith(
                message: dioError.response!.data['detail'] +
                    ', X-TraceId = ' +
                    dioError.response!.headers['X-TraceId']!.join(""));
          }
        }
      } else {
        dioError = dioError.copyWith(message: dioError.message!);
      }
      return dioError;
    } else {
      if ((dioError.message ?? "").isEmpty) {
        return dioError.copyWith(
            message:
                "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!");
      }
      if (dioError.message == NO_INTERNET) {
        return dioError;
      }
      if ((dioError.message ?? "").contains("Connection failed")) {
        dioError = dioError.copyWith(message: NO_INTERNET);
        return dioError;
      }
      dioError = dioError.copyWith(
          message: (dioError.error == null || dioError.error.toString().isEmpty)
              ? "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!"
              : dioError.error.toString());
      return dioError;
    }
  } catch (e) {
    if ((dioError.message ?? "").isEmpty) {
      return dioError;
    }
    dioError = dioError.copyWith(
        message: (dioError.error == null || dioError.error.toString().isEmpty)
            ? "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!"
            : dioError.error.toString());
    return dioError;
  }
}
