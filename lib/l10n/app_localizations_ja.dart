// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get welcomeToDecisioninja => 'Decisioninjaへようこそ！';

  @override
  String get statsDisplayedHere => 'ここにあなたの統計が表示されます';

  @override
  String get decisionsMadeSoFar => 'これまでの意思決定：';

  @override
  String get leftRight => '左/右';

  @override
  String get dice => 'サイコロ';

  @override
  String get pointer => 'ポインター';

  @override
  String get ninja => '忍者';

  @override
  String get chooseLeftRight => '右か左を選ぶ！';

  @override
  String get choosing => '選んでいます...';

  @override
  String theResultIs(Object result) {
    return '結果は：$result';
  }

  @override
  String get left => '左';

  @override
  String get right => '右';

  @override
  String get throwDie => 'サイコロを投げる！';

  @override
  String get throwDice => 'サイコロを投げる！';

  @override
  String get throwing => '投げています...';

  @override
  String get totalScore => '合計：';

  @override
  String get pointArrow => '矢を指して！';

  @override
  String get pointing => '指しています...';

  @override
  String get arrowResult => '結果は：ここ';

  @override
  String get addFirstNinja => 'オプションを追加!';

  @override
  String get createNinja => 'オプションを作成';

  @override
  String get chooseNinja => 'オプションを選択！';

  @override
  String get nameNinja => 'オプションの名前';

  @override
  String get chosenNinja => '選ばれたオプション：';

  @override
  String get cancel => 'キャンセル';

  @override
  String get yesNo => 'はい/いいえ';

  @override
  String get headsTails => '表/裏';

  @override
  String get chooseYesNo => 'はいかいいえを選んで！';

  @override
  String get flipCoin => 'コインを投げよう！';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get heads => '表';

  @override
  String get tails => '裏';

  @override
  String get coinFlip => 'コイン投げ';

  @override
  String get selectDice => 'Select dice type';

  @override
  String get leftRightLabel => '左/右';

  @override
  String get yesNoLabel => 'O/X';

  @override
  String get headsTailsLabel => '表/裏';

  @override
  String get editOption => 'オプションを編集';

  @override
  String get save => '保存';

  @override
  String get defaultOptionName => 'オプション';
}
