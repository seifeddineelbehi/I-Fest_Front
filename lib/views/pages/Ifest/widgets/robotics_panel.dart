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

CustomExpansionPanel roboticsPanel({required List<bool> expanded}) {
  return expansionPanelCustom(
    title: "Open Robotics olympiad",
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset("assets/images/robot.jpg"),
          ),
          SelectableText(
            openRobotics,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.kDefaultSize * 4,
            ),
          ),
        ],
      ),
    ),
    isExpended: expanded[3],
  );
}
