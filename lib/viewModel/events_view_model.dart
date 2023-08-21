import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/events_services.dart';
import 'package:flutter_template/services/schedule_services.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class EventsRepository {
  GetEvents();
  LikeEvent(String idEvent);
  UnLikeEvent(String idEvent);
}

class EventsViewModel with ChangeNotifier implements EventsRepository {
  Object? _schedule;
  String? _scheduleIn;
  bool? _loading = false;
  List<EventsModel>? _events;
  List<EventsModel>? filteredEvents;
  bool? _likingEvent = false;
  bool? _unLikingEvent = false;

  bool? get likingEvent {
    return _likingEvent;
  }

  bool? get UnlikingEvent {
    return _unLikingEvent;
  }

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

  addUnLike(int index, String id) {
    if (!filteredEvents![index].unlikes.contains(id)) {
      if (filteredEvents![index].likes.contains(id)) {
        filteredEvents![index].likes.remove(id);
      }
      filteredEvents![index].unlikes.add(id);
    } else {
      filteredEvents![index].unlikes.remove(id);
    }
    notifyListeners();
  }

  addLike(int index, String id) {
    if (!filteredEvents![index].likes.contains(id)) {
      if (filteredEvents![index].unlikes.contains(id)) {
        filteredEvents![index].unlikes.remove(id);
      }
      filteredEvents![index].likes.add(id);
    } else {
      filteredEvents![index].likes.remove(id);
    }
    notifyListeners();
  }

  setlikedEvent(EventsModel event, String id) {
    if (event.likes.contains(id)) {
      _likingEvent = true;
      _unLikingEvent = false;
    }
    if (event.unlikes.contains(id)) {
      _unLikingEvent = true;
      _likingEvent = false;
    }
  }

  setLikingEvent(bool value) {
    _likingEvent = value;
    notifyListeners();
  }

  setUnLikingEvent(bool value) {
    _unLikingEvent = value;
    notifyListeners();
  }

  updateEvent(String idEvent, EventsModel event) {
    int index = -1;

    for (int i = 0; i < filteredEvents!.length; i++) {
      if (filteredEvents![i].id == idEvent) {
        index = i;
      }
    }
    log("index from viewmodel $index");
    filteredEvents![index].likes.clear();
    filteredEvents![index].unlikes.clear();
    filteredEvents![index].likes.addAll(event.likes);
    filteredEvents![index].unlikes.addAll(event.unlikes);
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

  @override
  LikeEvent(String idEvent) async {
    setLikingEvent(true);
    Map<String, dynamic> events =
        await EventsServices.likeEvent(localURL, idEvent)
            as Map<String, dynamic>;
    notifyListeners();
    if (events["event"] != null) {
      EventsModel updatedevent = EventsModel.fromJson(events["event"]);
      print("eveeent ${updatedevent.likes}");
      updateEvent(idEvent, updatedevent);
    }
    setLikingEvent(false);
    return events;
  }

  @override
  UnLikeEvent(String idEvent) async {
    setUnLikingEvent(true);
    Map<String, dynamic> events =
        await EventsServices.unlikLikeEvent(localURL, idEvent)
            as Map<String, dynamic>;
    notifyListeners();
    if (events["event"] != null) {
      print("eveeent");
      EventsModel event = EventsModel.fromJson(events["event"]);
      updateEvent(idEvent, event);
    }
    setUnLikingEvent(false);
    return events;
  }
}
