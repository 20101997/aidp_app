import 'package:url_launcher/url_launcher.dart';

class Helper {
  static goToLink(String link) async {
    String url = link;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
