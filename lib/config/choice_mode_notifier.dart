import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceModeNotifier extends ValueNotifier<ChoiceModeData> {
  static final ChoiceModeNotifier _instance = ChoiceModeNotifier._internal();
  factory ChoiceModeNotifier() => _instance;
  ChoiceModeNotifier._internal() : super(ChoiceModeData());

  Future<void> loadSavedModes() async {
    final prefs = await SharedPreferences.getInstance();

    final savedBinaryMode = prefs.getString('binaryMode');
    if (savedBinaryMode != null) {
      value = value.copyWith(
        binaryMode: BinaryMode.values.firstWhere(
          (m) => m.name == savedBinaryMode,
          orElse: () => BinaryMode.leftRight,
        ),
      );
    }

    final savedDiceType = prefs.getString('diceType');
    if (savedDiceType != null) {
      value = value.copyWith(
        diceType: DiceType.values.firstWhere(
          (d) => d.name == savedDiceType,
          orElse: () => DiceType.d6,
        ),
      );
    }

    final savedNumberOfDice = prefs.getInt('numberOfDice');
    if (savedNumberOfDice != null) {
      value = value.copyWith(numberOfDice: savedNumberOfDice);
    }
  }

  Future<void> setBinaryMode(BinaryMode mode) async {
    value = value.copyWith(binaryMode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('binaryMode', mode.name);
  }

  Future<void> setDiceType(DiceType type) async {
    value = value.copyWith(diceType: type);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('diceType', type.name);
  }

  Future<void> setNumberOfDice(int number) async {
    value = value.copyWith(numberOfDice: number);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('numberOfDice', number);
  }
}

enum BinaryMode { leftRight, yesNo, headsTails }

enum DiceType {
  d4(4, 'D4'),
  d6(6, 'D6'),
  d8(8, 'D8'),
  d10(10, 'D10'),
  d12(12, 'D12'),
  d20(20, 'D20');

  final int faces;
  final String label;
  const DiceType(this.faces, this.label);
}

class ChoiceModeData {
  final BinaryMode binaryMode;
  final DiceType diceType;
  final int numberOfDice;

  ChoiceModeData({
    this.binaryMode = BinaryMode.leftRight,
    this.diceType = DiceType.d6,
    this.numberOfDice = 1,
  });

  ChoiceModeData copyWith({
    BinaryMode? binaryMode,
    DiceType? diceType,
    int? numberOfDice,
  }) {
    return ChoiceModeData(
      binaryMode: binaryMode ?? this.binaryMode,
      diceType: diceType ?? this.diceType,
      numberOfDice: numberOfDice ?? this.numberOfDice,
    );
  }
}

final choiceModeNotifier = ChoiceModeNotifier();
