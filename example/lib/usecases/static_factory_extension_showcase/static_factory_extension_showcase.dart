class User {
  final String name;
  final int age;

  User(this.name, this.age);

  static String getDefaultName() {
    return 'Guest';
  }

  static int calculateBirthYear(int currentYear, int age) {
    if (age < 0) throw ArgumentError('Age cannot be negative');
    return currentYear - age;
  }

  factory User.guest() {
    return User('Guest', 0);
  }

  factory User.admin(String name) {
    if (name.isEmpty) {
      return User('Guest', 0);
    }

    return User(name, 99);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && name == other.name && age == other.age;

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

extension type UserId(int value) {
  bool get isValid => value > 0;

  String toFormattedString() {
    return 'ID-$value';
  }

  int addOffset(int offset) {
    return value + offset;
  }
}
