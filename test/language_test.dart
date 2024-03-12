import 'package:flutter_test/flutter_test.dart';
import 'package:chefapp/model/language.dart';

void main() {
  test('English is present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'English');

    // Assert
    expect(englishExists, isTrue);
  });

  test('Spanish is not present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'Spanish');

    // Assert
    expect(englishExists, isFalse);
  });

  test('Language object for English (id: 1) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language englishLanguage =
        languages.firstWhere((language) => language.id == 1);

    // Assert
    expect(englishLanguage.name, equals('English'));
  });

  test('Language object for Danish (id: 2) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language danishLanguage =
        languages.firstWhere((language) => language.id == 2);

    // Assert
    expect(danishLanguage.name, equals('Dansk'));
  });

  test('Language object with id 3000 does not exist', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool id3Exists = languages.any((language) => language.id == 3000);

    // Assert
    expect(id3Exists, isFalse);
  });
}
