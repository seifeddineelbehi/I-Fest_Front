import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';

class CustomTextIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CustomTextIconButton({
    required this.icon,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        height: SizeConfig.safeBlockVertical * 8,
        width: SizeConfig.safeBlockHorizontal * 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 2,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 4,
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.kDefaultSize * 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
