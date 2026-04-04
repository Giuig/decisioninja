import 'package:decisioninja/config/config.dart';

/// Helper for consistent stats incrementing across all pages
enum StatType {
  dice,
  leftRight,
  pointer,
  ninja,
}

/// Increment the appropriate stat counter
void incrementStat(StatType type) {
  switch (type) {
    case StatType.dice:
      appStatsNotifier.incrementDice();
    case StatType.leftRight:
      appStatsNotifier.incrementLeftRight();
    case StatType.pointer:
      appStatsNotifier.incrementPointer();
    case StatType.ninja:
      appStatsNotifier.incrementNinja();
  }
}
