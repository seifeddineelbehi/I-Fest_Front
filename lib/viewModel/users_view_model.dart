import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class UsersRepository {
  Login(
    String email,
    String password,
    String deviceId,
  );

  Notif(String notif);

  Register(
    String email,
    String password,
    String firstName,
    String lastName,
    String projectId,
    String role,
    int phoneNumber,
    String deviceId,
  );

  UpdateProfile(
    String email,
    String password,
    String firstName,
    String lastName,
    int phoneNumber,
  );
  checkUserByEmail(
    String email,
  );
  changePassword(
    String email,
    String password,
  );
}

class UsersViewModel with ChangeNotifier implements UsersRepository {
  UserModel? _user;
  String? _loggedIn;
  String? _name;
  String? _email;
  bool? _loading = false;
  String? _exist;
  String? _resultMessage;

  setLoggedIn(String loggedin) {
    _loggedIn = loggedin;
    notifyListeners();
  }

  String? get name {
    return _name;
  }

  String? get email {
    return _email;
  }

  String? get loggedin {
    return _loggedIn;
  }

  bool get Loading {
    return _loading!;
  }

  String get resultMessage {
    return _resultMessage!;
  }

  String get exist {
    return _exist!;
  }

  setExist(String value) {
    _exist = value;
    notifyListeners();
  }

  setResultMessage(String result) {
    _resultMessage = result;
    notifyListeners();
  }

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  @override
  Login(String email, String password, String deviceId) async {
    setLoading(true);
    var user = await UserServices.login(localURL, email, password, deviceId);
    log("////// " + user.toString());
    setLoggedIn(user.toString());
    setLoading(false);
  }

  @override
  Register(String email, String password, String firstName, String lastName,
      String projectId, String role, int phoneNumber, String deviceId) async {
    setLoading(true);
    var user = await UserServices.signUp(
        endpoint: localURL,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        projectId: projectId,
        role: role,
        phoneNumber: phoneNumber,
        deviceId: deviceId);
    log("////// " + user.toString());
    setLoggedIn(user.toString());
    setLoading(false);
  }

  @override
  UpdateProfile(
    String email,
    String password,
    String firstName,
    String lastName,
    int phoneNumber,
  ) async {
    setLoading(true);
    var user = await UserServices.updateProfile(
      endpoint: localURL,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
    log("////// " + user.toString());
    setLoggedIn(user.toString());
    setLoading(false);
  }

  @override
  Notif(String notif) async {
    setLoading(true);
    var user = await UserServices.notification(
      localURL,
      notif,
    );
    setLoading(false);
  }

  @override
  checkUserByEmail(String email) async {
    setLoading(true);

    var result = await UserServices.checkUserByEmail(
      email: email,
      endpoint: localURL,
    );
    setExist(result.toString());
    setLoading(false);
  }

  @override
  changePassword(String email, String password) async {
    setLoading(true);

    var result = await UserServices.changePasssword(
      email: email,
      password: password,
      endpoint: localURL,
    );
    setResultMessage(result!);
    setLoading(false);
  }
}
