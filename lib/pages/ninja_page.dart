// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/animation_config.dart';
import 'package:decisioninja/utils/icon_tuples.dart';
import 'package:decisioninja/utils/stats_helper.dart';
import 'package:flutter/material.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:ninja_material/config/global_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isEditMode = false;
  int _numberOfOptions = 0;
  int _chosenOptionIndex = -1;
  Timer? _animationTimer;
  late List<Option> _options = [];
  static final Random _random = Random();

  @override
  Timer? get animationTimer => _animationTimer;
  @override
  set animationTimer(Timer? value) => _animationTimer = value;
  @override
  bool get animationInProgress => _animationInProgress;
  @override
  set animationInProgress(bool value) => _animationInProgress = value;


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
        _numberOfOptions = optionList.length;
        _chosenOptionIndex = -1;
      });
    }
  }

  void _chooseOption() {
    if (_animationInProgress || _numberOfOptions < 2) return;

    globalNotifierCounter.incrementValue();
    incrementStat(StatType.ninja);

    setState(() {
      _isEditMode = false;
    });

    int currentIndex = 0;

    startSpinAnimation(
      generator: () {
        _options = _options.map((option) {
          return Option(option.name, option.icon, chosen: false);
        }).toList();

        _options[currentIndex] = Option(
          _options[currentIndex].name,
          _options[currentIndex].icon,
          chosen: true,
        );

        currentIndex = (currentIndex + 1) % _options.length;
      },
      onComplete: () {
        if (!mounted || _options.isEmpty) return;

        int chosenIndex = _random.nextInt(_options.length);

        setState(() {
          _options = _options.map((option) {
            return Option(option.name, option.icon, chosen: false);
          }).toList();

          _chosenOptionIndex = chosenIndex;
          _options[_chosenOptionIndex] = Option(
            _options[_chosenOptionIndex].name,
            _options[_chosenOptionIndex].icon,
            chosen: true,
          );
          _animationInProgress = false;
        });
      },
    );
  }

  void _createOption(String name) {
    if (!mounted) return;

    if (name.isEmpty) {
      name = AppLocalizations.of(context)!.defaultOptionName;
    }

    int suffix = 2;
    String originalName = name;

    while (_options.any((option) => option.name == name)) {
      name = "$originalName $suffix";
      suffix++;
    }

    final usedIcons = _options.map((option) => option.icon).toList();

    final availableIcons = icons
        .where((iconTuple) => !usedIcons.contains(iconTuple.item1))
        .toList();

    if (availableIcons.isEmpty) {
      setState(() {
        _options.add(Option(name, Icons.help_outline));
        _numberOfOptions++;
        _resetChosen();
        _isEditMode = false;
      });
    } else {
      final randomIcon = availableIcons[_random.nextInt(availableIcons.length)];

      setState(() {
        _options.add(Option(name, randomIcon.item1));
        _numberOfOptions++;
        _resetChosen();
        _isEditMode = false;
      });
    }

    saveOptionList();
  }

  void _removeOption(int index) {
    if (!mounted || index < 0 || index >= _options.length) return;

    setState(() {
      if (_chosenOptionIndex == index) {
        _chosenOptionIndex = -1;
      } else if (_chosenOptionIndex > index) {
        _chosenOptionIndex--;
      }
      _options.removeAt(index);
      _numberOfOptions--;
      _resetChosen();
      if (_options.isEmpty) {
        _isEditMode = false;
      }
      saveOptionList();
    });
  }

  void _resetChosen() {
    if (!mounted) return;

    setState(() {
      _options = _options.map((option) {
        return Option(option.name, option.icon, chosen: false);
      }).toList();
      _chosenOptionIndex = -1;
    });
  }

  void _showCreateOptionModal() {
    String optionName = "";

    ValueNotifier<String> nameNotifier = ValueNotifier(optionName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.createNinja),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 10,
                  onChanged: (value) {
                    nameNotifier.value = value;
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.nameNinja),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _createOption(nameNotifier.value);
                  },
                  child: Text(AppLocalizations.of(context)!.createNinja),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> saveOptionList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> optionListJson =
        _options.map((option) => jsonEncode(option.toJson())).toList();
    await preferences.setStringList('optionList', optionListJson);
    appStatsNotifier.setOptionList(_options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(child: buildOptionGrid(constraints));
              },
            ),
          ),
          Opacity(
            opacity: (!_animationInProgress) ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                _chosenOptionIndex != -1
                    ? AppLocalizations.of(context)!.chosenNinja +
                        _options[_chosenOptionIndex].name
                    : '',
                style: TextStyle(
                    fontSize: resultTextSize,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _animationInProgress || _numberOfOptions == 0
                      ? null
                      : () {
                          setState(() {
                            _isEditMode = !_isEditMode;
                          });
                        },
                  child: Icon(_isEditMode ? Icons.check : Icons.edit),
                ),
                ElevatedButton(
                  onPressed: _animationInProgress || _numberOfOptions < 2
                      ? null
                      : _chooseOption,
                  child: Text(
                    _numberOfOptions < 2
                        ? AppLocalizations.of(context)!.addFirstNinja
                        : (_animationInProgress
                            ? AppLocalizations.of(context)!.choosing
                            : AppLocalizations.of(context)!.chooseNinja),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: _animationInProgress
                      ? null
                      : _numberOfOptions == 9
                          ? null
                          : _showCreateOptionModal,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildOptionGrid(BoxConstraints constraints) {
    // Size from width only — items have variable height due to text label
    final double iconSize = GridLayoutConfig.itemSize(
      constraints,
      _numberOfOptions,
    );

    return Padding(
      padding: const EdgeInsets.all(GridLayoutConfig.outerPadding),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: GridLayoutConfig.spacing,
        runSpacing: GridLayoutConfig.spacing,
        children: List.generate(
          _numberOfOptions,
          (index) => SizedBox(
            width: iconSize,
            child: _buildOptionItem(index, iconSize),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(int index, double iconSize) {
    final Color iconColor = _options[index].chosen
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onInverseSurface;

    return GestureDetector(
      onTap: () {
        if (_isEditMode) _editOptionName(index);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatingOpacity(
            animating: _animationInProgress,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_options[index].icon, size: iconSize, color: iconColor),
                if (_isEditMode)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _options[index].name,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.edit,
                          size: 11,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  )
                else
                  Text(_options[index].name, style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
          if (_isEditMode)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.remove_circle),
                color: Theme.of(context).colorScheme.errorContainer,
                onPressed: () => _removeOption(index),
              ),
            ),
        ],
      ),
    );
  }

  void _editOptionName(int index) {
    TextEditingController controller =
        TextEditingController(text: _options[index].name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.editOption),
          content: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.nameNinja),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _options[index].name = controller.text;
                });
                saveOptionList();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        );
      },
    );
  }
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
