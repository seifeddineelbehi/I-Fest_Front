import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentNextWidget extends StatelessWidget {
  final String type;
  final String current;
  final String next;
  final String time;

  const CurrentNextWidget({
    required this.type,
    required this.current,
    required this.next,
    this.time = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 38,
      width: SizeConfig.safeBlockHorizontal * 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Palette.mainWidgetColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            type,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.kDefaultSize * 6,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DotsColumn(),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 3,
                ),
                InfoColumn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column InfoColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current activity",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF).withOpacity(0.9),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 5,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 1,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 8,
          width: SizeConfig.safeBlockHorizontal * 70,
          child: Text(
            current,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.poppins(
              color: const Color(0xFFC4C4C4).withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.kDefaultSize * 4,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical * 1.2),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 70,
            height: 2,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 70,
          child: Text(
            "Next activity " + time,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF).withOpacity(0.9),
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.kDefaultSize * 5,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 8,
          width: SizeConfig.safeBlockHorizontal * 70,
          child: Text(
            next,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.poppins(
              color: const Color(0xFFC4C4C4).withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.kDefaultSize * 4,
            ),
          ),
        ),
      ],
    );
  }

  Column DotsColumn() {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 0.5,
        ),
        Container(
          height: SizeConfig.kDefaultSize * 4,
          width: SizeConfig.kDefaultSize * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: const Color(0xff4849c1),
          ),
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 14,
          width: 2,
          color: Colors.white.withOpacity(0.1),
        ),
        Container(
          height: SizeConfig.kDefaultSize * 4,
          width: SizeConfig.kDefaultSize * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: const Color(0xff70b200),
          ),
        ),
      ],
    );
  }
}
