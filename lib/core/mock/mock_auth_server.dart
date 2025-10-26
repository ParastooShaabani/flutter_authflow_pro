import 'dart:async';
import 'dart:math';
import 'package:flutter_authflow_pro/features/auth/domain/models/token_set.dart';

class MockAuthServer {
  final _rand = Random();
  Future<String> authorize({required String codeChallenge}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'auth_code_${_rand.nextInt(999999)}';
  }

  Future<TokenSet> exchange({
    required String code,
    required String codeVerifier,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    return TokenSet(
      accessToken: 'access_${_rand.nextInt(999999)}',
      refreshToken: 'refresh_${_rand.nextInt(999999)}',
      expiresAt: now.add(const Duration(minutes: 15)),
    );
  }

  Future<TokenSet> refresh(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    return TokenSet(
      accessToken: 'access_${_rand.nextInt(999999)}',
      refreshToken: refreshToken,
      expiresAt: now.add(const Duration(minutes: 15)),
    );
  }
}
