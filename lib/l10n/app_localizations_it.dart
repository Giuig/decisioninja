// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get welcomeToDecisioninja => 'Decisioninja ti dà il benvenuto!';

  @override
  String get statsDisplayedHere => 'Le tue statistiche saranno mostrate qui';

  @override
  String get decisionsMadeSoFar => 'Decisioni prese fino ad ora:';

  @override
  String get leftRight => 'SX/DX';

  @override
  String get dice => 'Dadi';

  @override
  String get pointer => 'Puntatore';

  @override
  String get ninja => 'Ninja';

  @override
  String get chooseLeftRight => 'Scegli destra o sinistra!';

  @override
  String get choosing => 'Sto scegliendo...';

  @override
  String theResultIs(Object result) {
    return 'Il risultato è: $result';
  }

  @override
  String get left => 'sinistra';

  @override
  String get right => 'destra';

  @override
  String get throwDie => 'Lancia il dado!';

  @override
  String get throwDice => 'Lancia i dadi!';

  @override
  String get throwing => 'Sto lanciando...';

  @override
  String get totalScore => 'Totale: ';

  @override
  String get pointArrow => 'Punta la freccia!';

  @override
  String get pointing => 'Sto puntando...';

  @override
  String get arrowResult => 'Il risultato è: lì';

  @override
  String get addFirstNinja => 'Aggiungi opzioni!';

  @override
  String get createNinja => 'Crea Opzione';

  @override
  String get chooseNinja => 'Scegli opzione!';

  @override
  String get nameNinja => 'Nome Opzione';

  @override
  String get chosenNinja => 'Opzione scelta: ';

  @override
  String get cancel => 'Cancella';

  @override
  String get yesNo => 'Sì/No';

  @override
  String get headsTails => 'Testa/Croce';

  @override
  String get chooseYesNo => 'Scegli Sì o No!';

  @override
  String get flipCoin => 'Lancia la moneta!';

  @override
  String get yes => 'sì';

  @override
  String get no => 'no';

  @override
  String get heads => 'testa';

  @override
  String get tails => 'croce';

  @override
  String get coinFlip => 'Lancio di moneta';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => 'S/D';

  @override
  String get yesNoLabel => 'S/N';

  @override
  String get headsTailsLabel => 'T/C';

  @override
  String get editOption => 'Modifica Opzione';

  @override
  String get save => 'Salva';

  @override
  String get defaultOptionName => 'Opzione';
}
