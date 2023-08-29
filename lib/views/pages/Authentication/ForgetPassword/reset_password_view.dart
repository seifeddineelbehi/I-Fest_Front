import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Authentication/ForgetPassword/succes_reset_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';
import '../../../../viewModel/users_view_model.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/gradiant_custom_button.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);
  static const String id = 'Reset_Password_View';
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _confirmPassword = "";
  var _errorMessage = "";
  var _email = "";
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      _email = arguments['email'];
    });
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
            child: Form(
              key: _formKey,
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
                      "Reset password",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.kDefaultSize * 6,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    CustomTextFormField(
                      textColor: Colors.white,
                      obscureText: true,
                      hintText: "Password",
                      iconData: Icons.lock,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _password = value.toString();
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password shouldn't be empty";
                        } else if (value.length < 5) {
                          return "Password must contain at least 5 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    CustomTextFormField(
                      textColor: Colors.white,
                      obscureText: true,
                      hintText: "Confirm Password",
                      iconData: Icons.lock,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _confirmPassword = value.toString();
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password shouldn't be empty";
                        } else if (value.length < 5) {
                          return "Password must contain at least 5 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 3,
                    ),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.kDefaultSize * 4,
                        ),
                      ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    GradiantCustomButton(
                      disabled: context.watch<UsersViewModel>().Loading,
                      onPressed: !context.watch<UsersViewModel>().Loading
                          ? () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                if (_confirmPassword == _password) {
                                  setState(() {
                                    _errorMessage = "";
                                  });
                                  await context
                                      .read<UsersViewModel>()
                                      .changePassword(_email, _password);
                                  if (!mounted) return;
                                  var response = context
                                      .read<UsersViewModel>()
                                      .resultMessage;
                                  if (response == "Success") {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        SuccessResetPasswordView.id,
                                        (Route<dynamic> route) => false);
                                  } else {
                                    log("failed");
                                    context
                                        .read<UsersViewModel>()
                                        .setLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Something went wrong, check internet connection'),
                                      ),
                                    );
                                  }
                                } else {
                                  log("failed");
                                  context
                                      .read<UsersViewModel>()
                                      .setLoading(false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please check both fields!'),
                                    ),
                                  );
                                }
                              }
                            }
                          : () {},
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
                      child: !context.watch<UsersViewModel>().Loading
                          ? Text(
                              "Update password",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.kDefaultSize * 5,
                              ),
                            )
                          : CircularProgressIndicator(),
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
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
