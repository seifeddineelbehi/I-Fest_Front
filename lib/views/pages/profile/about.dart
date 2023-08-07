import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/data/data.dart';
import 'package:flutter_template/model/general_planing_model.dart';
import 'package:flutter_template/model/planing_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/categories_column.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/custom_expansion_panel.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/expansion_panel_custom.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/planing_panel.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/robotics_panel.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/steam_congress_panel.dart';
import 'package:flutter_template/views/pages/home/widgets/current_next_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);
  static const String id = 'ifest_View';

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  late Future<Map<String, dynamic>> fetchedSchedule;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<bool> expanded = [
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments['role']);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "About Us",
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.kDefaultSize * 7,
            ),
          ),
          toolbarHeight: SizeConfig.safeBlockVertical * 10,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Palette.PageMainColor,
        ),
        backgroundColor: Palette.PageMainColor,
        body: SizedBox(
          height: arguments['role'] == "guest"
              ? SizeConfig.safeBlockVertical * 90
              : SizeConfig.safeBlockVertical * 88,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column topBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Image.asset(
          "assets/images/about/logo atast.png",
          height: SizeConfig.kDefaultSize * 40,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white, // here for close state
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
            ), // here for open state in replacement of deprecated accentColor
            dividerColor:
                Colors.transparent, // if you want to remove the border
          ),
          child: CustomExpansionPanelList(
            elevation: 0,
            dividerColor: const Color(0xFF49627C),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                for (int i = 0; i < expanded.length; i++) {
                  expanded[i] = false;
                }
                expanded[index] = !isExpanded;
              });
            },
            children: [
              expansionPanelCustom(
                title: "What Is ATAST?",
                content: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/logo_atast.png",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      atastAboutOne,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/atast_team_4.jpg",
                      height: SizeConfig.kDefaultSize * 60,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      atastAboutTwo,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/stc_2019_2.jpg",
                      height: SizeConfig.kDefaultSize * 60,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      atastAboutThree,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                  ],
                ),
                isExpended: expanded[0],
              ),
              expansionPanelCustom(
                title: "Co-Organizers",
                content: Column(
                  children: [
                    Image.asset(
                      "assets/images/about/milset.png",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      "MILSET Africa: ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 6,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      MILSET,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/brisecc.png",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      "BRISECC: ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 6,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      BRISECC,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                  ],
                ),
                isExpended: expanded[1],
              ),
              expansionPanelCustom(
                title: "About your host country",
                content: Column(
                  children: [
                    Image.asset(
                      "assets/images/about/tun_flag.jpg",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      TunisiaOne,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/tun-1.jpeg",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      TunisiaTwo,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Image.asset(
                      "assets/images/about/tun-6.jpeg",
                      height: SizeConfig.kDefaultSize * 40,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      TunisiaThree,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                  ],
                ),
                isExpended: expanded[2],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
