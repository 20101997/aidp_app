import 'package:flutter/material.dart';
import '../utils/helpers.dart';

MaterialBanner CustomizedBanner (BuildContext context, String? link, String? image) {
  return MaterialBanner(
   // backgroundColor:Color(CommonColors.CARD_COLOR),
    leadingPadding: const EdgeInsets.all(0),
    padding: const EdgeInsets.all(0),
    forceActionsBelow: true,
    content: GestureDetector(
       onTap: ()=> Helper.goToLink(link!) ,
        child: Image.network(image!, fit: BoxFit.fill,height: 150,)),

      actions: [

        Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            }, icon: Icon(Icons.close,),);
          }
        ),


  ],
  );
}