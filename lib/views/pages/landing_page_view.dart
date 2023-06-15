import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/pages/Ifest/ifest_view.dart';
import 'package:flutter_template/views/pages/nav_bottom_guest.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({Key? key}) : super(key: key);
  static const String id = 'Landing_page_view';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Palette.PageMainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.safeBlockVertical * 40,
              child: Image.asset(
                "assets/images/IFEST_logo.png",
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NavigationBottomGuest.id,
                  arguments: {'role': "guest"},
                );
              },
              child: Text("Guest & Media"),
              height: SizeConfig.blockSizeVertical * 12,
              fontSize: 20,
              colorPrimary: 0xffF6564D,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LoginView.id,
                  arguments: {'role': "participant"},
                );
              },
              child: Text("I-FEST² Participant"),
              height: SizeConfig.blockSizeVertical * 12,
              fontSize: 20,
              colorPrimary: 0xffF6564D,
            ),
          ],
        ),
      ),
    );
  }
}
