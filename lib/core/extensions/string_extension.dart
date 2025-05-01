extension StringExtension on String {
  String get capitalizeFirstLetterOnly =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  String get getFirstLetterCapitalized => substring(0, 1).toUpperCase();
}
