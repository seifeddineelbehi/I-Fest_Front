import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/events_model.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final EventsModel event;
  final bool small;
  final VoidCallback onTap;

  const EventCard({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.event,
    this.small = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          imageWidget(context),
          shadeWidget(context),
          restaurantNameWidget(context),
          dateWidget(context),
        ],
      ),
    );
  }

  ClipRRect imageWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(40),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.blockSizeVertical * 35,
      ),
    );
  }

  Container shadeWidget(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      height: SizeConfig.blockSizeVertical * 35,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x00000000),
            Color(0x80000000),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }

  Positioned restaurantNameWidget(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Color(0xFF919498).withOpacity(0.8),
          ),
          width: SizeConfig.blockSizeHorizontal * 90,
          height: SizeConfig.blockSizeVertical * 13,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 56,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 5,
                        ),
                      ),
                      Text(
                        event.eventLocation + " - " + event.eventStartTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.kDefaultSize * 4.2,
                        ),
                      ),
                    ],
                  ),
                ),
                priceWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned dateWidget(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            width: SizeConfig.kDefaultSize * 18,
            height: SizeConfig.kDefaultSize * 18,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.d().format(event.eventDate),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.kDefaultSize * 6,
                  ),
                ),
                Text(
                  DateFormat.MMM().format(event.eventDate),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.kDefaultSize * 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container priceWidget(BuildContext context) {
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
}
