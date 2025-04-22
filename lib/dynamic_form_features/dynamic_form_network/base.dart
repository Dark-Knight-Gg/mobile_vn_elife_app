// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';

abstract class BaseService {
  final Dio client;

  BaseService(this.client) : assert(client != null);
}
