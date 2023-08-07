import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/components/custom_text_form_field.dart';
import 'package:flutter_template/views/components/gradiant_custom_button.dart';
import 'package:flutter_template/views/pages/Authentication/sign_up_view.dart';
import 'package:flutter_template/views/views.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String id = 'Login_Participated_View';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _email = "";
  bool load = false;
  String deviceId = "";

  Future<void> initPlatform() async {
    await OneSignal.shared.getDeviceState().then((value) => {
          print("id: " + value!.userId!),
          deviceId = value.userId!,
        });
  }

  @override
  void initState() {
    initPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments['role']);
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
                      "LOGIN",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.kDefaultSize * 6,
                      ),
                    ),
                    Text(
                      "TO CONTINUE",
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
                      hintText: "Email",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      iconData: Icons.mail,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _email = value.toString();
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Email shouldn't be empty";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Email format is invalid";
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
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    GradiantCustomButton(
                      disabled: context.watch<UsersViewModel>().Loading,
                      onPressed: !context.watch<UsersViewModel>().Loading
                          ? () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await context
                                    .read<UsersViewModel>()
                                    .Login(_email, _password, deviceId);
                                var response =
                                    context.read<UsersViewModel>().loggedin;
                                log("res" + response.toString());
                                if (response == "Success") {
                                  if (prefs.getString("role") == "admin") {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context)
                                        .pushReplacementNamed(AdminHomeView.id);
                                  } else {
                                    context.read<UsersViewModel>().setName(
                                        prefs.getString("firstName")! +
                                            " " +
                                            prefs.getString("lastName")!);
                                    context
                                        .read<UsersViewModel>()
                                        .setEmail(prefs.getString("email")!);
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context).pushReplacementNamed(
                                        NavigationBottom.id);
                                  }

                                  log("respong " + "aaaaaaaaaaaaaaa");
                                } else if (response == "Password wrong") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password is Wrong'),
                                    ),
                                  );
                                } else if (response == "Email doesn't exist") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Email doesn\'t exist'),
                                    ),
                                  );
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
                              "Login",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don't have an account? ",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.kDefaultSize * 4,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              SignUp.id,
                              arguments: {'role': arguments['role']},
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.kDefaultSize * 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 6,
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
