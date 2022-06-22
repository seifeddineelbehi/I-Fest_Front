import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = 'home_View';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<Map<String, dynamic>> fetchedSchedule;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
        appBar: AppBar(
          title: Text(
            "Home",
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.kDefaultSize * 6,
            ),
          ),
          centerTitle: true,
          backgroundColor: Palette.PageMainColor,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: onRefrech,
          key: _refreshIndicatorKey,
          child: SizedBox(
            height: SizeConfig.safeBlockVertical * 90,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: FutureBuilder<Map<String, dynamic>>(
                future: context.read<ScheduleViewModel>().GetSchedule(),
                //postsViewModel.fetchAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: SizeConfig.safeBlockVertical * 90,
                      width: SizeConfig.safeBlockHorizontal * 90,
                      child: const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    var schedule = snapshot.data;
                    print(schedule);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 2,
                        ),
                        CurrentNextContainer(
                          type: "Hotel",
                          current: schedule!["hotel"]["current"],
                          next: schedule["hotel"]["next"],
                          time: "At " + schedule["hotel"]["time"],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 2,
                        ),
                        CurrentNextContainer(
                          type: "Venue",
                          current: schedule["venue"]["current"],
                          next: schedule["venue"]["next"],
                          time: "At " + schedule["venue"]["time"],
                        ),
                      ],
                    ); // ListView.builder
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentNextContainer extends StatelessWidget {
  final String type;
  final String current;
  final String next;
  final String time;

  const CurrentNextContainer({
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
        Text(
          "Next activity " + time,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF).withOpacity(0.9),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 5,
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
