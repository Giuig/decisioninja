import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja')
  ];

  /// No description provided for @welcomeToDecisioninja.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Decisioninja!'**
  String get welcomeToDecisioninja;

  /// No description provided for @statsDisplayedHere.
  ///
  /// In en, this message translates to:
  /// **'Your stats will be displayed here'**
  String get statsDisplayedHere;

  /// No description provided for @decisionsMadeSoFar.
  ///
  /// In en, this message translates to:
  /// **'Decisions made so far:'**
  String get decisionsMadeSoFar;

  /// No description provided for @leftRight.
  ///
  /// In en, this message translates to:
  /// **'Left/Right'**
  String get leftRight;

  /// No description provided for @dice.
  ///
  /// In en, this message translates to:
  /// **'Dice'**
  String get dice;

  /// No description provided for @pointer.
  ///
  /// In en, this message translates to:
  /// **'Pointer'**
  String get pointer;

  /// No description provided for @ninja.
  ///
  /// In en, this message translates to:
  /// **'Ninja'**
  String get ninja;

  /// No description provided for @chooseLeftRight.
  ///
  /// In en, this message translates to:
  /// **'Choose left or right!'**
  String get chooseLeftRight;

  /// No description provided for @choosing.
  ///
  /// In en, this message translates to:
  /// **'Choosing...'**
  String get choosing;

  /// No description provided for @theResultIs.
  ///
  /// In en, this message translates to:
  /// **'The result is: {result}'**
  String theResultIs(Object result);

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get left;

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'right'**
  String get right;

  /// No description provided for @throwDie.
  ///
  /// In en, this message translates to:
  /// **'Roll the die!'**
  String get throwDie;

  /// No description provided for @throwDice.
  ///
  /// In en, this message translates to:
  /// **'Roll the dice!'**
  String get throwDice;

  /// No description provided for @throwing.
  ///
  /// In en, this message translates to:
  /// **'Rolling...'**
  String get throwing;

  /// No description provided for @totalScore.
  ///
  /// In en, this message translates to:
  /// **'Total score: '**
  String get totalScore;

  /// No description provided for @pointArrow.
  ///
  /// In en, this message translates to:
  /// **'Point the arrow!'**
  String get pointArrow;

  /// No description provided for @pointing.
  ///
  /// In en, this message translates to:
  /// **'Pointing...'**
  String get pointing;

  /// No description provided for @arrowResult.
  ///
  /// In en, this message translates to:
  /// **'The result is: there'**
  String get arrowResult;

  /// No description provided for @addFirstNinja.
  ///
  /// In en, this message translates to:
  /// **'Add options first!'**
  String get addFirstNinja;

  /// No description provided for @createNinja.
  ///
  /// In en, this message translates to:
  /// **'Create Option'**
  String get createNinja;

  /// No description provided for @chooseNinja.
  ///
  /// In en, this message translates to:
  /// **'Choose the option!'**
  String get chooseNinja;

  /// No description provided for @nameNinja.
  ///
  /// In en, this message translates to:
  /// **'Option Name'**
  String get nameNinja;

  /// No description provided for @chosenNinja.
  ///
  /// In en, this message translates to:
  /// **'Chosen option: '**
  String get chosenNinja;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yesNo.
  ///
  /// In en, this message translates to:
  /// **'Yes/No'**
  String get yesNo;

  /// No description provided for @headsTails.
  ///
  /// In en, this message translates to:
  /// **'Heads/Tails'**
  String get headsTails;

  /// No description provided for @chooseYesNo.
  ///
  /// In en, this message translates to:
  /// **'Choose Yes or No!'**
  String get chooseYesNo;

  /// No description provided for @flipCoin.
  ///
  /// In en, this message translates to:
  /// **'Flip Coin!'**
  String get flipCoin;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @heads.
  ///
  /// In en, this message translates to:
  /// **'heads'**
  String get heads;

  /// No description provided for @tails.
  ///
  /// In en, this message translates to:
  /// **'tails'**
  String get tails;

  /// No description provided for @coinFlip.
  ///
  /// In en, this message translates to:
  /// **'Coin Flip'**
  String get coinFlip;

  /// No description provided for @selectDice.
  ///
  /// In en, this message translates to:
  /// **'Select dice type'**
  String get selectDice;

  /// No description provided for @leftRightLabel.
  ///
  /// In en, this message translates to:
  /// **'L/R'**
  String get leftRightLabel;

  /// No description provided for @yesNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Y/N'**
  String get yesNoLabel;

  /// No description provided for @headsTailsLabel.
  ///
  /// In en, this message translates to:
  /// **'H/T'**
  String get headsTailsLabel;

  /// No description provided for @editOption.
  ///
  /// In en, this message translates to:
  /// **'Edit Option'**
  String get editOption;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @defaultOptionName.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get defaultOptionName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
