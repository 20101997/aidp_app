import 'package:aidp_app/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/colors.dart';
import '../constants/url.dart';
import '../models/webPage.dart';
import '../utils/helpers.dart';
import '../utils/service.dart';
import '../widgets/banner.dart';
import '../widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  SharedPreferences prefs;
  HomePage({Key? key, required this.prefs}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  bool openDrawer = false;
  Color drawerIcon = Colors.white;
  Color notificationIcon = Colors.white;
  String webUrl = BASE_URL;
  List<WebPage> webPages = [
    WebPage(name: "HOME", link: BASE_URL),
    WebPage(name: "AGENDA", link: BASE_URL + "lagenda.php"),
    WebPage(name: "PROTAGONISTI", link: BASE_URL + "i-protagonisti.php"),
    WebPage(
        name: "LOCATION & ACCOMODATION", link: BASE_URL + "la-location.php"),
    WebPage(
        name: "TAPPE PRE CONGRESSUALI",
        link: BASE_URL + "tappe-pre-congressuali.php"),
    WebPage(
        name: "PROGRAMMA ACCOMPAGNATORI",
        link: BASE_URL + "programma-accompagnatori.php"),
    WebPage(name: "PARTNER", link: BASE_URL + "/index-2022.php#slide7"),
    WebPage(name: "MEDIA WALL", link: BASE_URL + "media-wall.php"),
  ];

  ShowBanners() async {
    final prefs = await SharedPreferences.getInstance();

    Map? adv = await Service.getbannerData(MyApplicationUrl.advertisement);
    Map? news = await Service.getbannerData(MyApplicationUrl.news);
    if (prefs.getBool('news_displayed') != true) {
      await prefs.setBool('news_displayed', true);
      if (news != null) {
        ScaffoldMessenger.of(context).showMaterialBanner(
            CustomizedBanner(context, news["link"], news["foto"]));
      }
    }
    if (prefs.getBool('ad_displayed') != true) {
      await prefs.setBool('ad_displayed', true);
      if (adv != null) {
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

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        onDrawerChanged: (isOpened) {
          isOpened
              ? setState(() => drawerIcon = Color(CommonColors.SECONDRY_COLOR))
              : setState(() => drawerIcon = Colors.white);
          ;
        },
        onEndDrawerChanged: (isOpened) {
          isOpened
              ? setState(() {
                  notificationIcon = Color(CommonColors.SECONDRY_COLOR);
                  widget.prefs.setInt("total_receive_notifications", 0);
                  _removeBadge();
                })
              : setState(() => notificationIcon = Colors.white);
          ;
        },
        drawerScrimColor: Colors.transparent,
        endDrawer: Padding(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Drawer(
              elevation: 0,
              width: MediaQuery.of(context).size.width,
              backgroundColor: Color(CommonColors.PRIMARY_COLOR),
              child: NotificationsPage()),
        ),
        drawer: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 80, 0, MediaQuery.of(context).size.height / 4),
          child: new Drawer(
            elevation: 0,
            width: MediaQuery.of(context).size.width,
            backgroundColor: Color(CommonColors.PRIMARY_COLOR),
            child: ListView.separated(
              itemCount: webPages.length,
              itemBuilder: (context, i) {
                return ListTile(
                    onTap: () {
                      setState(() {
                        controller.loadUrl(webPages[i].link);
                        webUrl = webPages[i].link;
                      });
                      Scaffold.of(context).closeDrawer();
                    },
                    title: Text(
                      webPages[i].name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: webPages[i].link == webUrl
                              ? Colors.white
                              : Color(CommonColors.SECONDRY_COLOR)),
                    ));
              },
              separatorBuilder: (context, index) => Divider(
                height: 3,
                color: Color(CommonColors.SECONDRY_COLOR),
              ),
            ),
          ),
        ),
        //  drawerEdgeDragWidth: 30,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0), // here the desired height
          child: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 35,
                  color: drawerIcon,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              new Stack(children: <Widget>[
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(
                      Icons.notifications,
                      size: 35,
                      color: notificationIcon,
                    ),
                  );
                }),
                if (widget.prefs.getInt("total_receive_notifications") !=
                        null &&
                    widget.prefs.getInt("total_receive_notifications") != 0)
                  new Positioned(
                    top: 10,
                    right: 5,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: new Text(
                        widget.prefs
                            .getInt("total_receive_notifications")
                            .toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ])
            ],
            title: Container(
              width: 120,
              child: Image.asset(
                'assets/logo congresso-2022-03.png',
                //  height: 100,
                //  width: 100,
                fit: BoxFit.cover,
                height: 65,
              ),
            ),
            centerTitle: true, // like this!
          ),
        ),
        body: Scaffold(
          body: WebView(
              initialUrl: webUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller = webViewController;
              }),
        ));
  }
}
