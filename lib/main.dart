import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/choice_mode_notifier.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:decisioninja/pages/config/first_page_config.dart';
import 'package:flutter/material.dart';
import 'package:ninja_material/bootstrap.dart';
import 'package:provider/provider.dart';

Future<void> _initializeChoiceMode() async {
  await choiceModeNotifier.loadSavedModes();
}

void main() => runNinjaApp(
      defaultSeedColor: Colors.pink.shade400,
      specificLocalizationDelegate: AppLocalizations.delegate,
      appFirstPageConfig: appFirstPageConfig,
      additionalFunctions: [
        initializeGlobals,
        _initializeChoiceMode,
      ],
      additionalProviders: [
        ChangeNotifierProvider<AppStatsNotifier>(
          create: (_) => appStatsNotifier,
        ),
        ChangeNotifierProvider<ChoiceModeNotifier>.value(
          value: choiceModeNotifier,
        ),
      ],
    );
