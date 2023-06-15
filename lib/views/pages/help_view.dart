import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/views.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);
  static const String id = 'help_view';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 6,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.PageMainColor,
        elevation: 0,
      ),
      backgroundColor: Palette.PageMainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  HelpEmailView.id,
                  arguments: {'type': "Lost & Found"},
                );
              },
              child: Text("Lost & Found"),
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
                  HelpEmailView.id,
                  arguments: {'type': "Medical Assistance"},
                );
              },
              child: Text("Medical Assistance"),
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
                  HelpEmailView.id,
                  arguments: {'type': "Call For Help"},
                );
              },
              child: Text("Call For Help"),
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
