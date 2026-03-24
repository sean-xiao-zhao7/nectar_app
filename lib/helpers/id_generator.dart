import 'dart:math';

final Random _random = Random();

/// Generates a prefixed ID using timestamp and random entropy.
String generatePrefixedId(String prefix) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  final entropy = _random.nextInt(1 << 32).toRadixString(16);
  return '${prefix}_${timestamp}_$entropy';
}
