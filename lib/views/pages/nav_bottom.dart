import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/pages/home_view.dart';
import 'package:flutter_template/views/views.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);
  static const String id = 'navigation_bottom';
  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _currentIndex = 0;
  final List<Widget> _interfaces = [
    const HomeView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
        body: _interfaces[_currentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.white.withOpacity(0.4),
              selectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Palette.mainWidgetColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/svgs/house-solid.svg",
                      height: SizeConfig.kDefaultSize * 7,
                      width: SizeConfig.kDefaultSize * 7,
                      color: _currentIndex == 0
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                    label: 'Favourite'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/svgs/user-alt-solid.svg",
                      height: SizeConfig.kDefaultSize * 7,
                      width: SizeConfig.kDefaultSize * 7,
                      color: _currentIndex == 1
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                    label: 'Favourite')
              ],
              currentIndex: _currentIndex,
              onTap: (int value) {
                setState(() {
                  _currentIndex = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
