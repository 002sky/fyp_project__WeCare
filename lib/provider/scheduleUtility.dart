import 'dart:convert';

import 'dart:io';

import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/schedule.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> addScheduleData(String data) async {
  Map<String, dynamic>? responseMessage = {
    'success': false,
    'message': 'Something went wrong'
  };
  final url = Uri.parse(databaseURL() + 'api/admin/addSchedule');
  try {
    final response = await http.post(url, body: data, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      final scheduleMessage = json.decode(response.body);

      final successMessgage = scheduleMessage['success'];

      if (successMessgage.toString() == 'true') {
        responseMessage = {'success': true, 'message': 'Susseffully Added'};

        return responseMessage;
      } else {
        return responseMessage;
      }
    }
  } catch (e) {
    print(e);
  }

  return responseMessage;
}

Future<List<Schedule>> fetchScheduleData(String id) async {
  List<Schedule>? resultList = [];
  Schedule? result;

  final url = Uri.parse(databaseURL() + 'api/admin/getSchduleData');
  try {
    final response = await http.post(url,
        body: json.encode({
          'userID': id,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
    final data = json.decode(response.body);
    for (var detail in data) {
      for (var item in detail) {
        result = Schedule.fromJson(item);
        resultList.add(result);
      }
    }
  } catch (e) {
    print(e);
  }

  return resultList;
}
