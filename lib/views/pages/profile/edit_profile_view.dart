import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/palette.dart';
import '../../../utils/size_config.dart';
import '../../../viewModel/users_view_model.dart';
import '../../components/custom_text_form_field.dart';
import '../../components/gradiant_custom_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const String id = 'edit_profile_view';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _email = "";
  var _firstName = "";
  var _lastName = "";
  var _phoneNumber = 0;
  bool load = false;
  late SharedPreferences prefs;

  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("userId")) {
        setState(() {
          _email = value.getString("email")!;
        });
      }
    });
    super.initState();
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
                      "Update Profile",
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
                      initialValue: prefs.getString("firstName")!,
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
                      initialValue: prefs.getString("lastName")!,
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
                      initialValue: prefs.getString("email")!,
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
                    CustomTextFormField(
                      initialValue: prefs.getInt("phoneNumber")!.toString(),
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
                        if (value!.isNotEmpty) {
                          if (value.length < 5) {
                            return "Password must contain at least 5 characters";
                          } else {
                            return null;
                          }
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
                                await context
                                    .read<UsersViewModel>()
                                    .UpdateProfile(
                                      _email,
                                      _password,
                                      _firstName,
                                      _lastName,
                                      _phoneNumber,
                                    );
                                var response =
                                    context.read<UsersViewModel>().loggedin;
                                log("res" + response.toString());
                                if (response == "Success") {
                                  context.read<UsersViewModel>().setName(
                                      prefs.getString("firstName")! +
                                          " " +
                                          prefs.getString("lastName")!);
                                  context
                                      .read<UsersViewModel>()
                                      .setEmail(prefs.getString("email")!);
                                  Navigator.pop(context);
                                  log("respong " + "aaaaaaaaaaaaaaa");
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
                              "Update",
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
