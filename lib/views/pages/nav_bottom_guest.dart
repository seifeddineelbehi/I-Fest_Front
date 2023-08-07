import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/views.dart';

class NavigationBottomGuest extends StatefulWidget {
  const NavigationBottomGuest({Key? key}) : super(key: key);
  static const String id = 'navigation_bottom_guest';

  @override
  State<NavigationBottomGuest> createState() => _NavigationBottomGuestState();
}

class _NavigationBottomGuestState extends State<NavigationBottomGuest> {
  int _currentIndex = 0;
  final List<Widget> _interfaces = [
    const HomeView(),
    const IfestView(),
    // const ProfileView(),
  ];

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Palette.PageMainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: Text(
              'You want to exit the Application?',
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.kDefaultSize * 4,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
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
                onPressed: () => Navigator.of(context).pop(true),
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
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
        body: _interfaces[_currentIndex],
        bottomNavigationBar: Container(
          height: SizeConfig.blockSizeVertical * 12,
          margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 0.5,
            right: SizeConfig.safeBlockHorizontal * 4,
            left: SizeConfig.safeBlockHorizontal * 4,
          ),
          padding: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 1,
            right: SizeConfig.blockSizeVertical * 1,
            left: SizeConfig.blockSizeVertical * 1,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(80),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(80),
            ),
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white.withOpacity(0.4),
                selectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Palette.SecondaryColor,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBar(isActive: _currentIndex == 0),
                        SvgPicture.asset(
                          "assets/svgs/house-solid.svg",
                          height: SizeConfig.kDefaultSize * 6,
                          width: SizeConfig.kDefaultSize * 6,
                          color: _currentIndex == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                        ),
                      ],
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBar(isActive: _currentIndex == 1),
                        SvgPicture.asset(
                          "assets/svgs/shield-solid.svg",
                          height: SizeConfig.kDefaultSize * 6,
                          width: SizeConfig.kDefaultSize * 6,
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                        ),
                      ],
                    ),
                    label: 'I-fest²',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       AnimatedBar(isActive: _currentIndex == 2),
                  //       SvgPicture.asset(
                  //         "assets/svgs/heart-solid.svg",
                  //         height: SizeConfig.kDefaultSize * 6,
                  //         width: SizeConfig.kDefaultSize * 6,
                  //         color: _currentIndex == 2
                  //             ? Colors.white
                  //             : Colors.white.withOpacity(0.4),
                  //       ),
                  //     ],
                  //   ),
                  //   label: 'Favourite',
                  // ),
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
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: SizeConfig.kDefaultSize * 2),
      height: 4,
      width: isActive ? SizeConfig.kDefaultSize * 6 : 0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      duration: const Duration(milliseconds: 200),
    );
  }
}
