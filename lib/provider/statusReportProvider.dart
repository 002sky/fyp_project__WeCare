import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:http/http.dart' as http;

class StatusReportProvider extends ChangeNotifier {
   late Map<String, dynamic> _reportTotal;

  Map<String, dynamic> get reportTotal {
    return _reportTotal;
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
    } catch (e) {
      
    }
  }
}
