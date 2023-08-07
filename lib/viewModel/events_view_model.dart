import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/events_services.dart';
import 'package:flutter_template/services/schedule_services.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class EventsRepository {
  GetEvents();
}

class EventsViewModel with ChangeNotifier implements EventsRepository {
  Object? _schedule;
  String? _scheduleIn;
  bool? _loading = false;
  List<EventsModel>? _events;
  List<EventsModel>? filteredEvents;

  setScheduleIn(String loggedin) {
    _scheduleIn = loggedin;
    notifyListeners();
  }

  String? get ScheduleIn {
    return _scheduleIn;
  }

  Object? get schedule {
    return _events;
  }

  List<EventsModel>? get event {
    return _events;
  }

  setEvents(List<EventsModel> events) {
    _events = events;
    filteredEvents = event;
    notifyListeners();
  }

  bool get Loading {
    return _loading!;
  }

  setSchedule(Object schedule) {
    _schedule = schedule;
    notifyListeners();
  }

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  @override
  Future<Map<String, dynamic>> GetEvents() async {
    Map<String, dynamic> events =
        await EventsServices.getEvents(localURL) as Map<String, dynamic>;
    notifyListeners();
    if (events["list"] != null) {
      print("test test");
      List<EventsModel> eventing = [];
      events["list"].forEach((value) {
        eventing.add(EventsModel.fromJson(value));
      });
      setEvents(eventing);
    }
    return events;
  }
}
