import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/model/models.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_template/utils/apis.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<String?> login(
      String endpoint, String email, String password, String deviceId) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };

    Uri uri = Uri.http(endpoint, LOGIN);
    var body = {
      "email": email,
      "password": password,
      "deviceId": deviceId,
    };
    try {
      var response = await http
          .post(uri, headers: requestHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> userFromServer = json.decode(response.body);
        print("aaaaaaaaaaaaaaaaa");
        Map<String, String> requestHeaders = {
          HttpHeaders.contentTypeHeader: " application/json",
          'Authorization': userFromServer["token"].toString(),
        };

        Uri SecondUri = Uri.http(endpoint, USERDATAPROTECTED);

        var secondResponse = await http.get(SecondUri, headers: requestHeaders);

        if (secondResponse.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", userFromServer["token"]);
          Map<String, dynamic> userFromServerSecond =
              json.decode(secondResponse.body);
          prefs.setString("userId", userFromServerSecond["client"]["_id"]);
          prefs.setString("email", userFromServerSecond["client"]["email"]);
          print("aaaaaaaaaaaaaaaaaaaaaaaaa");
          prefs.setString(
              "firstName", userFromServerSecond["client"]["firstName"]);
          prefs.setString(
              "lastName", userFromServerSecond["client"]["lastName"]);
          prefs.setString("role", userFromServerSecond["client"]["role"]);

          prefs.setInt(
              "phoneNumber", userFromServerSecond["client"]["phoneNumber"]);
          if (userFromServerSecond["client"]["role"] == "participant") {
            prefs.setString(
                "projectId", userFromServerSecond["client"]["projectId"]);
          }
          log("is goooooddddd" +
              userFromServerSecond["client"]["_id"].toString());
          return "Success";
        }
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

  static Future<String?> notification(String endpoint, String notif) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };

    Uri uri = Uri.http(endpoint, SENDNOTIF);
    var body = {
      "content": notif,
    };
    try {
      var response = await http
          .post(uri, headers: requestHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
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
    required String deviceId,
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
        "lastName": lastName,
        "role": role,
        "phoneNumber": phoneNumber,
        "deviceId": deviceId,
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
        "deviceId": deviceId,
      };
    }

    try {
      var response = await http
          .post(uri, headers: requestHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      print("aaaaaaaaaaaaaaaaaaaaa");
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

  static Future<String?> updateProfile({
    required String endpoint,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int phoneNumber,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': prefs.getString("token").toString(),
    };
    Uri uri = Uri.http(endpoint, UPDATEPROFILE);
    var body;

    body = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    };

    try {
      var response = await http
          .post(uri, headers: requestHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      print("aaaaaaaaaaaaaaaaaaaaa");
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

  static Future<Object?> checkUserByEmail({
    required String endpoint,
    required String email,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      "email": email
    };
    Uri uri = Uri.http(endpoint, USEREXIST);
    var body = {"email": email};
    try {
      var response = await http.get(uri, headers: requestHeaders);
      if (response.statusCode == HttpStatus.ok) {
        return "true";
      } else if (response.statusCode == HttpStatus.notFound) {
        return "false";
      } else {
        return "Failure";
      }
    } catch (exception) {
      return "Failure";
    }
  }

  static Future<String?> changePasssword({
    required String email,
    required String password,
    required String endpoint,
  }) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.http(endpoint, UPDATEPASSWORD);
    var body = {
      "email": email,
      "password": password,
    };
    try {
      var response =
          await http.put(uri, headers: requestHeaders, body: jsonEncode(body));

      if (response.statusCode == HttpStatus.ok) {
        return "Success";
      } else {
        return "Failure";
      }
    } catch (exception) {
      return "Failure";
    }
  }
}
