import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fyp_project_testing/config/databaseConfig.dart';

import 'dart:core';
import '../modal/profileDetail.dart';
import 'package:http/http.dart' as http;

Future<List<ProfileDetail>> fetchProfileDetail() async {
  List<ProfileDetail>? resultList = [];
  ProfileDetail? result;
  try {
    final response = await http.get(
      Uri.parse(databaseURL().toString() + 'api/admin/viewProfile'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      for (var detail in item) {
        for (var items in detail) {
          result = ProfileDetail.fromJson(items);
          resultList.add(result);
        }
      }
      // result = ProfileDetail.fromJson(item[0][0]);
    } else {
      print('error');
    }
  } catch (e) {
    log(e.toString());
    print(e);
  }
  return resultList;
}

Map<String, dynamic> parseJson(String response) {
  return walkJson(json.decode(response));
}

Map<String, dynamic> walkJson(data) {
  data.forEach((key, value) {
    if (value is List == false) {
      data[key] = base64Decode(value);
    } else {
      value.forEach((item) => item = walkJson(item));
    }
  });

  return data;
}

Future<List<ProfileDetail>> fetchProfileDetailByID(String id) async {
  List<ProfileDetail>? resultProfile = [];
  ProfileDetail? result;
  try {
    final response = await http.get(
      Uri.parse(databaseURL().toString() + 'api/admin/viewProfileByID/' + id),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      for (var i in item) {
        result = ProfileDetail.fromJson(i);
        resultProfile.add(result);
      }

      // result = ProfileDetail.fromJson(item[0][0]);
    } else {
      print('error');
    }
  } catch (e) {
    log(e.toString());
  }

  return resultProfile;
}

Future<Map<String, dynamic>?> addElderlyProfile(String data) async {
  final url = Uri.parse(databaseURL().toString() + 'api/admin/createProfile');
  Map<String, dynamic>? responseMessage = {
    'success': false,
    'message': 'Something went wrong'
  };
  try {
    final response = await http.post(
      url,
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    // final responseData = json.decode(response.body);
    responseMessage = jsonDecode(response.body);
  } catch (e) {
    print(e);
      return responseMessage;
  }
  return responseMessage;
}

Future<Map<String, dynamic>?> editProfile(String data) async {
  final url = Uri.parse(databaseURL().toString() + 'api/admin/editElderlyProfile');

  Map<String, dynamic>? responseMessage = {
    'success': false,
    'message': 'Something went wrong'
  };

  try {
    final response = await http.post(url, body: data, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    responseMessage = jsonDecode(response.body);

  } catch (e) {
    print(e);
    return responseMessage;
  }
  return responseMessage;
}
