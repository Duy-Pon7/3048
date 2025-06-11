enum Gender { male, female }

extension GenderExtension on Gender {
  String get description {
    switch (this) {
      case Gender.male:
        return 'Nam';
      case Gender.female:
        return 'Nữ';
    }
  }
}

Gender toGender(int gender) {
  switch (gender) {
    case 1:
      return Gender.male;
    default:
      return Gender.female;
  }
}
