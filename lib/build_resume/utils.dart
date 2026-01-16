class BuildResumeUtils {
  static String firstCapitalAfterSpace(String s) {
    s = s.replaceAll('_', ' ');
    final parts = s.split(' ');
    final capitalizedParts =
        parts.map((part) {
          return part.isNotEmpty
              ? part[0].toUpperCase() + part.substring(1)
              : part;
        }).toList();
    return capitalizedParts.join(' ');
  }

  static String removeSpecialCharacters(String s) {
    final pattern = RegExp(r'[^\w\s]');
    return s.replaceAll(pattern, '');
  }
}
