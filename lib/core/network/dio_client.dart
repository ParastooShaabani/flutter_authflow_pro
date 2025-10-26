import 'package:dio/dio.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'auth_interceptor.dart';
import 'refresh_interceptor.dart';

Dio buildAuthedDio() {
  final dio = sl<Dio>();
  final authRepo = sl<AuthRepository>();
  dio.interceptors.clear();
  dio.interceptors.add(AuthInterceptor(authRepo));
  dio.interceptors.add(RefreshInterceptor(authRepo, dio));
  return dio;
}
