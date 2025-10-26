import 'package:dio/dio.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';

class RefreshInterceptor extends Interceptor {
  final AuthRepository auth;
  final Dio dio;
  bool _isRefreshing = false;
  final List<Future<Response> Function()> _queue = [];

  RefreshInterceptor(this.auth, this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        await auth.refresh();
        _isRefreshing = false;
        // retry queued
        for (final fn in _queue) { await fn(); }
        _queue.clear();
        // retry original
        final clone = await dio.fetch(err.requestOptions);
        return handler.resolve(clone);
      } catch (e) {
        _isRefreshing = false;
        _queue.clear();
        return handler.reject(err);
      }
    } else if (err.response?.statusCode == 401 && _isRefreshing) {
      // queue while refreshing
      final completer = dio.fetch(err.requestOptions);
      _queue.add(() => dio.fetch(err.requestOptions));
      await completer.catchError((_){}); // swallow here
      return; // the queued retry will resolve
    }
    super.onError(err, handler);
  }
}
