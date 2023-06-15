import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/send_mail_view_model.dart';
import 'package:flutter_template/views/components/custom_button.dart';
import 'package:flutter_template/views/components/custom_text_form_field.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:provider/provider.dart';

class HelpEmailView extends StatefulWidget {
  const HelpEmailView({Key? key}) : super(key: key);
  static const String id = 'help_email_view';

  @override
  State<HelpEmailView> createState() => _HelpEmailViewState();
}

class _HelpEmailViewState extends State<HelpEmailView> {
  final _formKey = GlobalKey<FormState>();
  var _mailBody = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${arguments['type']}",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 6,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.PageMainColor,
        elevation: 0,
      ),
      backgroundColor: Palette.PageMainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
                Text(
                  "You will receive an email with the response",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.kDefaultSize * 6,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
                CustomTextFormField(
                  text: "Message Body",
                  textColor: Colors.white,
                  hintText: "Message Body",
                  iconData: Icons.mail,
                  underLineColor: Palette.textSecondaryColor,
                  iconColor: Palette.textSecondaryColor,
                  withText: false,
                  onSaved: (String? value) {
                    setState(() {
                      _mailBody = value.toString();
                    });
                  },
                  onValidate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "First Name shouldn't be empty";
                    } else if (value.length < 3) {
                      return "First Name must contain at least 3 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
                CustomButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await context
                          .read<SendMailViewModel>()
                          .SendMail(_mailBody, arguments['type']);
                      var response =
                          context.read<SendMailViewModel>().ScheduleIn;
                      if (response == "Success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your email is sent successfully '),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Something went wrong, check internet connection'),
                          ),
                        );
                      }
                    }
                  },
                  child: !context.watch<SendMailViewModel>().Loading
                      ? Text(
                          "Send Email",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.kDefaultSize * 5,
                          ),
                        )
                      : CircularProgressIndicator(),
                  height: SizeConfig.blockSizeVertical * 12,
                  fontSize: 20,
                  colorPrimary: 0xff0d0d0d,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
