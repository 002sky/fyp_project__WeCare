import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:http/http.dart' as http;

import '../modal/overview.dart';

class OverViewProvider extends ChangeNotifier {
  List<Overview>? _overview = [];

  List<Overview>? get overview {
    return [...?_overview];
  }

  getOverView() async {
    List<Overview>? resultList = [];
    Overview? result;

    final url = Uri.parse(databaseURL() + 'api/admin/getOverView');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final OverviewMessage = json.decode(response.body);

        for (var detial in OverviewMessage) {
          for (var item in detial) {
            result = Overview.fromJson(item);
            resultList.add(result);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    _overview = resultList;
    notifyListeners();
  }
}
