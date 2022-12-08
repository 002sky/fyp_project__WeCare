import 'dart:convert';

import 'dart:io';
import 'dart:core';

import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/medication.dart';
import 'package:http/http.dart' as http;

Future<List<Medication>> fetchMedicationData() async {
  List<Medication> resultList = [];
  Medication? result;

  final url = Uri.parse(databaseURL() + 'api/admin/getMedication');
  try {
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      for (var detail in item) {
        for (var item in detail) {
          result = Medication.fromJson(item);
          resultList.add(result);
        }
      }
    } else {
      print('add error');
    }
  } catch (e) {
    print(e);
  }

  return resultList;
}

Future<Map<String, dynamic>?> setMedicationData(String data) async {
  Map<String, dynamic>? responseMessage = {
    'success': false,
    'message': 'Something went wrong'
  };

  final url = Uri.parse(databaseURL() + 'api/admin/setMedication');

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
