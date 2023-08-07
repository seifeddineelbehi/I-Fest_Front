import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/components/custom_text_form_field.dart';
import 'package:flutter_template/views/components/gradiant_custom_button.dart';
import 'package:flutter_template/views/pages/landing_page_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);
  static const String id = 'admin_home_View';

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
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

  final _formKeyHotel = GlobalKey<FormState>();
  final _formKeyVenue = GlobalKey<FormState>();
  var _notif = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Palette.PageMainColor,
      appBar: AppBar(
        title: Text(
          "Send Notification",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 6,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.mainWidgetColor,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Palette.PageMainColor,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Palette.mainWidgetColor,
              automaticallyImplyLeading: false,
              title: Text(
                "Ifest² Admin Dashboard",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 4.5,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.power_settings_new,
                    color: Color(0xFFFFFFFF),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Log Out",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.kDefaultSize * 4,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                showDialog<String>(
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
                          Navigator.pushReplacementNamed(
                              context, LandingPageView.id);
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
            )
          ],
        ),
      ),
      body: SizedBox(
        width: SizeConfig.safeBlockHorizontal * 100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        textColor: Colors.white,
                        hintText: "Notification",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _notif = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Email shouldn't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
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
                                      .Notif(_notif);
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
                                "Send",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
