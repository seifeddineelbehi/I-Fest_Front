import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/schedule_services.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class ScheduleRepository {
  PostSchedule(String current, String next, String type, String time);
  GetSchedule();
}

class ScheduleViewModel with ChangeNotifier implements ScheduleRepository {
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
  PostSchedule(String current, String next, String type, String time) async {
    setLoading(true);
    ScheduleModel scheduleModel = ScheduleModel(
        type: type, current: current, next: next, time: time, id: "1");
    var schedule = await ScheduleServices.postSchedule(localURL, scheduleModel);
    log("////// " + schedule.toString());
    setScheduleIn(schedule.toString());
    setLoading(false);
  }

  @override
  Future<Map<String, dynamic>> GetSchedule() async {
    Map<String, dynamic> schedule =
        await ScheduleServices.getSchedule(localURL) as Map<String, dynamic>;
    notifyListeners();
    return schedule;
  }
}
