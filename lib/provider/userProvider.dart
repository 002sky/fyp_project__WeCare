import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/modal/relativeUser.dart';

import '../config/databaseConfig.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<RelativeUser> _RelativeUserList = [];

  List<RelativeUser> get relativeList {
    return [..._RelativeUserList];
  }

  Future<Map<String, dynamic>?> setUserAccount(String data) async {
    final url = Uri.parse(databaseURL().toString() + 'api/auth/register');
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    try {
      final response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // final responseData = json.decode(response.body);
      responseMessage = jsonDecode(response.body);
    } catch (e) {
      print(e);
      return responseMessage;
    }
    return responseMessage;
  }

  getAllRelative() async {
    List<RelativeUser> resultList = [];
    RelativeUser result;

    final url = Uri.parse(databaseURL() + 'api/admin/getAllRelative');

    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        for (var detail in responseData) {
          for (var items in detail) {
            result = RelativeUser.fromJson(items);
            resultList.add(result);
          }
        }
        _RelativeUserList = resultList;
        notifyListeners();
      }
    } catch (e) {}
  }
}
