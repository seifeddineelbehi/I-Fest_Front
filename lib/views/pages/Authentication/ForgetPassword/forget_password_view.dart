import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';
import '../../../../viewModel/users_view_model.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/gradiant_custom_button.dart';

import 'code_tapping_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);
  static const String id = 'Forget_Password_View';
  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  String _code = '00000';
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
                      "Forget Password",
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
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    GradiantCustomButton(
                      disabled: context.watch<UsersViewModel>().Loading,
                      onPressed: !context.watch<UsersViewModel>().Loading
                          ? () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                await context
                                    .read<UsersViewModel>()
                                    .checkUserByEmail(_email);
                                var response =
                                    context.read<UsersViewModel>().exist;
                                dev.log("res" + response.toString());
                                if (response == 'true') {
                                  Random random = Random();
                                  int randomNumber =
                                      random.nextInt(90000) + 10000;
                                  setState(() {
                                    _code = randomNumber.toString();
                                    dev.log('code $_code');
                                    Navigator.pushNamed(
                                        context, CodeTappingView.id,
                                        arguments: {
                                          'code': _code,
                                          'email': _email
                                        });
                                  });
                                } else if (response == "false") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('User does not exist'),
                                    ),
                                  );
                                } else {
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
                              "Send code",
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
