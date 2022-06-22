import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/components/custom_text_icon_button.dart';
import 'package:flutter_template/views/pages/help_view.dart';
import 'package:flutter_template/views/pages/landing_page_view.dart';
import 'package:flutter_template/views/views.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
        appBar: AppBar(
          title: Text(
            "Profile",
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
        body: SizedBox(
          height: SizeConfig.safeBlockVertical * 85,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoColumn(context),
              Text(
                "Beta Version, made with love 💓",
                style: GoogleFonts.poppins(
                  color: const Color(0x60FFFFFF),
                  fontWeight: FontWeight.w300,
                  fontSize: SizeConfig.kDefaultSize * 4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column InfoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 8,
            ),
            Text(
              "Thanks for ",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.kDefaultSize * 8,
              ),
            ),
            Text(
              "using",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.kDefaultSize * 8,
              ),
            ),
            Text(
              "our App",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.kDefaultSize * 8,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 8,
        ),
        CustomTextIconButton(
          text: "Schedule",
          icon: Icons.schedule,
          onTap: () {},
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 80,
            height: 2,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        CustomTextIconButton(
          text: "Help",
          icon: Icons.help_outline,
          onTap: () {
            if (prefs.getString("role") == "guest") {
              Navigator.pushNamed(
                context,
                HelpEmailView.id,
                arguments: {'type': "Help"},
              );
            } else {
              Navigator.pushNamed(context, HelpView.id);
            }
          },
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 80,
            height: 2,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        CustomTextIconButton(
          text: "Log Out",
          icon: Icons.power_settings_new,
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: Palette.mainWidgetColor,
              title: Text(
                'Do you want to exit?',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.kDefaultSize * 5,
                ),
              ),
              content: Text(
                'We hate to see you leave...',
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
                    'No',
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
                    Navigator.pushReplacementNamed(context, LandingPageView.id);
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
          ),
        ),
      ],
    );
  }
}
