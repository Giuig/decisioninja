import 'package:decisioninja/config/choice_mode_notifier.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:decisioninja/pages/dice_page.dart' as app_dice;
import 'package:decisioninja/pages/binary_decision_page.dart';
import 'package:decisioninja/pages/ninja_page.dart';
import 'package:decisioninja/pages/pointer_page.dart';
import 'package:flutter/material.dart';
import 'package:ninja_material/pages/first_page.dart';
import 'package:ninja_material/l10n/app_localizations.dart' as ninja_material;
import 'package:provider/provider.dart';

import '../home_page.dart';

final FirstPageConfig appFirstPageConfig = FirstPageConfig(
  destinationsBuilder: appDestinationsBuilder,
  pages: appPages,
);

final appPages = [
  HomePage(),
  BinaryDecisionPage(),
  app_dice.DicePage(),
  PointerPage(),
  NinjaPage(),
];

IconData _getBinaryModeIcon(BinaryMode mode, bool selected) {
  switch (mode) {
    case BinaryMode.leftRight:
      return selected ? Icons.compare_arrows : Icons.compare_arrows_outlined;
    case BinaryMode.yesNo:
      return selected ? Icons.help : Icons.help_outlined;
    case BinaryMode.headsTails:
      return selected ? Icons.monetization_on : Icons.monetization_on_outlined;
  }
}

String _getBinaryModeLabel(BinaryMode mode, AppLocalizations l10n) {
  switch (mode) {
    case BinaryMode.leftRight:
      return l10n.leftRightLabel;
    case BinaryMode.yesNo:
      return l10n.yesNoLabel;
    case BinaryMode.headsTails:
      return l10n.headsTailsLabel;
  }
}

List<NavigationDestination> appDestinationsBuilder(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final choiceMode = context.watch<ChoiceModeNotifier>().value;
  return [
    NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: ninja_material.AppLocalizations.of(context)!.home,
    ),
    NavigationDestination(
      selectedIcon: Icon(_getBinaryModeIcon(choiceMode.binaryMode, true)),
      icon: Icon(_getBinaryModeIcon(choiceMode.binaryMode, false)),
      label: _getBinaryModeLabel(choiceMode.binaryMode, l10n),
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.casino),
      icon: Icon(Icons.casino_outlined),
      label: l10n.dice,
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.arrow_circle_left),
      icon: Icon(Icons.arrow_circle_left_outlined),
      label: AppLocalizations.of(context)!.pointer,
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.question_answer),
      icon: Icon(Icons.question_answer_outlined),
      label: AppLocalizations.of(context)!.ninja,
    ),
  ];
}
