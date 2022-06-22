import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';

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
                  LoginView.id,
                  arguments: {'role': "guest"},
                );
              },
              text: "Guest & Media",
              height: SizeConfig.blockSizeVertical * 12,
              fontSize: 20,
              colorPrimary: 0xff0d0d0d,
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
              text: "I-FEST² Participant",
              height: SizeConfig.blockSizeVertical * 12,
              fontSize: 20,
              colorPrimary: 0xff0d0d0d,
            ),
          ],
        ),
      ),
    );
  }
}
