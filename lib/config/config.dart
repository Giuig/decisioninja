// lib/config/config.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:decisioninja/pages/ninja_page.dart'; // Ensure Option class is available

double resultTextSize = 20;

class AppStatsNotifier extends ChangeNotifier {
  int _leftRightCount = 0;
  int _diceCount = 0;
  int _pointerCount = 0;
  int _ninjaCount = 0;
  List<Option> _optionList =
      []; // This will now be the single source of truth for options

  // Public getters to access the global values
  int get globalLeftRightCount => _leftRightCount;
  int get globalDiceCount => _diceCount;
  int get globalPointerCount => _pointerCount;
  int get globalNinjaCount => _ninjaCount;
  List<Option> get globalOptionList =>
      List.unmodifiable(_optionList); // Return an unmodifiable list

  AppStatsNotifier() {
    _loadStats(); // Load initial stats and options when notifier is created
  }

  Future<void> _loadStats() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _leftRightCount = preferences.getInt('leftRightCount') ?? 0;
    _diceCount = preferences.getInt('diceCount') ?? 0;
    _pointerCount = preferences.getInt('pointerCount') ?? 0;
    _ninjaCount = preferences.getInt('ninjaCount') ?? 0;

    List<String>? optionListJson = preferences.getStringList('optionList');
    _optionList = optionListJson?.map((json) {
          Map<String, dynamic> optionData = jsonDecode(json);
          return Option.fromJson(optionData);
        }).toList() ??
        [];

    notifyListeners(); // Notify after loading initial data
  }

  Future<void> _saveStats() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('leftRightCount', _leftRightCount);
    await preferences.setInt('diceCount', _diceCount);
    await preferences.setInt('pointerCount', _pointerCount);
    await preferences.setInt('ninjaCount', _ninjaCount);

    // Save option list
    List<String> optionListJson =
        _optionList.map((option) => jsonEncode(option.toJson())).toList();
    await preferences.setStringList('optionList', optionListJson);
  }

  // --- Methods to interact with and update the global stats and options ---

  Future<void> incrementLeftRight() async {
    _leftRightCount++;
    await _saveStats();
    notifyListeners();
  }

  Future<void> incrementDice() async {
    _diceCount++;
    await _saveStats();
    notifyListeners();
  }

  Future<void> incrementPointer() async {
    _pointerCount++;
    await _saveStats();
    notifyListeners();
  }

  Future<void> incrementNinja() async {
    _ninjaCount++;
    await _saveStats();
    notifyListeners();
  }

  // New method to add an option
  Future<void> addOption(Option option) async {
    _optionList.add(option);
    await _saveStats();
    notifyListeners();
  }

  // New method to remove an option
  Future<void> removeOption(int index) async {
    if (index >= 0 && index < _optionList.length) {
      _optionList.removeAt(index);
      await _saveStats();
      notifyListeners();
    }
  }

  // New method to update an option (e.g., name or chosen status)
  Future<void> updateOption(int index, Option newOption) async {
    if (index >= 0 && index < _optionList.length) {
      _optionList[index] = newOption;
      await _saveStats();
      notifyListeners();
    }
  }

  // New method to set the entire option list (e.g., for bulk updates like reset chosen)
  Future<void> setOptionList(List<Option> newList) async {
    _optionList =
        List.from(newList); // Create a new list to ensure change detection
    await _saveStats();
    notifyListeners();
  }

  // Global reset function
  Future<void> globalResetData() async {
    _leftRightCount = 0;
    _diceCount = 0;
    _pointerCount = 0;
    _ninjaCount = 0;
    _optionList = []; // Reset options as well
    await _saveStats();
    notifyListeners();
  }
}

// Global instance of the AppStatsNotifier
final AppStatsNotifier appStatsNotifier = AppStatsNotifier();

Future<void> initializeGlobals() async {
  // The AppStatsNotifier constructor already calls _loadStats,
  // so this function can remain empty or be used for other initializations
  // that are not related to stats.
}
