import 'dart:convert';
//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart';
import '../models/notification.dart';

class Service {
  static Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  static Future<Map?> getbannerData(Uri link) async {
    var response = await http.get(link,
      headers: requestHeaders,
    );
    if (response.statusCode == 200 && response.body != "null") {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // static Future subscribeTonotifications() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   if (token != null && prefs.getString('notification_token') == null) {
  //     var response = await http.post(
  //       MyApplicationUrl.token,
  //       body: json.encode({"token": token}),
  //       headers: requestHeaders,
  //     );
  //     prefs.setString('notification_token', token);
  //     return (response.body);
  //   } else {
  //     print("token null or already saved");
  //   }
  // }

  static getNotificationList() async {
    var response = await http.get(
      MyApplicationUrl.notifications,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<NotificationItem> notifications = List<NotificationItem>.from(
          list.map((model) => NotificationItem.fromJson(model)));
      return notifications;
    } else {
      throw Exception('Failed');
    }
  }
}
