import 'dart:math';

extension RandomOfDigits on Random {
  /// Generates a non-negative random integer with a specified number of digits.
  ///
  /// Supports [digitCount] values between 1 and 9 inclusive.
  num nextIntOfDigits(int digitCount) {
    assert(1 <= digitCount && digitCount <= 9);
    num min = digitCount == 1 ? 0 : pow(10, digitCount - 1);
    num max = pow(10, digitCount);
    return min + nextInt(int.parse((max - min).toString()));
  }
}
