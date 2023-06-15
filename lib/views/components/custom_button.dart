import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final double fontSize;
  final int colorPrimary;
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height = 48,
    this.fontSize = 16,
    this.colorPrimary = 0xFF333333,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: Color(colorPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        elevation: 5.0,
        textStyle: GoogleFonts.poppins(
          color: const Color(0xFFFFFFFF),
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ).copyWith(
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width,
            height,
          ),
        ),
      ),
    );
  }
}
