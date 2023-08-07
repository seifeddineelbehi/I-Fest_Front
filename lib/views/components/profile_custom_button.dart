import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfileCustomButton extends StatelessWidget {
  const ProfileCustomButton({
    Key? key,
    required this.onTap,
    required this.Icon,
    required this.text,
    this.padding = 1.2,
  }) : super(key: key);

  final VoidCallback onTap;
  final String Icon;
  final String text;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 4,
          vertical: SizeConfig.safeBlockVertical * 0.4),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 3),
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 9.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(80),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: SizeConfig.kDefaultSize * 11,
                            width: SizeConfig.kDefaultSize * 11,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(80),
                              ),
                              color: Color(0xFFF6564D),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    SizeConfig.safeBlockVertical * padding,
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * padding,
                              ),
                              child: SvgPicture.asset(
                                Icon,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 4,
                        ),
                        Text(
                          text,
                          style: GoogleFonts.poppins(
                            color: Palette.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 4.5,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.kDefaultSize * 5,
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/arrow_right.svg",
                        color: const Color(0xFF0B1724),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 1,
            ),
          ],
        ),
      ),
    );
  }
}
