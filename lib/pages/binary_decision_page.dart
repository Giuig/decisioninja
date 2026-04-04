// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';
import 'dart:math';
import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/choice_mode_notifier.dart';
import 'package:decisioninja/config/animation_config.dart';
import 'package:decisioninja/models/binary_choice.dart';
import 'package:decisioninja/utils/stats_helper.dart';
import 'package:flutter/material.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:ninja_material/config/global_notifier.dart';

enum DecisionMode {
  leftRight,
  yesNo,
  headsTails,
}

class BinaryDecisionPage extends StatefulWidget {
  BinaryDecisionPage({super.key});

  @override
  State<BinaryDecisionPage> createState() => _BinaryDecisionPageState();
}

class _BinaryDecisionPageState extends State<BinaryDecisionPage>
    with AnimatingPageMixin {
  String _direction = '';
  bool _animationInProgress = false;
  Timer? _animationTimer;
  DecisionMode _mode = DecisionMode.leftRight;
  static final Random _random = Random();

  @override
  Timer? get animationTimer => _animationTimer;
  @override
  set animationTimer(Timer? value) => _animationTimer = value;
  @override
  bool get animationInProgress => _animationInProgress;
  @override
  set animationInProgress(bool value) => _animationInProgress = value;

  @override
  void initState() {
    super.initState();
    _loadSavedMode();
  }

  Future<void> _loadSavedMode() async {
    await choiceModeNotifier.loadSavedModes();
    if (mounted) {
      setState(() {
        _mode =
            _mapBinaryModeToDecisionMode(choiceModeNotifier.value.binaryMode);
      });
    }
  }

  DecisionMode _mapBinaryModeToDecisionMode(BinaryMode mode) {
    switch (mode) {
      case BinaryMode.leftRight:
        return DecisionMode.leftRight;
      case BinaryMode.yesNo:
        return DecisionMode.yesNo;
      case BinaryMode.headsTails:
        return DecisionMode.headsTails;
    }
  }

  BinaryMode _mapDecisionModeToBinaryMode(DecisionMode mode) {
    switch (mode) {
      case DecisionMode.leftRight:
        return BinaryMode.leftRight;
      case DecisionMode.yesNo:
        return BinaryMode.yesNo;
      case DecisionMode.headsTails:
        return BinaryMode.headsTails;
    }
  }

  BinaryChoice get _currentChoice {
    switch (_mode) {
      case DecisionMode.leftRight:
        return BinaryChoice(
          optionA: 'left',
          optionB: 'right',
          labelA: 'L',
          labelB: 'R',
          iconA: Icons.arrow_circle_left_rounded,
          iconB: Icons.arrow_circle_right_rounded,
        );
      case DecisionMode.yesNo:
        return BinaryChoice(
          optionA: 'yes',
          optionB: 'no',
          labelA: 'Y',
          labelB: 'N',
          iconA: Icons.radio_button_checked,
          iconB: Icons.cancel,
        );
      case DecisionMode.headsTails:
        return BinaryChoice(
          optionA: 'heads',
          optionB: 'tails',
          labelA: 'H',
          labelB: 'T',
          iconA: Icons.monetization_on,
          iconB: Icons.monetization_on_outlined,
        );
    }
  }

  void _chooseDirection() {
    globalNotifierCounter.incrementValue();
    incrementStat(StatType.leftRight);

    int count = 0;
    startSpinAnimation(
      generator: () {
        count++;
        final choice = _currentChoice;
        _direction = count % 2 == 0 ? choice.optionA : choice.optionB;
      },
      onComplete: () {
        if (!mounted) return;
        setState(() {
          final choice = _currentChoice;
          _direction = _random.nextBool() ? choice.optionB : choice.optionA;
          _animationInProgress = false;
        });
      },
    );
  }

  void _onModeChanged(DecisionMode newMode) {
    cleanupAnimation();
    choiceModeNotifier.setBinaryMode(_mapDecisionModeToBinaryMode(newMode));
    setState(() {
      _mode = newMode;
      _direction = '';
      _animationInProgress = false;
    });
  }

  String _getResultText() {
    final l10n = AppLocalizations.of(context)!;
    final isA = _direction == _currentChoice.optionA;
    switch (_mode) {
      case DecisionMode.leftRight:
        return l10n.theResultIs(isA ? l10n.left : l10n.right);
      case DecisionMode.yesNo:
        return l10n.theResultIs(isA ? l10n.yes : l10n.no);
      case DecisionMode.headsTails:
        return l10n.theResultIs(isA ? l10n.heads : l10n.tails);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<DecisionMode>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment<DecisionMode>(
                  value: DecisionMode.leftRight,
                  label: Text(AppLocalizations.of(context)!.leftRightLabel),
                  icon: Icon(Icons.compare_arrows),
                ),
                ButtonSegment<DecisionMode>(
                  value: DecisionMode.yesNo,
                  label: Text(AppLocalizations.of(context)!.yesNoLabel),
                  icon: Icon(Icons.help),
                ),
                ButtonSegment<DecisionMode>(
                  value: DecisionMode.headsTails,
                  label: Text(AppLocalizations.of(context)!.headsTailsLabel),
                  icon: Icon(Icons.monetization_on),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (Set<DecisionMode> selected) {
                _onModeChanged(selected.first);
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  AnimatingOpacity(
                    animating: _animationInProgress,
                    child: Icon(
                      _currentChoice.iconA,
                      size: 150,
                      color: _direction == _currentChoice.optionA
                          ? primaryColor
                          : Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                  const SizedBox(width: 20),
                  AnimatingOpacity(
                    animating: _animationInProgress,
                    child: Icon(
                      _currentChoice.iconB,
                      size: 150,
                      color: _direction == _currentChoice.optionB
                          ? primaryColor
                          : Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: (_direction.isNotEmpty && !_animationInProgress) ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                _getResultText(),
                style: TextStyle(
                  fontSize: resultTextSize,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: ElevatedButton(
              onPressed: _animationInProgress ? null : _chooseDirection,
              child: Text(
                _animationInProgress
                    ? AppLocalizations.of(context)!.choosing
                    : _getButtonText(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getButtonText() {
    switch (_mode) {
      case DecisionMode.leftRight:
        return AppLocalizations.of(context)!.chooseLeftRight;
      case DecisionMode.yesNo:
        return AppLocalizations.of(context)!.chooseYesNo;
      case DecisionMode.headsTails:
        return AppLocalizations.of(context)!.flipCoin;
    }
  }
}
