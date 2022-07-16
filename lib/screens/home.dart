import 'package:aidp_app/screens/notifications.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/colors.dart';
import '../constants/url.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl: BASE_URL,
          javascriptMode: JavascriptMode.unrestricted,
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: Badge(
                badgeContent: Text(
                  "3",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                child: new Icon(
                  Icons.notifications,
                  color: Color(CommonColors.PRIMARY_COLOR),
                  size: 40,
                )),
            backgroundColor: new Color(CommonColors.SECONDRY_COLOR),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
              );
            }));
  }
}