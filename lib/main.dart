import 'package:aidp_app/constants/colors.dart';
import 'package:aidp_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
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
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('ad_displayed');
  prefs.remove('news_displayed');
  runApp(const MyApp());
}

// notification: https://www.youtube.com/watch?v=MBFjk6KfrEE&ab_channel=EasyCodingwithAmmara
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Color(CommonColors.PRIMARY_COLOR),
      )),
      title: 'Aidp App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
