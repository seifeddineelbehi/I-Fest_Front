import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';
import '../../../components/gradiant_custom_button.dart';

class SuccessResetPasswordView extends StatefulWidget {
  const SuccessResetPasswordView({Key? key}) : super(key: key);
  static const String id = 'Success_Reset_Password_View';
  @override
  _SuccessResetPasswordViewState createState() =>
      _SuccessResetPasswordViewState();
}

class _SuccessResetPasswordViewState extends State<SuccessResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Palette.PageMainColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 5),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical * 25,
                    child: Image.asset(
                      "assets/images/IFEST_logo.png",
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Text(
                    "Success",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.kDefaultSize * 6,
                    ),
                  ),
                  Text(
                    "Changing Password",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.kDefaultSize * 6,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 8,
                  ),
                  GradiantCustomButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacementNamed(LoginView.id);
                    },
                    height: SizeConfig.safeBlockVertical * 8,
                    width: SizeConfig.safeBlockHorizontal * 80,
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff4047bd),
                        Color(0xff993776),
                        Color(0xfff2282f),
                      ],
                    ),
                    child: Text(
                      "Go to Login",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 30,
                    child: const Divider(
                      color: Palette.textSecondaryColor,
                      thickness: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
