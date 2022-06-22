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
  var _currentHotel = "";
  var _nextHotel = "";
  var _nextHotelTime = "";
  var _currentVenue = "";
  var _nextVenu = "";
  var _nextVenuTime = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Palette.PageMainColor,
      appBar: AppBar(
        title: Text(
          "Add Schedule",
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
              Form(
                key: _formKeyHotel,
                child: AddCard(
                  info: Column(
                    children: [
                      Text(
                        "Hotel",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 6,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Current Activity",
                        textColor: Colors.white,
                        hintText: "Current Activity",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _currentHotel = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Current Activity shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Current Activity must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Next Activity",
                        textColor: Colors.white,
                        hintText: "Next Activity",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _nextHotel = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Next Activity shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Next Activity must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Next Activity Time",
                        textColor: Colors.white,
                        hintText: "Next Activity Time",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _nextHotelTime = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Next Activity Time shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Next Activity Time must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              GradiantCustomButton(
                disabled: context.watch<ScheduleViewModel>().Loading,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKeyHotel.currentState!.validate()) {
                    _formKeyHotel.currentState!.save();
                    await context.read<ScheduleViewModel>().PostSchedule(
                        _currentHotel, _nextHotel, "hotel", _nextHotelTime);
                    var response = context.read<ScheduleViewModel>().ScheduleIn;
                    if (response == "Success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Hotel Schedule is Successfully updated'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Something went wrong, check internet connection'),
                        ),
                      );
                    }
                  }
                },
                height: SizeConfig.safeBlockVertical * 8,
                width: SizeConfig.safeBlockHorizontal * 70,
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
                        "Register Hotel Schedule",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 5,
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              Form(
                key: _formKeyVenue,
                child: AddCard(
                  info: Column(
                    children: [
                      Text(
                        "Venue",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 6,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Current Activity",
                        textColor: Colors.white,
                        hintText: "Current Activity",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _currentVenue = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Current Activity shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Current Activity must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Next Activity",
                        textColor: Colors.white,
                        hintText: "Next Activity",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _nextVenu = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Next Activity shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Next Activity must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      CustomTextFormField(
                        text: "Next Activity Time",
                        textColor: Colors.white,
                        hintText: "Next Activity Time",
                        iconData: Icons.mail,
                        underLineColor: Palette.textSecondaryColor,
                        iconColor: Palette.textSecondaryColor,
                        withText: false,
                        onSaved: (String? value) {
                          setState(() {
                            _nextVenuTime = value.toString();
                          });
                        },
                        onValidate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Next Activity Time shouldn't be empty";
                          } else if (value.length < 3) {
                            return "Next Activity Time must contain at least 3 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              GradiantCustomButton(
                disabled: context.watch<ScheduleViewModel>().Loading,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKeyVenue.currentState!.validate()) {
                    _formKeyVenue.currentState!.save();
                    await context.read<ScheduleViewModel>().PostSchedule(
                        _currentVenue, _nextVenu, "venue", _nextVenuTime);
                    var response = context.read<ScheduleViewModel>().ScheduleIn;
                    if (response == "Success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Venue Schedule is Successfully updated'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Something went wrong, check internet connection'),
                        ),
                      );
                    }
                  }
                },
                height: SizeConfig.safeBlockVertical * 8,
                width: SizeConfig.safeBlockHorizontal * 70,
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
                        "Register Venue Schedule",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 5,
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container AddCard({required Column info}) {
    return Container(
      height: SizeConfig.safeBlockVertical * 50,
      width: SizeConfig.safeBlockHorizontal * 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Palette.mainWidgetColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.kDefaultSize * 5),
        child: Column(
          children: [
            info,
          ],
        ),
      ),
    );
  }
}
