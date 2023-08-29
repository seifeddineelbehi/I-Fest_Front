import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_template/views/pages/Authentication/ForgetPassword/reset_password_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

class CodeTappingView extends StatefulWidget {
  const CodeTappingView({Key? key}) : super(key: key);
  static const String id = 'Code_Tapping_View';
  @override
  _CodeTappingViewState createState() => _CodeTappingViewState();
}

class _CodeTappingViewState extends State<CodeTappingView> {
  var _code = '0';
  var _email = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      setState(() {
        _code = arguments['code'];
        _email = arguments['email'];
      });
    });
  }

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
                    "Enter code",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.kDefaultSize * 6,
                    ),
                  ),
                  Text(
                    "A verification code has been sent to your email ****@****",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w300,
                      fontSize: SizeConfig.kDefaultSize * 3,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  OtpTextField(
                    numberOfFields: 5,
                    borderColor: kSecondaryColor,
                    fillColor: Colors.grey,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      log("code : $_code");
                      log("verificationCode : $verificationCode");
                      if (_code.compareTo(verificationCode).isEven) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ResetPasswordView.id,
                          (Route<dynamic> route) => false,
                          arguments: {'email': _email},
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text("Verification Code"),
                                content: Text(' Wrong Verification code'),
                              );
                            });
                      }
                    }, // end onSubmit
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 8,
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
