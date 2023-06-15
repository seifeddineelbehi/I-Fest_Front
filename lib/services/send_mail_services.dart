import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/model/schedule_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_template/utils/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMailServices {
  static Future<String?> SendEmail(
      String endpoint, String emailType, String emailBody) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.http(endpoint, SENDMAIL);
    var body;
    if (prefs.getString("role") == "guest") {
      body = {
        "userName":
            prefs.getString("lastName")! + " " + prefs.getString("firstName")!,
        "userEmail": prefs.getString("email"),
        "userNumber": prefs.getInt("phoneNumber"),
        "emailBody": emailBody,
        "emailType": emailType,
      };
    } else {
      body = {
        "userName":
            prefs.getString("lastName")! + " " + prefs.getString("firstName")!,
        "userEmail": prefs.getString("email"),
        "userNumber": prefs.getInt("phoneNumber"),
        "userProjectId": prefs.getString("projectId"),
        "emailBody": emailBody,
        "emailType": emailType,
      };
    }

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
}
