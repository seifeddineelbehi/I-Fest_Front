import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/pages/meal_detail/widgets/top_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsDetails extends StatefulWidget {
  final EventsModel event;

  const EventsDetails({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  var quantety = 1;

  void getQuantety(int qt) {
    setState(() {
      quantety = qt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        topBarWidget(context, widget.event),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          decoration: const BoxDecoration(
            color: Color(0xFF0B1724),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About this event',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFBFFFF),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.kDefaultSize * 4.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.event.eventAbout.toString(),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF97A3B0),
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.kDefaultSize * 3.8,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Planning',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFBFFFF),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.kDefaultSize * 4.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.kDefaultSize * 4,
                      ),
                    ],
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.event.planing.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    width: SizeConfig.safeBlockHorizontal * 100,
                    height: SizeConfig.safeBlockVertical * 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF17304A),
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.event.planing[index].startTime,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFBFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.kDefaultSize * 3.8,
                              ),
                            ),
                            Text(
                              widget.event.planing[index].endTime == ""
                                  ? ""
                                  : " - ",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFBFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.kDefaultSize * 3.8,
                              ),
                            ),
                            Text(
                              widget.event.planing[index].endTime,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFBFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.kDefaultSize * 3.8,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.event.planing[index].description,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFBFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.kDefaultSize * 4.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconWithText(
      {required IconData icon, required Color color, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        Text(
          text,
          style: kBigSubTitleGrayMedium,
        )
      ],
    );
  }
}
