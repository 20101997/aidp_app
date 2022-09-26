import 'package:url_launcher/url_launcher.dart';

class Helper {
  static goToLink(String link) async {
    String url = link;
      await launchUrl(Uri.parse(url));
  }
}
