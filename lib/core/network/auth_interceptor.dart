import 'package:dio/dio.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';

class AuthInterceptor extends Interceptor {
  final AuthRepository auth;
  AuthInterceptor(this.auth);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final t = await auth.current();
    if (t != null) {
      options.headers['Authorization'] = 'Bearer ${t.accessToken}';
    }
    super.onRequest(options, handler);
  }
}
