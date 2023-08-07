import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final String hintText;
  final IconData iconData;
  final Color? iconColor;
  final Color underLineColor;
  final Color textColor;
  final TextInputAction? textInputAction;
  final Function(String?)? onSaved;
  final String? Function(String?)? onValidate;
  final bool obscureText;
  final TextInputType? textInputType;
  final bool withText;

  const CustomTextFormField({
    Key? key,
    this.text = "",
    required this.hintText,
    required this.iconData,
    required this.iconColor,
    required this.onSaved,
    required this.underLineColor,
    required this.textColor,
    required this.onValidate,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.withText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withText
            ? Text(
                text,
                style: kSmallTitleBlackBold.copyWith(
                  fontSize: SizeConfig.safeBlockVertical * 2.4,
                  color: Palette.textSecondaryColor,
                ),
              )
            : Container(),
        TextFormField(
          textInputAction: textInputAction,
          style: TextStyle(color: textColor),
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconData,
              color: iconColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 2,
              color: Palette.textSecondaryColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: underLineColor),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          keyboardType: textInputType,
          onSaved: onSaved,
          validator: onValidate,
        ),
      ],
    );
  }
}
