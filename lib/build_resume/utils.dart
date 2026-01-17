import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> mailTo(String email) async {
    if (email.isEmpty) {
      return;
    }
    final Uri emailUrl = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(emailUrl)) {
      throw Exception('Could not launch $emailUrl');
    }
  }

  static Future<void> launchURLBrowser(String uri) async {
    var url = Uri.parse(uri);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static String safeUrl(url) => Uri.encodeFull(url);


}
