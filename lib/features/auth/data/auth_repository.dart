import 'package:flutter_authflow_pro/core/mock/mock_auth_server.dart';
import 'package:flutter_authflow_pro/core/storage/token_store.dart';
import 'package:flutter_authflow_pro/core/utils/pkce.dart';
import 'package:flutter_authflow_pro/features/auth/domain/models/token_set.dart';

class AuthRepository {
  final MockAuthServer auth;
  final TokenStore store;

  PkcePair? _pkce;

  AuthRepository({required this.auth, required this.store});

  Future<void> init() async => store.init();

  Future<String> beginAuth() async {
    _pkce = generatePkce();
    return auth.authorize(codeChallenge: _pkce!.challenge);
  }

  Future<TokenSet> exchangeCode(String code) async {
    final tokens = await auth.exchange(
      code: code,
      codeVerifier: _pkce!.verifier,
    );
    await store.save(tokens);
    return tokens;
  }

  Future<TokenSet?> current() => store.read();

  Future<TokenSet> refresh() async {
    final cur = await current();
    if (cur == null) throw Exception('not_authenticated');
    final t = await auth.refresh(cur.refreshToken);
    await store.save(t);
    return t;
  }

  Future<void> logout() => store.clear();
}
