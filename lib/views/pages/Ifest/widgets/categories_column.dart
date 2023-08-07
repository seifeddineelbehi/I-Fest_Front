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

CustomExpansionPanel categoriesPanel({required List<bool> expanded}) {
  return expansionPanelCustom(
    title: "I-FEST² Categories",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoriesColumn(
          image: "assets/images/categories/Physical Science.jpg",
          title: "Physical Science: ",
          description: physicalScience,
        ),
        categoriesColumn(
          image: "assets/images/categories/Environmental Science.jpg",
          title: "Environmental Science: ",
          description: environmentalScience,
        ),
        categoriesColumn(
          image: "assets/images/categories/Social Science.jpg",
          title: "Social Science: ",
          description: socialScience,
        ),
        categoriesColumn(
          image: "assets/images/categories/Computer Science.jpg",
          title: "Computer Science: ",
          description: computerScience,
        ),
        categoriesColumn(
          image: "assets/images/categories/Engineering.jpg",
          title: "Engineering: ",
          description: engineering,
        ),
        categoriesColumn(
          image: "assets/images/categories/Life & Biology.jpg",
          title: "Life & Biology: ",
          description: biology,
        ),
        categoriesColumn(
          image: "assets/images/categories/Multimedia.jpg",
          title: "Multimedia: ",
          description: multimedia,
        ),
        categoriesColumn(
          image: "assets/images/categories/Mathematics.jpg",
          title: "Mathematics: ",
          description: mathematics,
        ),
      ],
    ),
    isExpended: expanded[1],
  );
}

Padding categoriesColumn({
  required String title,
  required String description,
  required String image,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SelectableText(
              title,
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.kDefaultSize * 6,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SelectableText(
          description,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.kDefaultSize * 4,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    ),
  );
}
