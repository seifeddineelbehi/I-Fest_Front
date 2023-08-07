import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/meal_detail/widgets/custom_app_bar.dart';
import 'package:flutter_template/views/pages/meal_detail/widgets/meal_details.dart';

import 'package:provider/provider.dart';

class EventsDetailView extends StatelessWidget {
  final EventsModel event;

  const EventsDetailView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1724),
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.safeBlockVertical * 100,
            child: Stack(
              children: [
                CustomAppBar(
                  leftCallBack: () => Navigator.of(context).pop(),
                  rightCallBack: () async {},
                  imageUrl: event.image,
                ),
                Positioned(
                  top: SizeConfig.safeBlockVertical * 25,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 75,
                    child: EventsDetails(
                      event: event,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
