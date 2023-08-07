import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/data/data.dart';
import 'package:flutter_template/model/general_planing_model.dart';
import 'package:flutter_template/model/planing_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/custom_expansion_panel.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/expansion_panel_custom.dart';
import 'package:flutter_template/views/pages/home/widgets/current_next_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

CustomExpansionPanel planingPanel(
    {required List<bool> expanded, required BuildContext context}) {
  return expansionPanelCustom(
    title: "Schedule",
    content: FutureBuilder<Map<String, dynamic>>(
      future: context.read<ScheduleViewModel>().GetSchedule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text(
              "Check your internet connection and then refresh!!",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w300,
                fontSize: SizeConfig.kDefaultSize * 4,
              ),
            ),
          );
        } else {
          GeneralPlaningModel schedule =
              GeneralPlaningModel.fromJson(snapshot.data!);
          print(schedule);
          return ListView.separated(
            separatorBuilder: (context, index) => Column(
              children: [
                SizedBox(
                  height: SizeConfig.kDefaultSize * 8,
                ),
              ],
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: schedule.listGeneralPlanning.length,
            itemBuilder: (context, index) => Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF17304A),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat.MMM().format(
                                  schedule.listGeneralPlanning[index].date),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.kDefaultSize * 5,
                              ),
                            ),
                            Text(
                              DateFormat.d().format(
                                  schedule.listGeneralPlanning[index].date),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFF6564D),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.kDefaultSize * 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Container(
                          height: SizeConfig.kDefaultSize * 12,
                          width: 2,
                          color: Color(0xFF536C86),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Text(
                          DateFormat.EEEE()
                              .format(schedule.listGeneralPlanning[index].date),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 8,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          schedule.listGeneralPlanning[index].planing.length,
                      itemBuilder: (BuildContext context, int i) {
                        PlaningModel plan =
                            schedule.listGeneralPlanning[index].planing[i];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF49627C),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/time.png",
                                  height: SizeConfig.kDefaultSize * 12,
                                ),
                                Text(
                                  plan.description,
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeConfig.kDefaultSize * 4,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          plan.startTime,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.kDefaultSize * 3.5,
                                          ),
                                        ),
                                        Text(
                                          plan.endTime == " " ? "" : " - ",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.kDefaultSize * 3.5,
                                          ),
                                        ),
                                        Text(
                                          plan.endTime,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.kDefaultSize * 3.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: SizeConfig.kDefaultSize * 55,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ); // ListView.builder
        }
      },
    ),
    isExpended: expanded[4],
  );
}
