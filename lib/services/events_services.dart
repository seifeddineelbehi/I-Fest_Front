import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/model/models.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_template/utils/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsServices {
  static Future<Map<String, dynamic>?> getEvents(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      // 'Authorization': prefs.getString("token").toString(),
    };

    Uri uri = Uri.http(endpoint, GETALLEVENTS);
    try {
      var response = await http
          .get(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> eventsFromServer = json.decode(response.body);
        return eventsFromServer;
      } else {
        return null;
      }
      // }
    } catch (exception) {}
  }

  static Future<Map<String, dynamic>?> likeEvent(
      String endpoint, String idEvent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': prefs.getString("token").toString(),
    };

    Uri uri = Uri.http(endpoint, LIKEEVENT + idEvent);
    try {
      var response = await http
          .put(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> eventsFromServer = json.decode(response.body);
        return eventsFromServer;
      } else {
        return null;
      }
      // }
    } catch (exception) {}
  }

  static Future<Map<String, dynamic>?> unlikLikeEvent(
      String endpoint, String idEvent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': prefs.getString("token").toString(),
    };

    Uri uri = Uri.http(endpoint, UNLIKEEVENT + idEvent);
    try {
      var response = await http
          .put(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> eventsFromServer = json.decode(response.body);
        return eventsFromServer;
      } else {
        return null;
      }
      // }
    } catch (exception) {}
  }
}
