import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Centralized animation configuration for consistent behavior across all pages
class AnimationConfig {
  /// Opacity when animation is in progress (spinning/choosing)
  static const double fadedOpacity = 0.5;

  /// Opacity when animation has completed (result shown)
  static const double normalOpacity = 1.0;

  /// Duration of each animation frame tick (milliseconds)
  static const int spinDurationMs = 70;

  /// Number of animation frames before showing final result
  static const int spinFrames = 15;

  /// Total approximate animation duration in milliseconds
  static int get totalAnimationDurationMs => spinDurationMs * spinFrames;
}

/// Widget that automatically applies faded opacity during animation
class AnimatingOpacity extends StatelessWidget {
  final bool animating;
  final Widget child;
  final double fadedOpacity;
  final double normalOpacity;

  const AnimatingOpacity({
    Key? key,
    required this.animating,
    required this.child,
    this.fadedOpacity = AnimationConfig.fadedOpacity,
    this.normalOpacity = AnimationConfig.normalOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animating ? fadedOpacity : normalOpacity,
      child: child,
    );
  }
}

/// Generates a random number that differs from the previous value
/// Useful for animations where consecutive identical values look repetitive
int randomWithoutRepeat(int maxValue, int previousValue) {
  final random = _SecureRandom();
  int newValue;
  do {
    newValue = random.nextInt(maxValue);
  } while (newValue == previousValue);
  return newValue;
}

// Simple wrapper around Random for consistency
class _SecureRandom {
  static final _random = Random();

  int nextInt(int max) => _random.nextInt(max);
}

/// Widget that automatically reveals text after animation completes
class RevealingText extends StatelessWidget {
  final String text;
  final bool animating;
  final TextStyle? style;
  final Duration duration;

  const RevealingText({
    Key? key,
    required this.text,
    required this.animating,
    this.style,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animating ? 0.0 : 1.0,
      duration: duration,
      child: Text(text, style: style),
    );
  }
}

/// Shared layout constants for responsive grids (dice, ninja, etc.)
class GridLayoutConfig {
  static const double spacing = 12.0;
  static const double outerPadding = 24.0;
  static const double maxGridWidth = 480.0;

  /// Returns the number of columns for a grid of [count] items (max 9).
  static int columnsFor(int count) {
    if (count <= 1) return 1;
    if (count == 2) return 2;
    if (count <= 3) return 3;
    if (count == 4) return 2;
    return 3;
  }

  /// Computes the item size (width) based on available constraints and count.
  /// For square items pass [availableHeight]; for items with variable height
  /// (e.g. icon + label) pass null to size from width only.
  static double itemSize(
    BoxConstraints constraints,
    int count, {
    double? availableHeight,
    double minSize = 40.0,
    double maxSize = 110.0,
  }) {
    final int cols = columnsFor(count);
    final double w =
        (constraints.maxWidth - outerPadding * 2).clamp(0.0, maxGridWidth);
    final double sizeFromWidth = (w - spacing * (cols - 1)) / cols;

    if (availableHeight != null) {
      final int rows = (count / cols).ceil();
      final double h = availableHeight - outerPadding * 2;
      final double sizeFromHeight = (h - spacing * (rows - 1)) / rows;
      return (sizeFromWidth < sizeFromHeight ? sizeFromWidth : sizeFromHeight)
          .clamp(minSize, maxSize);
    }

    return sizeFromWidth.clamp(minSize, maxSize);
  }
}

/// Mixin for pages that use spin/animation loops
/// Provides common animation lifecycle management
mixin AnimatingPageMixin<T extends StatefulWidget> on State<T> {
  Timer? get animationTimer;
  set animationTimer(Timer? value);

  bool get animationInProgress;
  set animationInProgress(bool value);

  /// Start a spin animation that cycles through values until completion
  ///
  /// [generator] — callback that generates the next value for each frame
  /// [onComplete] — callback fired when animation finishes
  void startSpinAnimation({
    required VoidCallback generator,
    required VoidCallback onComplete,
  }) {
    if (animationInProgress) return;

    setState(() => animationInProgress = true);

    int count = 0;
    animationTimer = Timer.periodic(
      Duration(milliseconds: AnimationConfig.spinDurationMs),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        count++;
        setState(generator);

        if (count >= AnimationConfig.spinFrames) {
          timer.cancel();
          onComplete();
        }
      },
    );
  }

  /// Cleanup animation timer safely
  void cleanupAnimation() {
    animationTimer?.cancel();
    animationTimer = null;
  }

  @override
  void dispose() {
    cleanupAnimation();
    super.dispose();
  }
}
