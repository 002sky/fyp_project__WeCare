import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_project_testing/config/databaseConfig.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var _token = "";
  String _userId = "";

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return null;
  }
  String? get userID {
    return _userId;
  }

  Future<void> _authentication(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(databaseURL().toString() + 'api/auth/$urlSegment');

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
          }),
          headers: _setHeader());

      final responseData = json.decode(response.body);
      Map<String, dynamic> token = responseData['token'];
      Map<String, dynamic> id = responseData['user'];
      var idTesting = id.values.toList();
      var testing = token.values.toList();
      _token = testing[0].toString();
      _userId = idTesting[0].toString();
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', _token);
      localStorage.setString('user', _userId);

      notifyListeners();
      // _token = responseDate['token'];

    } catch (eror) {
      print(eror);
    }
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password,'login');
  }

  Future<void> logout() async {
    final url = Uri.parse(databaseURL().toString() + 'api/auth/logout');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? id = localStorage.getString('user');
    String? token = localStorage.getString('token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      final data = json.decode(response.body);
      print(data);
      notifyListeners();
      // _token = responseDate['token'];

    } catch (eror) {
      print(eror);
    }
  }

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_getToken'
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
