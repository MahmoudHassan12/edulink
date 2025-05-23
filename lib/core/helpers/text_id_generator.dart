import 'dart:convert' show utf8;

class TextIdGenerator {
  const TextIdGenerator(this.text);
  final String text;
  String generateId() => _toBase62(
    utf8
        .encode(text)
        .fold<BigInt>(
          BigInt.zero,
          (previous, element) => (previous << 8) + BigInt.from(element),
        ),
  );

  String _toBase62(BigInt number) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var result = '';
    BigInt localNumber = number;
    while (localNumber > BigInt.zero) {
      result = chars[(localNumber % BigInt.from(62)).toInt()] + result;
      localNumber = localNumber ~/ BigInt.from(62);
    }
    return result;
  }
}
