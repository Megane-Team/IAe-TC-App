class Assets {
  static const path = 'assets/images';

  static String logos(String name) {
    return '$path/logos/$name.png';
  }

  static String icons(String name) {
    return '$path/icons/$name.png';
  }
}