// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/animation_config.dart';
import 'package:decisioninja/utils/stats_helper.dart';
import 'package:flutter/material.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Picks one of the user's own options.
///
/// Built as a quick list: one text field that is always there, options as
/// chips, one button to choose. It replaced a one-dialog-per-option flow
/// (tap +, type at most 10 characters, tap Create, repeat, at most 9 options,
/// rename and delete behind an edit-mode toggle) that the owner found too
/// tedious to use — design "A" of the 2026-09-26 mockups.
class NinjaPage extends StatefulWidget {
  NinjaPage({super.key});

  @override
  State<NinjaPage> createState() => _NinjaPageState();
}

class _NinjaPageState extends State<NinjaPage> with AnimatingPageMixin {
  @override
  void initState() {
    super.initState();
    loadOptionList();
  }

  bool _animationInProgress = false;
  Timer? _animationTimer;
  List<Option> _options = [];

  /// The chip lit up: the one the pick animation is passing over, then the
  /// winner once it lands. -1 for none.
  int _highlighted = -1;

  /// The last pick, shown in the result card; null while choosing or after
  /// the list changed.
  String? _winner;

  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocus = FocusNode();
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
  void dispose() {
    _inputController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  Future<void> loadOptionList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? optionListJson = preferences.getStringList('optionList');

    List<Option> optionList = optionListJson != null
        ? optionListJson
            .map((json) => Option.fromJson(jsonDecode(json)))
            .toList()
        : [];

    if (mounted) {
      setState(() {
        _options = optionList;
        _clearResult();
      });
    }
  }

