import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/model/models.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_template/utils/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<String?> login(
      String endpoint, String email, String password) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.http(endpoint, LOGIN);
    var body = {
      "email": email,
      "password": password,
    };
    try {
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> userFromServer = json.decode(response.body);
        log("api" + userFromServer["_id"].toString());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userFromServer["_id"]);

        prefs.setString("email", userFromServer["email"]);
        prefs.setString("firstName", userFromServer["firstName"]);
        prefs.setString("lastName", userFromServer["lastName"]);
        prefs.setString("role", userFromServer["role"]);
        prefs.setInt("phoneNumber", userFromServer["phoneNumber"]);
        if (userFromServer["role"] == "participant") {
          prefs.setString("projectId", userFromServer["projectId"]);
        }
        log("is goooooddddd" + userFromServer["_id"].toString());
        return "Success";
      } else if (response.statusCode == 401) {
        return "Password wrong";
      } else if (response.statusCode == 402) {
        return "Email doesn't exist";
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {}
  }

  static Future<String?> signUp({
    required String endpoint,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String projectId,
    required String role,
    required int phoneNumber,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.http(endpoint, SIGNUP);
    var body;
    if (role == "guest") {
      body = {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": password,
        "role": role,
        "phoneNumber": phoneNumber,
      };
    } else {
      body = {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": password,
        "projectId": projectId,
        "role": role,
        "phoneNumber": phoneNumber,
      };
    }

    try {
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> userFromServer = json.decode(response.body);
        log("api" + userFromServer["_id"].toString());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userFromServer["_id"]);

        prefs.setString("email", userFromServer["email"]);
        prefs.setString("firstName", userFromServer["firstName"]);
        prefs.setString("lastName", userFromServer["lastName"]);
        prefs.setString("role", userFromServer["role"]);
        prefs.setInt("phoneNumber", userFromServer["phoneNumber"]);
        if (userFromServer["role"] == "participant") {
          prefs.setString("projectId", userFromServer["projectId"]);
        }
        print("aaaaaaaaaaaaaaaaaaaa");
        return "Success";
      } else if (response.statusCode == 402) {
        return "Email already exists";
      } else if (response.statusCode == 401) {
        return "ProjectId Doesn't exist";
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {}
  }
}
