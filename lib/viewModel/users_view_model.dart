import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/models.dart';
import 'package:flutter_template/services/user_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'dart:developer';

abstract class UsersRepository {
  Login(String email, String password);
  Register(String email, String password, String firstName, String lastName,
      String projectId, String role, int phoneNumber);
}

class UsersViewModel with ChangeNotifier implements UsersRepository {
  UserModel? _user;
  String? _loggedIn;
  bool? _loading = false;
  setLoggedIn(String loggedin) {
    _loggedIn = loggedin;
    notifyListeners();
  }

  String? get loggedin {
    return _loggedIn;
  }

  bool get Loading {
    return _loading!;
  }

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  @override
  Login(String email, String password) async {
    setLoading(true);
    var user = await UserServices.login(localURL, email, password);
    log("////// " + user.toString());
    setLoggedIn(user.toString());
    setLoading(false);
  }

  @override
  Register(
    String email,
    String password,
    String firstName,
    String lastName,
    String projectId,
    String role,
    int phoneNumber,
  ) async {
    setLoading(true);
    var user = await UserServices.signUp(
        endpoint: localURL,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        projectId: projectId,
        role: role,
        phoneNumber: phoneNumber);
    log("////// " + user.toString());
    setLoggedIn(user.toString());
    setLoading(false);
  }
}
