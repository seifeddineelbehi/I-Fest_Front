import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/events_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

BackdropFilter topBarWidget(
    BuildContext context, EventsModel event, String idUser) {
  int index = context.read<EventsViewModel>().filteredEvents!.indexOf(event);
  log("indec topvarwidget $index");
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child: Container(
      height: SizeConfig.safeBlockVertical * 37,
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0B1724).withOpacity(0.2),
            const Color(0xFF0B1724),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 64,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFBFFFF),
                        fontWeight: FontWeight.w800,
                        fontSize: SizeConfig.kDefaultSize * 5.5,
                      ),
                    ),
                    Text(
                      "Location : " + event.eventLocation,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF97A3B0),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.kDefaultSize * 4.5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                  ],
                ),
              ),
              priceWidget(context, event),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  log("index $index");
                  idUser.isNotEmpty
                      ? context.read<EventsViewModel>().LikeEvent(event.id)
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You must be logged in to perform this action!'),
                          ),
                        );
                },
                child: Row(
                  children: [
                    !context.watch<EventsViewModel>().UnlikingEvent!
                        ? SvgPicture.asset(
                            "assets/svgs/like.svg",
                            color: context
                                    .watch<EventsViewModel>()
                                    .filteredEvents![index]
                                    .likes
                                    .contains(idUser)
                                ? kPrimaryColor
                                : kSecondaryColor,
                            width: SizeConfig.kDefaultSize * 6,
                          )
                        : Container(),
                    SizedBox(
                      width: SizeConfig.safeBlockVertical * 2,
                    ),
                    Text(
                      context
                              .watch<EventsViewModel>()
                              .filteredEvents![index]
                              .likes
                              .length
                              .toString() +
                          " people likes",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF97A3B0),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.kDefaultSize * 3,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      log("index $index");
                      idUser.isNotEmpty
                          ? context
                              .read<EventsViewModel>()
                              .UnLikeEvent(event.id)
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'You must be logged in to perform this action!'),
                              ),
                            );
                      /* context
                                    .read<EventsViewModel>()
                                    .addUnLike(index, idUser);*/
                    },
                    child: !context.watch<EventsViewModel>().UnlikingEvent!
                        ? SvgPicture.asset(
                            "assets/svgs/dislike.svg",
                            color: context
                                    .watch<EventsViewModel>()
                                    .filteredEvents![index]
                                    .unlikes
                                    .contains(idUser)
                                ? kPrimaryColor
                                : kSecondaryColor,
                            width: SizeConfig.kDefaultSize * 6,
                          )
                        : Container(),
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockVertical * 2,
                  ),
                  Text(
                    context
                            .watch<EventsViewModel>()
                            .filteredEvents![index]
                            .unlikes
                            .length
                            .toString() +
                        " people dislikes",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF97A3B0),
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.kDefaultSize * 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.d().format(event.eventDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFBFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.kDefaultSize * 4.5,
                    ),
                  ),
                  Text(
                    DateFormat.MMMM().format(event.eventDate),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF97A3B0),
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.kDefaultSize * 4,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.EEEE().format(event.eventDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFBFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.kDefaultSize * 4.5,
                    ),
                  ),
                  Text(
                    event.eventStartTime + " - " + event.eventEndTime,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF97A3B0),
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.kDefaultSize * 4,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/svgs/calendar.svg",
                width: SizeConfig.kDefaultSize * 10,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Container priceWidget(BuildContext context, EventsModel event) {
  return Container(
    width: SizeConfig.blockSizeHorizontal * 18,
    height: SizeConfig.blockSizeVertical * 5,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(40),
      ),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          event.eventPrice == 0 ? "dt" : event.eventPrice.toString() + " dt",
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1724),
            fontWeight: FontWeight.w800,
            fontSize: SizeConfig.kDefaultSize * 3.8,
          ),
        )
      ],
    ),
  );
}
