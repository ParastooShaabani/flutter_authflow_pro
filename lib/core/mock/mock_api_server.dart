import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_authflow_pro/core/network/dio_client.dart';

class MockApiServer {
  final Dio dio = buildAuthedDio();

  Future<String> getSecretData() async {
    final res = await dio.get('https://mockapi.local/secret');
    return res.data as String;
  }
}
