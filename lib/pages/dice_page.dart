// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields

import 'dart:async';
import 'dart:math';
import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/choice_mode_notifier.dart';
import 'package:decisioninja/config/animation_config.dart';
import 'package:decisioninja/utils/stats_helper.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:dice_icons/dice_icons.dart';
import 'package:ninja_material/config/global_notifier.dart';

class DicePage extends StatefulWidget {
  DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with AnimatingPageMixin {
  bool _animationInProgress = false;
  Timer? _animationTimer;
  List<int> _scores = <int>[0];
  List<int> _previousScores = <int>[0];
  int _numberOfDice = 1;
  DiceType _diceType = DiceType.d6;
  static final Random _random = Random();

  @override
  Timer? get animationTimer => _animationTimer;
  @override
  set animationTimer(Timer? value) => _animationTimer = value;
  @override
  bool get animationInProgress => _animationInProgress;
  @override
  set animationInProgress(bool value) => _animationInProgress = value;

  final List _d6Icons = [
    DiceIcons.dice0,
    DiceIcons.dice1,
    DiceIcons.dice2,
    DiceIcons.dice3,
    DiceIcons.dice4,
    DiceIcons.dice5,
    DiceIcons.dice6,
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    await choiceModeNotifier.loadSavedModes();
    if (mounted) {
      setState(() {
        _diceType = choiceModeNotifier.value.diceType;
        _numberOfDice = choiceModeNotifier.value.numberOfDice;
        _scores = List<int>.generate(_numberOfDice, (i) => 0);
        _previousScores = List<int>.generate(_numberOfDice, (i) => 0);
      });
    }
  }


  void _chooseScore() {
    globalNotifierCounter.incrementValue();
    incrementStat(StatType.dice);
    if (_animationInProgress) return;

    setState(() {
      _scores = List<int>.generate(_numberOfDice, (i) => 0);
      _previousScores = List<int>.generate(_numberOfDice, (i) => 0);
    });

    startSpinAnimation(
      generator: () {
        _scores = List.generate(
          _numberOfDice,
          (index) {
            int newValue;
            do {
              newValue = _random.nextInt(_diceType.faces) + 1;
            } while (newValue == _previousScores[index]);
            return newValue;
          },
        );
        _previousScores = List<int>.from(_scores);
      },
      onComplete: _finalScore,
    );
  }

  void _finalScore() {
    if (!mounted) return;
    setState(() {
      _scores = List.generate(
        _numberOfDice,
        (index) => _random.nextInt(_diceType.faces) + 1,
      );
      _animationInProgress = false;
    });
  }

  void _incrementNumberOfDice() {
    if (_numberOfDice <= 9) {
      setState(() {
        _numberOfDice++;
        _scores.add(0);
        _previousScores.add(0);
        for (int i = 0; i < _scores.length; i++) {
          _scores[i] = 0;
          _previousScores[i] = 0;
        }
      });
      choiceModeNotifier.setNumberOfDice(_numberOfDice);
    }
  }

  void _decrementNumberOfDice() {
    if (_numberOfDice > 1) {
      setState(() {
        _numberOfDice--;
        _scores.removeLast();
        _previousScores.removeLast();
        for (int i = 0; i < _scores.length; i++) {
          _scores[i] = 0;
          _previousScores[i] = 0;
        }
      });
      choiceModeNotifier.setNumberOfDice(_numberOfDice);
    }
  }

  void _resetScores() {
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < _scores.length; i++) {
        _scores[i] = 0;
        _previousScores[i] = 0;
      }
    });
  }

  int calculateTotalScore() {
    if (_scores.isEmpty || _scores.every((s) => s == 0)) return 0;
    return _scores.where((s) => s > 0).fold(0, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Dice type selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<DiceType>(
              showSelectedIcon: false,
              segments: DiceType.values
                  .map(
                    (type) => ButtonSegment<DiceType>(
                      value: type,
                      label: Text(type.label),
                    ),
                  )
                  .toList(),
              selected: {_diceType},
              onSelectionChanged: (Set<DiceType> selected) {
                setState(() {
                  _diceType = selected.first;
                  for (int i = 0; i < _scores.length; i++) {
                    _scores[i] = 0;
                    _previousScores[i] = 0;
                  }
                });
                choiceModeNotifier.setDiceType(selected.first);
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(child: buildDiceGrid(constraints));
              },
            ),
          ),
          Opacity(
            opacity:
                (calculateTotalScore() > 0 && !_animationInProgress) ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                AppLocalizations.of(context)!.totalScore +
                    calculateTotalScore().toString(),
                style: TextStyle(
                  fontSize: resultTextSize,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _animationInProgress || _numberOfDice <= 1
                      ? null
                      : _decrementNumberOfDice,
                  child: Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: _animationInProgress ? null : _chooseScore,
                  child: Text(
                    _animationInProgress
                        ? AppLocalizations.of(context)!.throwing
                        : _numberOfDice > 1
                            ? AppLocalizations.of(context)!.throwDice
                            : AppLocalizations.of(context)!.throwDie,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: _animationInProgress || _numberOfDice >= 9
                      ? null
                      : _incrementNumberOfDice,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDiceGrid(BoxConstraints constraints) {
    final double size = GridLayoutConfig.itemSize(
      constraints,
      _numberOfDice,
      availableHeight: constraints.maxHeight,
    );

    return Padding(
      padding: const EdgeInsets.all(GridLayoutConfig.outerPadding),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: GridLayoutConfig.spacing,
        runSpacing: GridLayoutConfig.spacing,
        children: List.generate(
          _numberOfDice,
          (index) => SizedBox(
            width: size,
            height: size,
            child: _buildDiceIcon(_scores[index], size),
          ),
        ),
      ),
    );
  }

  Widget _buildDiceIcon(int score, double size) {
    if (_diceType == DiceType.d6 && score > 0 && score <= 6) {
      return AnimatingOpacity(
        animating: _animationInProgress,
        child: Icon(
          _d6Icons[score],
          size: size,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    // For other dice types or zero, show text-based dice
    return AnimatingOpacity(
      animating: _animationInProgress,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: score > 0
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(
                  context,
                ).colorScheme.onInverseSurface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: score > 0
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            score > 0 ? score.toString() : '?',
            style: TextStyle(
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
              color: score > 0
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
