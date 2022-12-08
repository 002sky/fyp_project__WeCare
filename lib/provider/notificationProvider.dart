import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/dailySchedule.dart';
import 'package:fyp_project_testing/modal/notificationDaily.dart';
import 'package:http/http.dart' as http;

class notificationProvider extends ChangeNotifier {
  List<notificationDaily>? _notification = [];
  List<notificationDaily>? _notificationByName = [];
  List<DailySchedule>? _scheduleDetails = [];

  List<DailySchedule> get scheduleDetail {
    return [...?_scheduleDetails];
  }

  List<notificationDaily> get notification {
    return [...?_notification];
  }

  List<notificationDaily> get notificationbyName {
    return [...?_notificationByName];
  }

  getNotificationList() async {
    notificationDaily? result;
    List<notificationDaily> resultList = [];
    final url = Uri.parse(databaseURL() + "api/admin/scheduleWithin6Hour");

    try {
      final responseList = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (responseList.statusCode == 200) {
        final notificationList = json.decode(responseList.body);
        for (var item in notificationList) {
          for (var sc in item) {
            result = notificationDaily.fromJson(sc);
            resultList.add(result);
          }
        }
      }
      _notification = resultList;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getScheduleDetail(String data) async {
    DailySchedule? result;
    List<DailySchedule>? resultList = [];
    final url = Uri.parse(databaseURL() + "api/admin/taskDetail");

    try {
      final responseList = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (responseList.statusCode == 200) {
        final notificationList = json.decode(responseList.body);
        for (var item in notificationList) {
          for (var sc in item) {
            result = DailySchedule.fromJson(sc);
            resultList.add(result);
          }
        }
      }
      _scheduleDetails = resultList;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> updateDailySchedule(String data) async {
    Map<String, dynamic> message = {
      'success': false,
      'message': 'Something went wrong'
    };

    final url = Uri.parse(databaseURL() + "api/admin/updateScheduleStatus");
    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      if (response.statusCode == 200) {
        message = jsonDecode(response.body);
      } else {
        print(response.body);

        return message;
      }
    } catch (e) {
      return message;
    }

    return message;
  }
}
