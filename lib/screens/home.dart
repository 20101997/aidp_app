import 'package:aidp_app/models/notificationTotal.dart';
import 'package:aidp_app/screens/notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/colors.dart';
import '../constants/url.dart';
import '../utils/helpers.dart';
import '../utils/service.dart';
import '../widgets/banner.dart';
import '../widgets/snackbar.dart';
import '../widgets/socialMedia.dart';

class HomePage extends StatefulWidget {
  SharedPreferences prefs;

  HomePage({Key? key, required this.prefs}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  bool openDrawer = false;
  Color drawerIcon = Color(CommonColors.SECONDRY_COLOR);
  Color notificationIcon = Color(CommonColors.SECONDRY_COLOR);
  String webUrl = BASE_URL;
  bool hasInternet = false;
  int _currentIndex = 0;

  ShowBanners(double height, double width) async {
    final prefs = await SharedPreferences.getInstance();

    Map? adv = await Service.getbannerData(MyApplicationUrl.advertisement);
    Map? news = await Service.getbannerData(MyApplicationUrl.news);
    if (prefs.getBool('ad_displayed') != true) {
      await prefs.setBool('ad_displayed', true);
      if (adv != null) {
        ScaffoldMessenger.of(context).showMaterialBanner(CustomizedBanner(
            context, adv["link"], adv["foto"], height * 0.25, width));
      }
    }
    if (prefs.getBool('news_displayed') != true) {
      await prefs.setBool('news_displayed', true);
      if (news != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomizedSnackbar(
            context, news["link"], news["foto"], height * 0.4, width));
      }
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      ShowBanners(screenHeight, screenWidth);
    });
initWebViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
         backgroundColor: Color(CommonColors.Orangee) ,
         body: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, kToolbarHeight+ 8),
              child: Container(
                height:
                    MediaQuery.of(context).size.height + kToolbarHeight,
                child: Scaffold(
                  backgroundColor: Color(CommonColors.PRIMARY_COLOR) ,
                  onDrawerChanged: (isOpened) {
                    isOpened
                        ? setState(
                            () => drawerIcon = Color(CommonColors.SECONDRY_COLOR))
                        : setState(() =>
                            drawerIcon = Color(CommonColors.SECONDRY_COLOR));
                    ;
                  },
                  onEndDrawerChanged: (isOpened) {
                    if (isOpened) {
                      widget.prefs.setInt("total_receive_notifications", 0);
                      Provider.of<NotificationsTotal>(context, listen: false)
                          .setTotal(0);
                      setState(() {
                        notificationIcon = Color(CommonColors.SECONDRY_COLOR);
                      });
                    } else
                      setState(() =>
                          notificationIcon = Color(CommonColors.SECONDRY_COLOR));
                    ;
                  },
                  drawerScrimColor: Colors.transparent,
                  endDrawer: Padding(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, MediaQuery.of(context).size.height / 4),
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
                                  controller.loadRequest(Uri.parse(webPages[i].link));
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
                          thickness: 2,
                          color: Color(CommonColors.SECONDRY_COLOR),
                        ),
                      ),
                    ),
                  ),
                  //  drawerEdgeDragWidth: 30,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: SafeArea(
                      child: AppBar(
                        elevation: 0,
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
                                onPressed: () async {
                                  hasInternet = await InternetConnectionChecker()
                                      .hasConnection;
                                  if (hasInternet)
                                    Scaffold.of(context).openEndDrawer();
                                  else {
                                    showSimpleNotification(
                                        Text("No internet connection"),
                                        background: Colors.red);
                                  }
                                },
                                icon: Icon(
                                  Icons.notifications,
                                  size: 35,
                                  color: notificationIcon,
                                ),
                              );
                            }),
                            Consumer<NotificationsTotal>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return new Positioned(
                                    top: 10,
                                    right: 5,
                                    child: (widget.prefs.getInt(
                                                    "total_receive_notifications") !=
                                                null &&
                                            widget.prefs.getInt(
                                                    "total_receive_notifications") !=
                                                0)
                                        ? new Container(
                                            padding: EdgeInsets.all(1),
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 16,
                                              minHeight: 16,
                                            ),
                                            child: new Text(
                                              value.total.toString(),
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Container());
                              },
                            )
                          ])
                        ],
                        title: Text(
                          "LE RADICI DEL DOMANI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Color(CommonColors.GREY)),
                            ],
                          ),
                        ),
                        centerTitle: true, // like this!
                      ),
                    ),
                  ),
                  body: Container(
                    child:
                        WebViewWidget(
                          controller: controller,
                            // initialUrl: webUrl,
                            // javascriptMode: JavascriptMode.unrestricted,
                            // onWebViewCreated:
                            //     (WebViewController webViewController) {
                            //   controller = webViewController;
                            // },
                            
                            ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                child:SocialMediaBar()),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomNavigationBar(
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(CommonColors.Orangee),
                  unselectedItemColor: Color(CommonColors.SECONDRY_COLOR),
                  selectedItemColor: webUrl == bottomPages[_currentIndex].link ||
                      _currentIndex == 4
                      ? Colors.white
                      : Color(CommonColors.SECONDRY_COLOR),
                  selectedFontSize: 8,
                  unselectedFontSize: 8,
                  elevation: 0,
                  onTap: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    if (index < 4) {
                      setState(() {
                        controller.loadRequest(Uri.parse(bottomPages[index].link));
                        webUrl = bottomPages[index].link;
                      });
                    }
                  },
                  selectedLabelStyle: TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                  unselectedLabelStyle: TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/qr-code.png',
                        width: 40,
                        height: 40,
                        color: _currentIndex == 0 && webUrl == bottomPages[0].link
                            ? Colors.white
                            : Color(CommonColors.SECONDRY_COLOR),
                      ),
                      label: "BIGLIETTO",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/yes.png',
                          width: 40,
                          height: 40,
                          color:
                          _currentIndex == 1 && webUrl == bottomPages[1].link
                              ? Colors.white
                              : Color(CommonColors.SECONDRY_COLOR)),
                      label: "AIDP AWARD",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/check-list.png',
                          width: 40,
                          height: 40,
                          color:
                          _currentIndex == 2 && webUrl == bottomPages[2].link
                              ? Colors.white
                              : Color(CommonColors.SECONDRY_COLOR)),
                      label: "LEARNING EXP",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/teamwork.png',
                          width: 40,
                          height: 40,
                          color:
                          _currentIndex == 3 && webUrl == bottomPages[3].link
                              ? Colors.white
                              : Color(CommonColors.SECONDRY_COLOR)),
                      label: "ACCOMPAGNATORI",
                    ),
                    BottomNavigationBarItem(
                      icon: PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0))),
                        color: Color(CommonColors.PRIMARY_COLOR),
                        icon: Image.asset('assets/masculine-user.png',
                            width: 40,
                            height: 40,
                            color: _currentIndex == 4
                                ? Colors.white
                                : Color(CommonColors.SECONDRY_COLOR)),
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                          PopupMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  _currentIndex = 4;
                                  controller.loadRequest(Uri.parse(bottomPages[4].link));
                                  webUrl = bottomPages[4].link;
                                });
                              },
                              child: Text(bottomPages[4].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: bottomPages[4].link == webUrl
                                          ? Colors.white
                                          : Color(CommonColors.SECONDRY_COLOR))),
                              value: ''),
                          PopupMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  _currentIndex = 4;
                                  controller.loadRequest(Uri.parse(bottomPages[5].link));
                                  webUrl = bottomPages[5].link;
                                });
                              },
                              child: Text(bottomPages[5].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: bottomPages[5].link == webUrl
                                          ? Colors.white
                                          : Color(CommonColors.SECONDRY_COLOR))),
                              value: ''),
                          PopupMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  _currentIndex = 4;
                                  controller.loadRequest(Uri.parse(bottomPages[6].link));
                                  webUrl = bottomPages[6].link;
                                });
                              },
                              child: Text(bottomPages[6].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: bottomPages[6].link == webUrl
                                          ? Colors.white
                                          : Color(CommonColors.SECONDRY_COLOR))),
                              value: ''),
                        ],
                      ),
                      label: "UTENTE",
                    ),
                  ],
                ),
              ],
            )
          ],

    ),
       );
  }
  
  void initWebViewController() {
controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))

  ..loadRequest(Uri.parse(webUrl));

  }
}


