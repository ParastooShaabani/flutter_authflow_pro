import 'package:dio/dio.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'dart:async';

class RefreshInterceptor extends Interceptor {
  final AuthRepository auth;
  final Dio dio;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  RefreshInterceptor(this.auth, this.dio);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401s coming from authenticated calls
    if (err.response?.statusCode == 401) {
      try {
        // Start a refresh if none in-flight
        if (!_isRefreshing) {
          _isRefreshing = true;
          _refreshCompleter = Completer<void>();

          try {
            await auth.refresh();             // refresh tokens
            _refreshCompleter?.complete();    // wake any waiters
          } catch (e) {
            _refreshCompleter?.completeError(e);
            rethrow;
          } finally {
            _isRefreshing = false;
          }
        } else {
          // Wait for the in-flight refresh to finish
          await _refreshCompleter?.future;
        }

        // Retry the original request with new token
        final clonedResponse = await dio.fetch(err.requestOptions);
        handler.resolve(clonedResponse);
        return;
      } catch (e) {
        // Refresh failed or retry failed → bubble the original error
        handler.reject(err);
        return;
      }
    }

    // Not a 401 → pass through
    handler.next(err);
  }
}
