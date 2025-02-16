import 'package:flutter/material.dart';

extension SizedBoxMultiply on SizedBox {
  SizedBox operator *(int factor) {
    return SizedBox(
      width: width != null ? width! * factor : null,
      height: height != null ? height! * factor : null,
    );
  }
}

abstract class SizedBoxExt {
  /// Returns a SizedBox with a height of 4.0
  static const SizedBox sizedBoxHeight4 = SizedBox(height: 4.0);

  /// Returns a SizedBox with a height of 8.0
  static const SizedBox sizedBoxHeight8 = SizedBox(height: 8.0);

  /// Returns a SizedBox with a height of 16.0
  static const SizedBox sizedBoxHeight16 = SizedBox(height: 16.0);

  /// Returns a SizedBox with a height of 24.0
  static const SizedBox sizedBoxHeight24 = SizedBox(height: 24.0);

  /// Returns a SizedBox with a width of 8.0
  static const SizedBox sizedBoxWidth8 = SizedBox(width: 8.0);

  /// Returns a SizedBox with a width of 16.0
  static const SizedBox sizedBoxWidth16 = SizedBox(width: 16.0);
}
