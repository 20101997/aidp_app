import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';

MaterialBanner CustomizedBanner(BuildContext context, String? link, String? image,double height, double width) {
  return MaterialBanner(
    leadingPadding: const EdgeInsets.all(0),
    padding: const EdgeInsets.all(0),
    content: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: () => Helper.goToLink(link!),
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
            onTap: () =>  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Icon(
              Icons.close,
              color: Color(CommonColors.SECONDRY_COLOR),
            ),
          ),
        )
      ],
    ),  //actions: [],
  );
}
