import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/report.dart';
import 'package:http/http.dart' as http;

class StatusReportProvider extends ChangeNotifier {
  Map<String, dynamic> _reportTotal = {};
  List<Map<String, dynamic>> _reportStatus = [];
  List<Report> _completeReportByID = [];
  List<Report> _completeReportDetailByID = [];

  List<Report> get completeReport {
    return [..._completeReportByID];
  }

  List<Report> get completeReportDetailByID {
    return [..._completeReportDetailByID];
  }

  Map<String, dynamic> get reportTotal {
    return _reportTotal;
  }

  List<Map<String, dynamic>> get reportStatus {
    return [..._reportStatus];
  }

  getReportTotal() async {
    final url = Uri.parse(databaseURL() + "api/admin/viewStatusReportStatus");
    Map<String, dynamic> loaddedList;
    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        loaddedList = json.decode(response.body);

        _reportTotal = loaddedList;
      }
    } catch (e) {}
  }

  getStatusReport() async {
    final url =
        Uri.parse(databaseURL() + "api/admin/getIncompleteElderlyStatus");
    List<Map<String, dynamic>> loaddedList = [];

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        for (var items in item) {
          loaddedList.add(items);
        }

        _reportStatus = loaddedList;
      }
    } catch (e) {}
  }

  Future<Map<String, dynamic>?> setStatuReport(String data) async {
    Map<String, dynamic>? responseMessage = {
      'success': false,
      'message': 'Something went wrong'
    };

    final url = Uri.parse(databaseURL() + 'api/admin/setElderlyStatusReport');

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

  getStatusReportByID(int userID) async {
    List<Report> resultList = [];
    Report result;

    final url =
        Uri.parse(databaseURL() + 'api/relative/getCompleteElderlyStatusByID');

    String data = jsonEncode({'id': userID});

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        for (var detail in item) {
          result = Report.fromJson(detail);
          resultList.add(result);
        }
      }
    } catch (e) {}

    _completeReportByID = resultList;

    notifyListeners();
  }

  Future<void> getMedicationByID(String time) async {
    List<Report>? loadedReport = [];

    if (completeReport.isNotEmpty) {
      var Findid = completeReport.where((element) => element.writtenTime == time);

      if (Findid.isNotEmpty) {
        loadedReport = Findid.toList();
      }
    }

    _completeReportDetailByID = loadedReport;
  }
}
