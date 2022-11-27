import 'dart:convert';

import 'dart:io';

import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/schedule.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<bool> addScheduleData(String data) async {
  bool message = false;
  final url = Uri.parse(databaseURL() + 'api/admin/addSchedule');
  try {
    final response = await http.post(url, body: data, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      final scheduleMessage = json.decode(response.body);

      final successMessgage = scheduleMessage['success'];
      print(successMessgage);
      if (successMessgage.toString() == 'true') {
        message = true;
      } else {
        message = false;
      }
    }
  } catch (e) {
    print(e);
  }

  print(message);
  return message;
}

Future<List<Schedule>> fetchScheduleData(String id) async {
  List<Schedule>? resultList = [];
  Schedule? result;

  final url = Uri.parse(databaseURL() + 'api/admin/getSchduleData');
  try {
    final response = await http.post(url, body: json.encode({
      'userID': id,
    }), headers: {
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
