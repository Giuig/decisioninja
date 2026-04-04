// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeToDecisioninja => '¡Decisioninja te da la bienvenida!';

  @override
  String get statsDisplayedHere => 'Tus estadísticas se mostrarán aquí';

  @override
  String get decisionsMadeSoFar => 'Decisiones tomadas hasta ahora:';

  @override
  String get leftRight => 'Izq./Der.';

  @override
  String get dice => 'Dados';

  @override
  String get pointer => 'Puntero';

  @override
  String get ninja => 'Ninja';

  @override
  String get chooseLeftRight => '¡Elige izquierda o derecha!';

  @override
  String get choosing => 'Estoy eligiendo...';

  @override
  String theResultIs(Object result) {
    return 'El resultado es: $result';
  }

  @override
  String get left => 'izquierda';

  @override
  String get right => 'derecha';

  @override
  String get throwDie => '¡Tira el dado!';

  @override
  String get throwDice => '¡Tira los dados!';

  @override
  String get throwing => 'Estoy tirando...';

  @override
  String get totalScore => 'Total: ';

  @override
  String get pointArrow => '¡Apunta la flecha!';

  @override
  String get pointing => 'Estoy apuntando...';

  @override
  String get arrowResult => 'El resultado es: allí';

  @override
  String get addFirstNinja => '¡Añadir opciones!';

  @override
  String get createNinja => 'Crear opción';

  @override
  String get chooseNinja => '¡Elige una opción!';

  @override
  String get nameNinja => 'nombre de la opción';

  @override
  String get chosenNinja => 'Opción elegida: ';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yesNo => 'Sí/No';

  @override
  String get headsTails => 'Cara/Cruz';

  @override
  String get chooseYesNo => '¡Elige Sí o No!';

  @override
  String get flipCoin => '¡Lanza la moneda!';

  @override
  String get yes => 'sí';

  @override
  String get no => 'no';

  @override
  String get heads => 'cara';

  @override
  String get tails => 'cruz';

  @override
  String get coinFlip => 'Lanzamiento de moneda';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => 'I/D';

  @override
  String get yesNoLabel => 'S/N';

  @override
  String get headsTailsLabel => 'C/S';

  @override
  String get editOption => 'Editar opción';

  @override
  String get save => 'Guardar';

  @override
  String get defaultOptionName => 'Opción';
}
