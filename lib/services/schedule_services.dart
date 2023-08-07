import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/model/schedule_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_template/utils/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleServices {
  static Future<String?> postSchedule(
      String endpoint, ScheduleModel schedule) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.http(endpoint, POSTSCHEDULE);
    var body = {
      "current": schedule.current,
      "next": schedule.next,
      "type": schedule.type,
      "time": schedule.time,
    };
    try {
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));

      if (response.statusCode == 200) {
        return "Success";
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {}
  }

  static Future<Map<String, dynamic>?> getSchedule(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      // 'Authorization': prefs.getString("token").toString(),
    };
    Uri uri = Uri.http(endpoint, GETALLGENERALPLANNING);
    try {
      var response = await http
          .get(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> scheduleFromServer = json.decode(response.body);
        return scheduleFromServer;
      } else {
        return null;
      }
      // }
    } catch (exception) {}
  }
}
