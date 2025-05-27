import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_en.dart';

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
    Locale('da'),
    Locale('en')
  ];

  /// This is the title banner of the Homepage
  ///
  /// In en, this message translates to:
  /// **'Dishes'**
  String get homePageTitle;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// The text in the middle, describing how many times you have punched the button
  ///
  /// In en, this message translates to:
  /// **'You have punched the button this many times:'**
  String get punchText;

  /// This is the button that will show you the post dish page
  ///
  /// In en, this message translates to:
  /// **'Add new dish'**
  String get postDishButton;

  /// This is the button that will add an existing dish to todays menu
  ///
  /// In en, this message translates to:
  /// **'Add to todays menu'**
  String get addExistingDishButton;

  /// Message saying the dish was successfully added to todays menu
  ///
  /// In en, this message translates to:
  /// **'The dish has been added to todays menu'**
  String get existingDishAdded;

  /// This is the button that will remove an existing dish from the menu
  ///
  /// In en, this message translates to:
  /// **'Remove from the menu'**
  String get removeExistingDishButton;

  /// Message saying the dish was successfully removed from the menu
  ///
  /// In en, this message translates to:
  /// **'The dish has been removed from the menu'**
  String get existingDishRemoved;

  /// Message saying the sign in was successful
  ///
  /// In en, this message translates to:
  /// **'Sign in successful!'**
  String get signInSuccessful;

  /// When an unexpected error occurs
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get signInError;

  /// Title of the login page
  ///
  /// In en, this message translates to:
  /// **'Sign in to Chef\'s app'**
  String get signInTitle;

  /// Text to describe what to do on the login page
  ///
  /// In en, this message translates to:
  /// **'Sign in with your email and password below'**
  String get signInText;

  /// Text for the sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFieldLabel;

  /// Label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFieldLabel;

  /// Title of the add dish page
  ///
  /// In en, this message translates to:
  /// **'Add new dish'**
  String get addDishPageTitle;

  /// Label descriping the input for the name of the dish
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get textFormLabelForName;

  /// Label describing the input for the description of the dish
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get textFormLabelForDescription;

  /// Label describing the input for the name of the dish
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get textFormLabelForCalories;

  /// Prompts the user that the URL is invalid
  ///
  /// In en, this message translates to:
  /// **'The entered URL was invalid'**
  String get invalidURLPromt;

  /// Label describing the input for the imageURL of the dish
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get textFormLabelForImageURL;

  /// Button that submits something
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// Field that adds new category to dish
  ///
  /// In en, this message translates to:
  /// **'Add new category'**
  String get addCategoryField;

  /// Field that adds new allergen to dish
  ///
  /// In en, this message translates to:
  /// **'Add new allergen'**
  String get addAllergenField;

  /// Display message for when no description
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// Display message for when no calories
  ///
  /// In en, this message translates to:
  /// **'No calories'**
  String get noCalories;

  /// Display message for when no title
  ///
  /// In en, this message translates to:
  /// **'No title'**
  String get noTitle;

  /// Display message for when no dishtype
  ///
  /// In en, this message translates to:
  /// **'No dishtype'**
  String get noDishType;

  /// Calories info on dish page
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// Label describing that the button is where to take aa picture of the dish
  ///
  /// In en, this message translates to:
  /// **'Add Picture From Camera'**
  String get takePictureLabel;

  /// Title with instruction on what to do
  ///
  /// In en, this message translates to:
  /// **'Take a picture'**
  String get cameraTitle;

  /// Ask the user if they are satisfied with the picture of the dish
  ///
  /// In en, this message translates to:
  /// **'Are you happy with this picture?'**
  String get pictureSatisfied;

  /// Text for save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Text for sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signout;

  /// Text for button for setting the date to todays date
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Shows the total number of ratings for a dish
  ///
  /// In en, this message translates to:
  /// **'Number of ratings: {count}'**
  String numberOfRatings(int count);

  /// Shown when a dish has no ratings yet
  ///
  /// In en, this message translates to:
  /// **'No ratings'**
  String get noRatings;

  /// Shown when a dish has no comments
  ///
  /// In en, this message translates to:
  /// **'No comments available'**
  String get noComments;

  /// Shows the current comment number and total number of comments
  ///
  /// In en, this message translates to:
  /// **'Comment {current} of {total}'**
  String commentCount(int current, int total);

  /// Label for allergens section
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get allergens;

  /// Shown when a dish has no allergens listed
  ///
  /// In en, this message translates to:
  /// **'No allergens listed'**
  String get noAllergens;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['da', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
