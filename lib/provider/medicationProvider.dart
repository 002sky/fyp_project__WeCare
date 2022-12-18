import 'package:flutter/cupertino.dart';
import '../config/databaseConfig.dart';
import '../modal/medication.dart';
import 'dart:convert';

import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;

class MedicationProvider extends ChangeNotifier {
  List<Medication>? _medication = [];
  List<Medication>? _MedicationByID = [];
  List<Medication>? _MedicationByElderlyID = [];


  bool _isloading = false;

  List<Medication> get medication {
    return [...?_medication];
  }

  List<Medication> get medicationByElderlyID {
    return [...?_MedicationByElderlyID];
  }
  List<Medication> get medicationByID {
    return [...?_MedicationByID];
  }

  getMedicationData() async {
    List<Medication>? loadedMedication = [];

    _isloading = true;

    loadedMedication = await fetchMedicationData();

    _isloading = false;

    _medication = loadedMedication;

    notifyListeners();
  }

  Future<Map<String, dynamic>?> setMedication(String data) {
    Future<Map<String, dynamic>?> success = setMedicationData(data);

    getMedicationData();

    return success;
  }

  Future<void> getMedicationByID(String id) async {
    List<Medication>? loadedMedicationByID = [];

    _isloading = true;

    if (medication.isNotEmpty) {
      var Findid = medication.where((element) => element.id == id);

      if (Findid.isNotEmpty) {
        loadedMedicationByID = Findid.toList();
      }
    }
    _isloading = false;

    _MedicationByID = loadedMedicationByID;
  }

  Future<void> getMedicationByElderly(String id) async {
    List<Medication>? loadedMedicationByID = [];

    _isloading = true;

    if (medication.isNotEmpty) {
      try {
        var Findid = medication.where((element) => element.elderlyID == id);
        if (Findid.isNotEmpty) {
          loadedMedicationByID = Findid.toList();
          _MedicationByElderlyID = loadedMedicationByID;
        }
      } catch (e) {
        print(e);
      }
    }
    _isloading = false;
  }

  Future<Map<String,dynamic>?> updateMedication(String data) async{
        Map<String, dynamic>? responseMessage = {
    'success': false,
    'message': 'Something went wrong'
  };
  final url = Uri.parse(databaseURL() + 'api/admin/updateMedication');

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
