// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeToDecisioninja => 'Welcome to Decisioninja!';

  @override
  String get statsDisplayedHere => 'Your stats will be displayed here';

  @override
  String get decisionsMadeSoFar => 'Decisions made so far:';

  @override
  String get leftRight => 'Left/Right';

  @override
  String get dice => 'Dice';

  @override
  String get pointer => 'Pointer';

  @override
  String get ninja => 'Ninja';

  @override
  String get chooseLeftRight => 'Choose left or right!';

  @override
  String get choosing => 'Choosing...';

  @override
  String theResultIs(Object result) {
    return 'The result is: $result';
  }

  @override
  String get left => 'left';

  @override
  String get right => 'right';

  @override
  String get throwDie => 'Roll the die!';

  @override
  String get throwDice => 'Roll the dice!';

  @override
  String get throwing => 'Rolling...';

  @override
  String get totalScore => 'Total score: ';

  @override
  String get pointArrow => 'Point the arrow!';

  @override
  String get pointing => 'Pointing...';

  @override
  String get arrowResult => 'The result is: there';

  @override
  String get addFirstNinja => 'Add options first!';

  @override
  String get createNinja => 'Create Option';

  @override
  String get chooseNinja => 'Choose the option!';

  @override
  String get nameNinja => 'Option Name';

  @override
  String get chosenNinja => 'Chosen option: ';

  @override
  String get cancel => 'Cancel';

  @override
  String get yesNo => 'Yes/No';

  @override
  String get headsTails => 'Heads/Tails';

  @override
  String get chooseYesNo => 'Choose Yes or No!';

  @override
  String get flipCoin => 'Flip Coin!';

  @override
  String get yes => 'yes';

  @override
  String get no => 'no';

  @override
  String get heads => 'heads';

  @override
  String get tails => 'tails';

  @override
  String get coinFlip => 'Coin Flip';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => 'L/R';

  @override
  String get yesNoLabel => 'Y/N';

  @override
  String get headsTailsLabel => 'H/T';

  @override
  String get editOption => 'Edit Option';

  @override
  String get save => 'Save';

  @override
  String get defaultOptionName => 'Option';
}
