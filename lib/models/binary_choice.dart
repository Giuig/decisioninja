import 'package:flutter/material.dart';

/// Consolidated data structure for binary choices
/// Replaces 6 separate getters with a single data model
class BinaryChoice {
  final String optionA;
  final String optionB;
  final String labelA;
  final String labelB;
  final IconData iconA;
  final IconData iconB;

  const BinaryChoice({
    required this.optionA,
    required this.optionB,
    required this.labelA,
    required this.labelB,
    required this.iconA,
    required this.iconB,
  });
}
