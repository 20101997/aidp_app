import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';
class SocialMediaBar extends StatelessWidget {
  const SocialMediaBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(CommonColors.SECONDRY_COLOR),
      height: 90,
      padding: EdgeInsets.fromLTRB(10, 16, 10, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '#AIDP2023',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(CommonColors.Orangee)),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Helper.goToLink("https://twitter.com/aidpnazionale"); // Do something when the icon is clicked
                      },
                      child: Image.asset(
                        'assets/twit.png',
                        width: 20,
                        height: 20,
                        color:Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Helper.goToLink("https://www.instagram.com/aidp_nazionale");
                      },
                      child: Image.asset(
                        'assets/instagram.png',
                        width: 30,
                        height: 30,
                        color:Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Helper.goToLink("https://www.youtube.com/channel/UCUhQ5uJiCnT0Ig2DKblFKOQ");
                      },
                      child: Image.asset(
                        'assets/youtube.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Helper.goToLink("https://www.linkedin.com/company/aidp");
                      },
                      child: Image.asset(
                        'assets/linkedin.png',
                        width: 20,
                        height: 20,
                        color:Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Helper.goToLink("https://blog.aidp.it");
                      },
                      child: Image.asset(
                        'assets/blog.png',
                        width: 20,
                        height: 20,
                        color:Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}