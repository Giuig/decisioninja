// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeToDecisioninja => 'Bienvenue dans Decisioninja!';

  @override
  String get statsDisplayedHere => 'Vos statistiques seront affichées ici';

  @override
  String get decisionsMadeSoFar => 'Décisions prises jusqu\'à présent :';

  @override
  String get leftRight => 'G/D';

  @override
  String get dice => 'Dés';

  @override
  String get pointer => 'Pointeur';

  @override
  String get ninja => 'Ninja';

  @override
  String get chooseLeftRight => 'Choisissez gauche ou droite !';

  @override
  String get choosing => 'Je choisis...';

  @override
  String theResultIs(Object result) {
    return 'Le résultat est : $result';
  }

  @override
  String get left => 'gauche';

  @override
  String get right => 'droite';

  @override
  String get throwDie => 'Lancez le dé !';

  @override
  String get throwDice => 'Lancez les dés !';

  @override
  String get throwing => 'Je lance...';

  @override
  String get totalScore => 'Score total : ';

  @override
  String get pointArrow => 'Visez la flèche !';

  @override
  String get pointing => 'Je vise...';

  @override
  String get arrowResult => 'Le résultat est : là';

  @override
  String get addFirstNinja => 'Ajouter des options !';

  @override
  String get createNinja => 'Créer une option';

  @override
  String get chooseNinja => 'Choisir une option !';

  @override
  String get nameNinja => 'Nom de l\'option';

  @override
  String get chosenNinja => 'Option choisie : ';

  @override
  String get cancel => 'Annuler';

  @override
  String get yesNo => 'Oui/Non';

  @override
  String get headsTails => 'Pile/Face';

  @override
  String get chooseYesNo => 'Choisissez Oui ou Non !';

  @override
  String get flipCoin => 'Lancez la pièce !';

  @override
  String get yes => 'oui';

  @override
  String get no => 'non';

  @override
  String get heads => 'pile';

  @override
  String get tails => 'face';

  @override
  String get coinFlip => 'Lancer de pièce';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => 'G/D';

  @override
  String get yesNoLabel => 'O/N';

  @override
  String get headsTailsLabel => 'P/F';

  @override
  String get editOption => 'Modifier l\'option';

  @override
  String get save => 'Enregistrer';

  @override
  String get defaultOptionName => 'Option';
}
