import 'dart:io';

import 'package:aidp_app/constants/colors.dart';
import 'package:aidp_app/screens/home.dart';
import 'package:aidp_app/utils/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';

import 'models/notificationTotal.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("notification received");
  if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
  if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var a = prefs.getInt("total_receive_notifications");
  print(a);
  prefs.setInt("total_receive_notifications",
      prefs.getInt('total_receive_notifications')! + 1);
  flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['title'],
    message.data['message'],
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        // channel.description,
        // TODO add a proper drawable resource to android, for now using
        //      one that already exists in example app.
        icon: 'launch_background',
      ),
    ),
  );
} 

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('ad_displayed');
  prefs.remove('news_displayed');
  runApp(ChangeNotifierProvider<NotificationsTotal>(
    create: (BuildContext context) {
      return NotificationsTotal(
          total: prefs.getInt("total_receive_notifications") ?? 0);
    },
    child: MyApp(prefs: prefs),
  ));
}

// notification: https://www.youtube.com/watch?v=MBFjk6KfrEE&ab_channel=EasyCodingwithAmmara
class MyApp extends StatefulWidget {
  SharedPreferences prefs;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Service.subscribeTonotifications();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        var total = widget.prefs.getInt("total_receive_notifications");
        if (total == null)
          widget.prefs.setInt("total_receive_notifications", 0);
        print(total);
        widget.prefs.setInt("total_receive_notifications",
            widget.prefs.getInt('total_receive_notifications')! + 1);
        Provider.of<NotificationsTotal>(context, listen: false)
            .setTotal(widget.prefs.getInt('total_receive_notifications')!);
        print(widget.prefs.getInt("total_receive_notifications"));
        flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          message.data['title'],
          message.data['message'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: Color(CommonColors.PRIMARY_COLOR),
        )),
        title: 'CONGRESSO NAZIONALE AIDP',
        debugShowCheckedModeBanner: false,
        home: HomePage(
          prefs: widget.prefs,
        ),
      ),
    );
  }
}
