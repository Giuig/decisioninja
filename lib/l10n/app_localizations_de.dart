// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcomeToDecisioninja => 'Willkommen bei Decisioninja!';

  @override
  String get statsDisplayedHere => 'Ihre Statistiken werden hier angezeigt';

  @override
  String get decisionsMadeSoFar => 'Bisher getroffene Entscheidungen:';

  @override
  String get leftRight => 'L/R';

  @override
  String get dice => 'Würfel';

  @override
  String get pointer => 'Zeiger';

  @override
  String get ninja => 'Ninja';

  @override
  String get chooseLeftRight => 'Wählen Sie links oder rechts!';

  @override
  String get choosing => 'Ich wähle...';

  @override
  String theResultIs(Object result) {
    return 'Das Ergebnis ist: $result';
  }

  @override
  String get left => 'links';

  @override
  String get right => 'rechts';

  @override
  String get throwDie => 'Würfeln!';

  @override
  String get throwDice => 'Würfeln!';

  @override
  String get throwing => 'Ich werfe...';

  @override
  String get totalScore => 'Gesamtpunktzahl: ';

  @override
  String get pointArrow => 'Ziele auf den Pfeil!';

  @override
  String get pointing => 'Ich zielen...';

  @override
  String get arrowResult => 'Das Ergebnis ist: dort';

  @override
  String get addFirstNinja => 'Optionen hinzufügen!';

  @override
  String get createNinja => 'Option erstellen';

  @override
  String get chooseNinja => 'Wähle eine Option!';

  @override
  String get nameNinja => 'Name der Option';

  @override
  String get chosenNinja => 'Gewählte Option: ';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yesNo => 'Ja/Nein';

  @override
  String get headsTails => 'Kopf/Zahl';

  @override
  String get chooseYesNo => 'Wähle Ja oder Nein!';

  @override
  String get flipCoin => 'Münze werfen!';

  @override
  String get yes => 'ja';

  @override
  String get no => 'nein';

  @override
  String get heads => 'Kopf';

  @override
  String get tails => 'Zahl';

  @override
  String get coinFlip => 'Münzwurf';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => 'L/R';

  @override
  String get yesNoLabel => 'J/N';

  @override
  String get headsTailsLabel => 'K/Z';

  @override
  String get editOption => 'Option bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get defaultOptionName => 'Option';
}
