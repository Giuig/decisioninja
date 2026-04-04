import 'dart:async';
import 'dart:math';
import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/animation_config.dart';
import 'package:decisioninja/utils/stats_helper.dart';
import 'package:flutter/material.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:ninja_material/config/global_notifier.dart';

class PointerPage extends StatefulWidget {
  const PointerPage({super.key});

  @override
  State<PointerPage> createState() => _PointerPageState();
}

class _PointerPageState extends State<PointerPage> with AnimatingPageMixin {
  double _angleTurns = 0; // in full rotations
  bool _animationInProgress = false;
  bool _showResult = false;
  Timer? _animationTimer;
  static final Random _random = Random();

  @override
  Timer? get animationTimer => _animationTimer;
  @override
  set animationTimer(Timer? value) => _animationTimer = value;
  @override
  bool get animationInProgress => _animationInProgress;
  @override
  set animationInProgress(bool value) => _animationInProgress = value;

  void _chooseAngle() {
    globalNotifierCounter.incrementValue();
    incrementStat(StatType.pointer);

    setState(() {
      _showResult = false;
    });

    startSpinAnimation(
      generator: () {
        _angleTurns += 0.25 + _random.nextDouble() * 0.25;
      },
      onComplete: () {
        if (!mounted) return;

        setState(() {
          _angleTurns += 0.5 + _random.nextDouble();
        });

        // Delay result reveal to match animation timing
        Future.delayed(Duration(milliseconds: 400), () {
          if (!mounted) return;
          setState(() {
            _animationInProgress = false;
            _showResult = true;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedRotation(
                    turns: _angleTurns,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: AnimatingOpacity(
                      animating: _animationInProgress,
                      child: Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 180,
                        color: _angleTurns == 0
                            ? Theme.of(context).colorScheme.onInverseSurface
                            : primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: (_showResult && !_animationInProgress) ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                AppLocalizations.of(context)!.arrowResult,
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
              onPressed: _animationInProgress ? null : _chooseAngle,
              child: Text(
                _animationInProgress
                    ? AppLocalizations.of(context)!.pointing
                    : AppLocalizations.of(context)!.pointArrow,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
