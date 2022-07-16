


import 'package:url_launcher/url_launcher.dart';

class Helper {

 static goToLink(String link) async {
   String url = link;
   if (await canLaunch(url)) {
     await launch(url);
   } else {
     throw 'Could not launch $url';
   }
 }





}


