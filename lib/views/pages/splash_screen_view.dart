import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _route;
  late Future<bool> _session;
  String deviceId = "";

  Future<bool> _getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userId")) {
      print("enter userid");
      if (prefs.getString("role") == "admin") {
        print("enterAdmin");

        _route = AdminHomeView.id;
      } else {
        context.read<UsersViewModel>().setName(
            prefs.getString("firstName")! + " " + prefs.getString("lastName")!);
        context.read<UsersViewModel>().setEmail(prefs.getString("email")!);
        _route = NavigationBottom.id;
      }
    } else {
      _route = LandingPageView.id;
    }
    return true;
  }

  @override
  void initState() {
    initPlatform();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("userId")) {
        //await context.read<ScheduleViewModel>().GetSchedule();
        //var response = context.read<ScheduleViewModel>().schedule;
        if (prefs.getString("role") == "admin") {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(AdminHomeView.id);
        } else {
          Navigator.pushReplacementNamed(
            context,
            NavigationBottom.id,
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          LandingPageView.id,
        );
      }
    });
    super.initState();
    _session = _getSession();
  }

  /*@override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _session,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (_route == NavigationBottom.id) {
            return const NavigationBottom();
          } else if (_route == AdminHomeView.id) {
            return const AdminHomeView();
          } else {
            return const LandingPageView();
          }
        } else {
          return const Scaffold(
            backgroundColor: Palette.PageMainColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Palette.PageMainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.kDefaultSize * 10),
            child: Image.asset("assets/images/IFEST_logo.png"),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 20,
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Future<void> initPlatform() async {
    await OneSignal.shared.setAppId("12ae28aa-0343-4a83-8f6a-d043a522cde0");
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });
    await OneSignal.shared.getDeviceState().then((value) => {
          print("id: " + value!.userId!),
          deviceId = value.userId!,
        });
  }
}
