import 'package:flutter/material.dart';

// TODO: Use const paddings/sizes...

const _sizedBoxHeight8 = SizedBox(height: 8.0);
const _sizedBoxHeight16 = SizedBox(height: 16.0);
const _sizedBoxHeight24 = SizedBox(height: 24.0);

const _sizedBoxWidth8 = SizedBox(width: 8.0);
const _sizedBoxWidth16 = SizedBox(width: 16.0);

abstract class SizedBoxExt {
  /// Returns a SizedBox with a height of 8.0
  static const SizedBox sizedBoxHeight8 = _sizedBoxHeight8;

  /// Returns a SizedBox with a height of 16.0
  static const SizedBox sizedBoxHeight16 = _sizedBoxHeight16;

  /// Returns a SizedBox with a height of 24.0
  static const SizedBox sizedBoxHeight24 = _sizedBoxHeight24;

  // Widths

  /// Returns a SizedBox with a width of 8.0
  static const SizedBox sizedBoxWidth8 = _sizedBoxWidth8;

  /// Returns a SizedBox with a width of 16.0
  static const SizedBox sizedBoxWidth16 = _sizedBoxWidth16;
}
