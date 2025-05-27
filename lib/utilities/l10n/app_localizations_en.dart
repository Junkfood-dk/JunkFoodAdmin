// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homePageTitle => 'Dishes';

  @override
  String get logoutButton => 'Logout';

  @override
  String get punchText => 'You have punched the button this many times:';

  @override
  String get postDishButton => 'Add new dish';

  @override
  String get addExistingDishButton => 'Add to todays menu';

  @override
  String get existingDishAdded => 'The dish has been added to todays menu';

  @override
  String get removeExistingDishButton => 'Remove from the menu';

  @override
  String get existingDishRemoved => 'The dish has been removed from the menu';

  @override
  String get signInSuccessful => 'Sign in successful!';

  @override
  String get signInError => 'Unexpected error occurred';

  @override
  String get signInTitle => 'Sign in to Chef\'s app';

  @override
  String get signInText => 'Sign in with your email and password below';

  @override
  String get signInButton => 'Sign In';

  @override
  String get emailFieldLabel => 'Email';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get addDishPageTitle => 'Add new dish';

  @override
  String get textFormLabelForName => 'Name';

  @override
  String get textFormLabelForDescription => 'Description';

  @override
  String get textFormLabelForCalories => 'Calories';

  @override
  String get invalidURLPromt => 'The entered URL was invalid';

  @override
  String get textFormLabelForImageURL => 'Image URL';

  @override
  String get submitButton => 'Submit';

  @override
  String get addCategoryField => 'Add new category';

  @override
  String get addAllergenField => 'Add new allergen';

  @override
  String get noDescription => 'No description';

  @override
  String get noCalories => 'No calories';

  @override
  String get noTitle => 'No title';

  @override
  String get noDishType => 'No dishtype';

  @override
  String get calories => 'Calories';

  @override
  String get takePictureLabel => 'Add Picture From Camera';

  @override
  String get cameraTitle => 'Take a picture';

  @override
  String get pictureSatisfied => 'Are you happy with this picture?';

  @override
  String get saveButton => 'Save';

  @override
  String get signout => 'Sign out';

  @override
  String get today => 'Today';

  @override
  String numberOfRatings(int count) {
    return 'Number of ratings: $count';
  }

  @override
  String get noRatings => 'No ratings';

  @override
  String get noComments => 'No comments available';

  @override
  String commentCount(int current, int total) {
    return 'Comment $current of $total';
  }

  @override
  String get allergens => 'Allergens';

  @override
  String get noAllergens => 'No allergens listed';
}
