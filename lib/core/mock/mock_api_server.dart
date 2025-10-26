import 'dart:async';

class MockApiServer {
  Future<String> getSecretData(String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!accessToken.startsWith('access_')) {
      throw Exception('invalid_token');
    }
    return 'Top Secret: 🫣 Parastoo is awesome!';
  }
}
