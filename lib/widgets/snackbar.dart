import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';

SnackBar CustomizedSnackbar(BuildContext context, String? link, String? image,double height, double width) {
  return SnackBar(
    duration: const Duration(days: 1),
    margin: const EdgeInsets.all(0),
    padding: const EdgeInsets.all(0),
    behavior: SnackBarBehavior.floating,
    content:
    Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          GestureDetector(
            child: Container(
            child:
            Image.network(
              image!,
              fit: BoxFit.fill,
              height: height,
              width: width,
            )),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Color(CommonColors.SECONDRY_COLOR))),
            child:  GestureDetector(
              onTap: () =>  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(
                Icons.close,
                color: Color(CommonColors.SECONDRY_COLOR),
              ),
            ),
          )]
    ),

  );
}
