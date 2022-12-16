import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config/databaseConfig.dart';

class MedicationTimingProvder extends ChangeNotifier {
  Future<Map<String, dynamic>?> setMedicationTiming(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    final url = Uri.parse(databaseURL() + 'api/admin/setMedicationTiming');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      print(response.body);

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
      } else {
        print(response.body);

        return responseMessage;
      }
    } catch (e) {
      print(e);
    }

    return responseMessage;
  }

    Future<Map<String, dynamic>?> EditMedicationTiming(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    final url = Uri.parse(databaseURL() + 'api/admin/updateDailySchedule');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      print(response.body);

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
      } else {
        print(response.body);

        return responseMessage;
      }
    } catch (e) {
      print(e);
    }

    return responseMessage;
  }
}
