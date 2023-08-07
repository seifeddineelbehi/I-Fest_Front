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

class IfestView extends StatefulWidget {
  const IfestView({Key? key}) : super(key: key);
  static const String id = 'ifest_View';

  @override
  State<IfestView> createState() => _IfestViewState();
}

class _IfestViewState extends State<IfestView> {
  late Future<Map<String, dynamic>> fetchedSchedule;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    fetchedSchedule = context.read<ScheduleViewModel>().GetSchedule();
    super.initState();
  }

  Future<void> onRefrech() async {
    setState(() {
      fetchedSchedule = context.read<ScheduleViewModel>().GetSchedule();
    });
  }

  List<bool> expanded = [
    false,
    false,
    false,
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
        backgroundColor: Palette.PageMainColor,
        body: RefreshIndicator(
          onRefresh: onRefrech,
          key: _refreshIndicatorKey,
          child: SizedBox(
            height: arguments['role'] == "guest"
                ? SizeConfig.safeBlockVertical * 100
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
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> planingFutureBuilder(
      BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context.read<ScheduleViewModel>().GetSchedule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: SizeConfig.safeBlockVertical * 62,
            width: SizeConfig.safeBlockHorizontal * 90,
            child: const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return SizedBox(
            height: SizeConfig.safeBlockVertical * 62,
            width: SizeConfig.safeBlockHorizontal * 90,
            child: Center(
              child: Text(
                "Check your internet connection and then refresh!!",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w300,
                  fontSize: SizeConfig.kDefaultSize * 4,
                ),
              ),
            ),
          );
        } else {
          var schedule = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              CurrentNextWidget(
                type: "Hotel",
                current: schedule!["hotel"]["current"],
                next: schedule["hotel"]["next"],
                time: "At " + schedule["hotel"]["time"],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              CurrentNextWidget(
                type: "Venue",
                current: schedule["venue"]["current"],
                next: schedule["venue"]["next"],
                time: "At " + schedule["venue"]["time"],
              ),
            ],
          ); // ListView.builder
        }
      },
    );
  }

  Column topBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Text(
          "Welcome to our Event I-FEST² !!",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 10,
          ),
        ),
        Text(
          "In this section you’ll find every thing related to our event. ",
          style: GoogleFonts.poppins(
            color: const Color(0xFFCCD2D4),
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.kDefaultSize * 4.6,
          ),
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
                title: "About I-FEST²",
                content: Text(
                  ifestAbout,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.kDefaultSize * 5,
                  ),
                ),
                isExpended: expanded[0],
              ),
              categoriesPanel(expanded: expanded),
              steamCongressPanel(expanded: expanded),
              roboticsPanel(expanded: expanded),
              planingPanel(expanded: expanded, context: context),
              expansionPanelCustom(
                title: "Room Planning",
                content: Image.asset(
                  "assets/images/room_Planing.png",
                ),
                isExpended: expanded[5],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
