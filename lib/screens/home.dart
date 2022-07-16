
import 'package:aidp_app/screens/notifications.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/colors.dart';
import '../constants/url.dart';
import '../utils/service.dart';
import '../widgets/banner.dart';
import '../widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ShowBanners() async {
    final prefs = await SharedPreferences.getInstance();

    Map? adv = await Service.getbannerData(MyApplicationUrl.advertisement);
    Map? news = await Service.getbannerData(MyApplicationUrl.news);
    if(prefs.getBool('news_displayed') != true) {
      await prefs.setBool('news_displayed', true);
      if(news !=null) {
        ScaffoldMessenger.of(context).showMaterialBanner(
            CustomizedBanner(context, news["link"], news["foto"]));
      }

    }
    if(prefs.getBool('ad_displayed') != true) {
      await prefs.setBool('ad_displayed', true);
      if(adv !=null) {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomizedSnackbar(context, adv["link"], adv["foto"]));
      }

    }
  }
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      ShowBanners();
    });


    super.initState();
  }

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