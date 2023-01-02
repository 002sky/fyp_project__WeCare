import 'package:flutter/material.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/appointment.dart';
import 'package:http/retry.dart';
import '../config/databaseConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointment = [];

  List<Appointment> get appointmentList {
    return [..._appointment];
  }

  getAppointment(int? id) async {
    List<Appointment> resultList = [];
    Appointment result;

    final url = Uri.parse(databaseURL() + 'api/relative/getAppointmentByID');

    String data = jsonEncode({
      'id': id,
    });

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final appointmentlist = json.decode(response.body);
        for (var item in appointmentlist) {
          for (var sc in item) {
            result = Appointment.fromJson(sc);
            resultList.add(result);
          }
        }
      }

      _appointment = resultList;
      notifyListeners();
    } catch (e) {}
  }

  getAllAppointment() async {
    List<Appointment> resultList = [];
    Appointment result;

    final url = Uri.parse(databaseURL() + 'api/admin/getAllApointmentRequest');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final appointmentlist = json.decode(response.body);
        for (var item in appointmentlist) {
          for (var sc in item) {
            result = Appointment.fromJson(sc);
            resultList.add(result);
          }
        }
      }

      _appointment = resultList;
      notifyListeners();
    } catch (e) {}
  }

  Future<Map<String, dynamic>?> setAppointment(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    final url = Uri.parse(databaseURL() + 'api/relative/makeAppointment');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
        return responseMessage;
      }
    } catch (e) {
      return responseMessage;
    }
    return responseMessage;
  }


  Future<Map<String, dynamic>?> approvalAppointment(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    final url = Uri.parse(databaseURL() + 'api/admin/approvalAppointment');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
        return responseMessage;
      }
    } catch (e) {
      return responseMessage;
    }
    return responseMessage;
  }


  Future<Map<String, dynamic>?> disapprovalAppointment(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };
    final url = Uri.parse(databaseURL() + 'api/admin/disapprovalAppointment');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
        return responseMessage;
      }
    } catch (e) {
      return responseMessage;
    }
    return responseMessage;
  }

}
