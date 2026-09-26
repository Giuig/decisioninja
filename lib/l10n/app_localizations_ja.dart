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
  String get addFirstNinja => '選択肢を2つ以上追加してください';

  @override
  String get chooseNinja => '私の代わりに選んで';

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
  String get addOptionHint => '選択肢を追加、または a, b, c を貼り付け';

  @override
  String get addOption => '選択肢を追加';

  @override
  String removeOption(String name) {
    return '$nameを削除';
  }

  @override
  String get dropAndPickAgain => '外してもう一度選ぶ';

  @override
  String get clearAll => 'すべて消去';

  @override
  String get optionsCleared => '選択肢を消去しました';

  @override
  String get undo => '元に戻す';
}
