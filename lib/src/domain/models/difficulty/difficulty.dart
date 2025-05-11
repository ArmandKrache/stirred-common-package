enum Difficulty {
  beginner('beginner'),
  intermediate('intermediate'),
  advanced('advanced'),
  expert('expert'),
  master('master');

  final String value;

  const Difficulty(this.value);

  static Difficulty fromString(String value) {
    return Difficulty.values.firstWhere((e) => e.value == value);
  }
}
