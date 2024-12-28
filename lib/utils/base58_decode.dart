import 'dart:convert';

List<int> base58decode(String base58String) {
  final trimmed = base58String.trim();
  if (trimmed.isEmpty) return [];

  int length = 0;
  final zeroes = trimmed.split('').takeWhile((v) => v == '1').length;

  final size = (trimmed.length - zeroes) * 733 ~/ 1000 + 1;
  final bytes256 = List.filled(size, 0);
  final List<int> inputBytes = utf8.encode(trimmed);
  for (final currentByte in inputBytes) {
    int carry = _reverseMap[currentByte];
    int i = 0;
    if (carry == -1) {
      throw FormatException('Invalid base58 character found: $currentByte');
    }
    for (int j = size - 1; j >= 0; j--, i++) {
      // ignore: avoid-inverted-boolean-checks, fix later
      if (!((carry != 0) || (i < length))) break;
      carry += 58 * bytes256[j];
      bytes256[j] = carry % 256;
      carry ~/= 256;
    }
    length = i;
  }

  return List<int>.filled(zeroes, 0)
      .followedBy(bytes256.sublist(size - length))
      .toList(growable: false);
}

const List<int> _reverseMap = [
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, //
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, -1,
  -1, -1, -1, -1, -1, -1, 9, 10, 11, 12, 13, 14, 15, 16,
  -1, 17, 18, 19, 20, 21, -1, 22, 23, 24, 25, 26, 27, 28,
  29, 30, 31, 32, -1, -1, -1, -1, -1, -1, 33, 34, 35, 36,
  37, 38, 39, 40, 41, 42, 43, -1, 44, 45, 46, 47, 48, 49,
  50, 51, 52, 53, 54, 55, 56, 57, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1,
];
