import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Ifest/widgets/custom_expansion_panel.dart';
import 'package:google_fonts/google_fonts.dart';

CustomExpansionPanel expansionPanelCustom({
  required String title,
  required Widget content,
  required bool isExpended,
}) {
  return CustomExpansionPanel(
    iconColor: Colors.white,
    backgroundColor: Palette.PageMainColor,
    headerBuilder: (BuildContext context, bool isExpanded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.kDefaultSize * 6,
            ),
          ),
        ),
      );
    },
    body: content,
    isExpanded: isExpended,
  );
}
