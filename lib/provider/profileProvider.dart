import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:fyp_project_testing/modal/elderlyMenu.dart';
import '../modal/profileDetail.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  List<ProfileDetail>? _Profile = [];
  List<ProfileDetail>? _ProfileByID = [];
  List<ElderlyMenu> _elderlyMenu = [];
  // ProfileDetail? post;
  bool _isloading = false;

  List<ProfileDetail> get profile {
    return [...?_Profile];
  }

  List<ProfileDetail> get profileByID {
    return [...?_ProfileByID];
  }

  List<ElderlyMenu> get elderlyMunuList {
    return [..._elderlyMenu];
  }

  getPostData() async {
    List<ProfileDetail>? loadedProfile = [];

    _isloading = true;

    loadedProfile = (await fetchProfileDetail());

    _isloading = false;

    _Profile = loadedProfile;

    notifyListeners();
  }

  Future<void> getProfileByID(String id) async {
    List<ProfileDetail>? loadedProfileByID = [];
    _isloading = true;
    if (profile.isNotEmpty) {
      var Findid = profile.where((element) => element.id == id);

      if (Findid.isNotEmpty) {
        loadedProfileByID = Findid.toList();
      }
    }
    _isloading = false;
    _ProfileByID = loadedProfileByID;
  }

  getElderlyMenu() async {
    List<ElderlyMenu> resultList = [];
    ElderlyMenu result;

    final url = Uri.parse(databaseURL() + "api/admin/getElderlyMenu");

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        for (var RD in responseData) {
          for (var item in RD) {
            result = ElderlyMenu.fromJson(item);
            resultList.add(result);
          }
        }
      }

      _elderlyMenu = resultList;
      notifyListeners();
    } catch (e) {}
  }

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

      if (response.statusCode == 200) {
        responseMessage = jsonDecode(response.body);
        return responseMessage;
      }
    } catch (e) {
      print(e);
      return responseMessage;
    }
    return responseMessage;
  }

  Future<Map<String, dynamic>?> editProfile(String data) async {
    final url =
        Uri.parse(databaseURL().toString() + 'api/admin/editElderlyProfile');

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
}
