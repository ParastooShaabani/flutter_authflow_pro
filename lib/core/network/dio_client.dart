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
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.path == 'https://mockapi.local/secret') {
          final authHeader = options.headers['Authorization'];
          if (authHeader == null ||
              !authHeader.toString().contains('access_')) {
            return handler.reject(
              DioException(
                requestOptions: options,
                response: Response(
                  requestOptions: options,
                  statusCode: 401,
                  statusMessage: 'Unauthorized',
                ),
              ),
            );
          }
          return handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: 'Top Secret: 🫣 it is awesome (via Dio)!',
            ),
          );
        }
        handler.next(options);
      },
    ),
  );
  return dio;
}
