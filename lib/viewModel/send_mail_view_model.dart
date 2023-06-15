import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/schedule_services.dart';
import 'package:flutter_template/services/send_mail_services.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class ScheduleRepository {
  SendMail(String emailBody, String emailType);
}

class SendMailViewModel with ChangeNotifier implements ScheduleRepository {
  ScheduleModel? _schedule;
  String? _scheduleIn;
  bool? _loading = false;
  setScheduleIn(String loggedin) {
    _scheduleIn = loggedin;
    notifyListeners();
  }

  String? get ScheduleIn {
    return _scheduleIn;
  }

  bool get Loading {
    return _loading!;
  }

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  @override
  SendMail(String emailBody, String emailType) async {
    setLoading(true);
    var mail = await SendMailServices.SendEmail(localURL, emailType, emailBody);
    log("////// " + mail.toString());
    setScheduleIn(mail.toString());
    setLoading(false);
  }
}
