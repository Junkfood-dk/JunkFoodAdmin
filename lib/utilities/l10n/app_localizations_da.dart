// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get homePageTitle => 'Retter';

  @override
  String get logoutButton => 'Log ud';

  @override
  String get punchText => 'Du har trykket på knappen så mange gange:';

  @override
  String get postDishButton => 'Tilføj ny ret';

  @override
  String get addExistingDishButton => 'Tilføj til dagens menu';

  @override
  String get existingDishAdded => 'Retten er blevet tilføjet til dagens menu';

  @override
  String get removeExistingDishButton => 'Fjern fra menu';

  @override
  String get existingDishRemoved => 'Retten er blevet fjernet fra menuen';

  @override
  String get signInSuccessful => 'Login var en success!';

  @override
  String get signInError => 'Det opstod en uventet fejl';

  @override
  String get signInTitle => 'Log ind på Chef\'s app';

  @override
  String get signInText => 'Log ind med din email og kode herunder';

  @override
  String get signInButton => 'Log ind';

  @override
  String get emailFieldLabel => 'Email';

  @override
  String get passwordFieldLabel => 'Adgangskode';

  @override
  String get addDishPageTitle => 'Tilføj ny ret';

  @override
  String get textFormLabelForName => 'Titel';

  @override
  String get textFormLabelForDescription => 'Beskrivelse';

  @override
  String get textFormLabelForCalories => 'Kalorier';

  @override
  String get invalidURLPromt => 'Den indtastede URL er ugyldig';

  @override
  String get textFormLabelForImageURL => 'Billede URL';

  @override
  String get submitButton => 'Skub';

  @override
  String get addCategoryField => 'Tilføj ny kategori';

  @override
  String get addAllergenField => 'Tiløj nyt allergen';

  @override
  String get noDescription => 'Ingen beskrivelse';

  @override
  String get noCalories => 'Ingen kalorier';

  @override
  String get noTitle => 'Ingen titel';

  @override
  String get noDishType => 'Ingen type ret';

  @override
  String get calories => 'Kalorier';

  @override
  String get takePictureLabel => 'Tag billede med kamera';

  @override
  String get cameraTitle => 'Tag et billede';

  @override
  String get pictureSatisfied => 'Er du tilfreds med billedet?';

  @override
  String get saveButton => 'Gem';

  @override
  String get signout => 'Log af';

  @override
  String get today => 'I dag';

  @override
  String numberOfRatings(int count) {
    return 'Antal bedømmelser: $count';
  }

  @override
  String get noRatings => 'Ingen bedømmelser';

  @override
  String get noComments => 'Ingen kommentarer tilgængelige';

  @override
  String commentCount(int current, int total) {
    return 'Kommentar $current af $total';
  }

  @override
  String get allergens => 'Allergener';

  @override
  String get noAllergens => 'Ingen allergener angivet';
}
