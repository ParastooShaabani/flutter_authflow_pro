import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_authflow_pro/core/utils/pkce.dart';

void main() {
  test('generates verifier and challenge', () {
    final p = generatePkce();
    expect(p.verifier.isNotEmpty, true);
    expect(p.challenge.isNotEmpty, true);
  });
}
