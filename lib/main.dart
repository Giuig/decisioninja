import 'package:decisioninja/config/config.dart';
import 'package:decisioninja/config/choice_mode_notifier.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:decisioninja/pages/config/first_page_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ninja_material/bootstrap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _initializeChoiceMode() async {
  await choiceModeNotifier.loadSavedModes();
}

void main() {
  // Namespace this app's stored preferences. WEB ONLY, and it must stay the
  // first thing that happens.
  //
  // Every ninja app is served from the same origin —
  // https://giuig.github.io/<app>/ — and browser storage is scoped to the
  // ORIGIN, not the path. `shared_preferences` writes every key with a flat
  // `flutter.` prefix, so the apps shared one key space and silently
  // overwrote each other: picking a theme colour in one repainted the others,
  // and any same-named key (`favorites`, `themeMode`) collided outright.
  //
  // Native is deliberately excluded. Each platform app already has its own
  // sandbox, so the collision cannot happen there — and changing the prefix
  // on Android would orphan every existing user's saved choices and theme.
  // Web users lose their stored settings once, which is the accepted cost of
  // ending the collision.
  //
  // `setPrefix` throws a StateError once anything has called
  // `SharedPreferences.getInstance()`, so it cannot move below
  // `runNinjaApp` — `initializeGlobals` and `_initializeChoiceMode` both read
  // preferences. This is why `main` has a block body rather than the
  // expression body it used to have.
  if (kIsWeb) {
    SharedPreferences.setPrefix('decisioninja.');
  }

  runNinjaApp(
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
}
