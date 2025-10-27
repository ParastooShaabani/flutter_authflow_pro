import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_authflow_pro/features/auth/domain/models/token_set.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStore {
  Future<void> init();

  Future<void> save(TokenSet tokens);

  Future<TokenSet?> read();

  Future<void> clear();
}

class TokenStoreImpl implements TokenStore {
  final _box = GetStorage('auth_box');
  final _secure = const FlutterSecureStorage();

  @override
  Future<void> init() async {
    if (kIsWeb) {
      await GetStorage.init('auth_box');
    }
    // On mobile, FlutterSecureStorage works out of the box.
  }

  @override
  Future<void> save(TokenSet t) async {
    final json = {
      'access': t.accessToken,
      'refresh': t.refreshToken,
      'exp': t.expiresAt.toIso8601String(),
    };
    if (kIsWeb) {
      await _box.write('tokens', json);
    } else {
      await _secure.write(key: 'tokens', value: jsonEncode(json));
    }
  }

  @override
  Future<TokenSet?> read() async {
    Map<String, dynamic>? map;
    if (kIsWeb) {
      final v = _box.read('tokens');
      if (v is Map<String, dynamic>) map = v;
    } else {
      final v = await _secure.read(key: 'tokens');
      if (v != null) map = jsonDecode(v);
    }
    if (map == null) return null;
    return TokenSet(
      accessToken: map['access'],
      refreshToken: map['refresh'],
      expiresAt: DateTime.parse(map['exp']),
    );
  }

  @override
  Future<void> clear() async {
    if (kIsWeb) {
      await _box.remove('tokens');
    } else {
      await _secure.delete(key: 'tokens');
    }
  }
}
