import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/components/custom_text_form_field.dart';
import 'package:flutter_template/views/components/gradiant_custom_button.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/views.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const String id = 'sign_up_Participated_View';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _email = "";
  var _firstName = "";
  var _lastName = "";
  var _projectId = "";
  var _phoneNumber = 0;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
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
                      "SIGN UP",
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
                      textInputAction: TextInputAction.next,
                      textColor: Colors.white,
                      hintText: "First Name",
                      iconData: Icons.person,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _firstName = value.toString();
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "First Name shouldn't be empty";
                        } else if (value.length < 3) {
                          return "First Name must contain at least 3 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      textColor: Colors.white,
                      hintText: "Last Name",
                      iconData: Icons.person,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _lastName = value.toString();
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Last Name shouldn't be empty";
                        } else if (value.length < 3) {
                          return "Last Name must contain at least 3 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      textColor: Colors.white,
                      hintText: "Email",
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
                    arguments['role'] == "participant"
                        ? Column(
                            children: [
                              CustomTextFormField(
                                textInputAction: TextInputAction.next,
                                textColor: Colors.white,
                                hintText: "Project Id",
                                iconData: Icons.rocket,
                                underLineColor: Palette.textSecondaryColor,
                                iconColor: Palette.textSecondaryColor,
                                withText: false,
                                onSaved: (String? value) {
                                  setState(() {
                                    _projectId = value.toString();
                                  });
                                },
                                onValidate: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Project Id shouldn't be empty";
                                  } else if (value.length < 5) {
                                    return "Project Id must contain at least 5 characters";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: SizeConfig.safeBlockVertical * 4,
                              ),
                            ],
                          )
                        : Container(),
                    CustomTextFormField(
                      textColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      hintText: "Phone Number",
                      textInputType: TextInputType.number,
                      iconData: Icons.phone,
                      underLineColor: Palette.textSecondaryColor,
                      iconColor: Palette.textSecondaryColor,
                      withText: false,
                      onSaved: (String? value) {
                        setState(() {
                          _phoneNumber = int.parse(value.toString());
                        });
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Phone Number shouldn't be empty";
                        } else if (value.length != 8) {
                          return "Phone Number must contain 8 Numbers";
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
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _formKey.currentState!.save();
                                await context.read<UsersViewModel>().Register(
                                      _email,
                                      _password,
                                      _firstName,
                                      _lastName,
                                      _projectId,
                                      arguments['role'],
                                      _phoneNumber,
                                      deviceId,
                                    );
                                var response =
                                    context.read<UsersViewModel>().loggedin;
                                log("res" + response.toString());
                                if (response == "Success") {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                  Navigator.of(context).pushReplacementNamed(
                                      NavigationBottom.id);
                                  log("respong " + "aaaaaaaaaaaaaaa");
                                } else if (response == "Email already exists") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Email already exists'),
                                    ),
                                  );
                                } else if (response ==
                                    "ProjectId Doesn't exist") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('ProjectId Doesn\'t exist'),
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
                              "Sign Up",
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
                          "You Already have an account? ",
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
                              LoginView.id,
                              arguments: {'role': arguments['role']},
                            );
                          },
                          child: Text(
                            "Login",
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
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
