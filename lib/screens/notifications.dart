
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/service.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(CommonColors.SECONDRY_COLOR),
      appBar: AppBar(elevation: 0,centerTitle:true,backgroundColor: Color(CommonColors.PRIMARY_COLOR),title: Text("Notifiche",
          style: TextStyle(fontSize: 25, color: Color(CommonColors.SECONDRY_COLOR))),),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: Service.getNotificationList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(CommonColors.PRIMARY_COLOR),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data[index].title,
                                style: TextStyle(
                                    color: Color(CommonColors.SECONDRY_COLOR),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data[index].description,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                );
              } else {
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
              }
            },
          )),
    );
  }
}
