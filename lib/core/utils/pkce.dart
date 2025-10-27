import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PKCEPair {
  final String verifier;
  final String challenge;
  PKCEPair(this.verifier, this.challenge);
}

String _base64UrlNoPad(List<int> bytes) =>
    base64UrlEncode(bytes).replaceAll('=', '');

PKCEPair generatePkce({int length = 43}) {
  final rand = Random.secure();
  final verifier = List<int>.generate(length, (_) => rand.nextInt(256));
  final v = _base64UrlNoPad(verifier);
  final challenge = _base64UrlNoPad(sha256.convert(utf8.encode(v)).bytes);
  return PKCEPair(v, challenge);
}
