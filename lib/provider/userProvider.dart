import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../config/databaseConfig.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
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
}