  Future<void> saveOptionList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> optionListJson = _options
        .map((option) =>
            jsonEncode(Option(option.name, option.icon).toJson()))
        .toList();
    await preferences.setStringList('optionList', optionListJson);
    appStatsNotifier.setOptionList(_options);
  }

  void _clearResult() {
    _winner = null;
    _highlighted = -1;
  }

  /// Adds whatever is in the field (see [newOptionNames]), then keeps the
  /// field focused so the next option can be typed straight away.
  void _addFromInput() {
    if (_animationInProgress) return;
    final added = newOptionNames(
            _inputController.text, _options.map((o) => o.name))
        // The icon is no longer shown; it is stored so the saved JSON keeps
        // the shape older versions read and wrote.
        .map((name) => Option(name, Icons.label_outline))
        .toList();
    _inputController.clear();
    _inputFocus.requestFocus();
    if (added.isEmpty) return;
    setState(() {
      _options.addAll(added);
      _clearResult();
    });
    saveOptionList();
  }

  void _removeOption(int index) {
    if (_animationInProgress || index < 0 || index >= _options.length) return;
    setState(() {
      _options.removeAt(index);
      _clearResult();
    });
    saveOptionList();
  }

  void _choose() {
    if (_animationInProgress || _options.length < 2) return;

    // Close the keyboard so the result card is not hidden behind it.
    FocusScope.of(context).unfocus();
    incrementStat(StatType.ninja);
    setState(_clearResult);

    int tick = 0;
    startSpinAnimation(
      generator: () {
        _highlighted = tick % _options.length;
        tick++;
      },
      onComplete: () {
        if (!mounted) return;
        setState(() {
          _animationInProgress = false;
          if (_options.length < 2) {
            _clearResult();
            return;
          }
          _highlighted = _random.nextInt(_options.length);
          _winner = _options[_highlighted].name;
        });
      },
    );
  }

  /// Removes the winner and picks again among the rest — the quick way to
  /// narrow a list down. The removal is saved like any other.
  void _dropAndPickAgain() {
    final winner = _winner;
    if (_animationInProgress || winner == null || _options.length <= 2) return;
    setState(() {
      _options.removeWhere((o) => o.name == winner);
      _clearResult();
    });
    saveOptionList();
    _choose();
  }

  /// Empties the list in one go, with an Undo — starting a new decision
  /// should not mean tapping ✕ on every chip.
  void _clearAll() {
    if (_animationInProgress || _options.isEmpty) return;
    final removed = List<Option>.of(_options);
    setState(() {
      _options.clear();
      _clearResult();
    });
    saveOptionList();
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(l10n.optionsCleared),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () {
            if (!mounted || _options.isNotEmpty) return;
            setState(() => _options.addAll(removed));
            saveOptionList();
          },
        ),
      ));
  }

  // Laid out in the frame every other tab uses: a control bar on top, the
  // stage in the middle, one result line, then three buttons — tonal side
  // actions either side of the main one. The first version of this page had
  // its own heading, a full-width filled button and a result card, and read
  // as a different app (owner, 2026-09-26).
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final canChoose = _options.length >= 2 && !_animationInProgress;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // The control bar: where L/R and Dice have their selector.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _inputController,
              focusNode: _inputFocus,
              enabled: !_animationInProgress,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: l10n.addOptionHint,
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                suffixIcon: IconButton(
                  onPressed: _animationInProgress ? null : _addFromInput,
                  tooltip: l10n.addOption,
                  icon: Icon(Icons.add),
                ),
              ),
              onSubmitted: (_) => _addFromInput(),
              // Overridden so submitting does not drop focus: the default
              // closes the keyboard after every option.
              onEditingComplete: () {},
            ),
          ),
          // The stage, centred like the dice and the arrow.
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < _options.length; i++)
                      _buildChip(i, theme, l10n),
                  ],
                ),
              ),
            ),
          ),
          Opacity(
            opacity: (_winner != null && !_animationInProgress) ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                l10n.theResultIs(_winner ?? ''),
                style: TextStyle(
                  fontSize: resultTextSize,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message: l10n.dropAndPickAgain,
                  child: FilledButton.tonal(
                    onPressed: _animationInProgress ||
                            _winner == null ||
                            _options.length <= 2
                        ? null
                        : _dropAndPickAgain,
                    child: Icon(Icons.playlist_remove),
                  ),
                ),
                FilledButton(
                  onPressed: canChoose ? _choose : null,
                  child: Text(
                    _animationInProgress
                        ? l10n.choosing
                        : (_options.length < 2
                            ? l10n.addFirstNinja
                            : l10n.chooseNinja),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tooltip(
                  message: l10n.clearAll,
                  child: FilledButton.tonal(
                    onPressed: _animationInProgress || _options.isEmpty
                        ? null
                        : _clearAll,
                    child: Icon(Icons.delete_sweep),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(int index, ThemeData theme, AppLocalizations l10n) {
    final name = _options[index].name;
    final lit = index == _highlighted;
    final scheme = theme.colorScheme;
    return InputChip(
      label: Text(name),
      selected: lit,
      showCheckmark: false,
      selectedColor: scheme.primary,
      labelStyle: TextStyle(
        color: lit ? scheme.onPrimary : scheme.onSurface,
        fontWeight: lit ? FontWeight.w700 : FontWeight.w500,
      ),
      deleteIconColor: lit ? scheme.onPrimary : scheme.onSurfaceVariant,
      deleteButtonTooltipMessage: l10n.removeOption(name),
      onDeleted: _animationInProgress ? null : () => _removeOption(index),
    );
  }
}

/// The options to add from what was typed or pasted.
///
/// Splits on commas and newlines, so a pasted "pizza, sushi, tacos" becomes
/// three options in one go. Blanks are dropped, and a name already in
/// [existing] or earlier in the same input (ignoring case) is skipped rather
/// than suffixed: two identical options would only double that option's odds.
@visibleForTesting
List<String> newOptionNames(String input, Iterable<String> existing) {
  final seen = existing.map((e) => e.toLowerCase()).toSet();
  final names = <String>[];
  for (final part in input.split(RegExp(r'[,\n]'))) {
    final name = part.trim();
    if (name.isNotEmpty && seen.add(name.toLowerCase())) names.add(name);
  }
  return names;
}

class Option {
  Option(this.name, this.icon, {this.chosen = false});

  String name;
  IconData icon;
  bool chosen;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'chosen': chosen,
    };
  }

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      json['name'],
      IconData(json['icon'], fontFamily: 'MaterialIcons'),
      chosen: json['chosen'] ?? false,
    );
  }
}
