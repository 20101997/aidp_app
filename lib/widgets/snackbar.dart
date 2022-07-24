import 'package:flutter/material.dart';
import '../utils/helpers.dart';

SnackBar CustomizedSnackbar(BuildContext context, String? link, String? image) {
  return SnackBar(
    duration: const Duration(days: 1),
    margin: const EdgeInsets.all(0),
    padding: const EdgeInsets.all(0),
    behavior: SnackBarBehavior.floating,
    //backgroundColor:Color(CommonColors.CARD_COLOR),
    content: GestureDetector(
        onTap: () => Helper.goToLink(link!),
        child: Container(
            child: Image.network(
          image!,
          fit: BoxFit.fill,
          height: 80,
        ))),

    action: SnackBarAction(
      label: 'Chiudi',
      textColor: Colors.red,
      onPressed: () {},
    ),
  );
}
