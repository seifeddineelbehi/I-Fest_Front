import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/components/custom_text_icon_button.dart';
import 'package:flutter_template/views/components/profile_custom_button.dart';
import 'package:flutter_template/views/pages/help_view.dart';
import 'package:flutter_template/views/pages/landing_page_view.dart';
import 'package:flutter_template/views/pages/profile/about.dart';
import 'package:flutter_template/views/views.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);
  static const String id = 'home_View';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late SharedPreferences prefs;

  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      print("aaaaaaaaaa");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.kDefaultSize * 7,
          ),
        ),
        elevation: 0,
        backgroundColor: Palette.PageMainColor,
        centerTitle: true,
      ),
      backgroundColor: Palette.PageMainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.kDefaultSize * 4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/marketing.png",
                width: SizeConfig.kDefaultSize * 35,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              Text(
                context.read<UsersViewModel>().name!,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 6,
                ),
              ),
              Text(
                context.read<UsersViewModel>().email!,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.kDefaultSize * 4,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              ProfileCustomButton(
                text: "About Us",
                Icon: "assets/svgs/about.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsView()),
                  );
                },
              ),
              ProfileCustomButton(
                text: "Help",
                Icon: "assets/svgs/help.svg",
                onTap: () {},
              ),
              ProfileCustomButton(
                text: "Log Out",
                padding: 1.8,
                Icon: "assets/svgs/log_out.svg",
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Palette.PageMainColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      content: Text(
                        'Do you want to Log out ?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.kDefaultSize * 4,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.kDefaultSize * 4,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LandingPageView.id,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Yes',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.kDefaultSize * 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
