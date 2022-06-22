import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _route;
  late Future<bool> _session;
  Future<bool> _getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userId")) {
      print("enter userid");
      if (prefs.getString("role") == "admin") {
        print("enterAdmin");
        _route = AdminHomeView.id;
      } else {
        _route = NavigationBottom.id;
      }
    } else {
      _route = LandingPageView.id;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _session = _getSession();
  }

  @override
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
  }
}
