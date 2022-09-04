import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class ProfileDetail {
  final String id;
  final String name;
  final String DOB;
  final String gender;
  final String roomID;
  final String bedID;
  final String desc;
  final int erID;

  ProfileDetail({
    required this.id,
    required this.name,
    required this.DOB,
    required this.gender,
    required this.roomID,
    required this.bedID,
    required this.desc,
    required this.erID,
  });
}

class Profile with ChangeNotifier {
  List<ProfileDetail> _profile = [];

  Future<void> fetcheProfileDetail() async {
    var url = Uri.parse('http://192.168.68.102:80/api/admin/viewProfile');

    try {
      final reponse = await http.get(url);
      final reponseData = json.decode(reponse.body);
      final List<ProfileDetail> loadedDetail = [];
      if (reponseData.isEmpty) {
        return;
      }

      for (var detail in reponseData) {
        for (var item in detail) {
          loadedDetail.add(ProfileDetail(
              id: item.toString(),
              name: item['name'],
              DOB: item['DOB'],
              gender: item['gender'],
              roomID: item['roomID'],
              bedID: item['bedNo'],
              desc: item['descrition'],
              erID: item['erID']));
        }
      }

      _profile = loadedDetail.toList();
      print(_profile.first);
    } catch (error) {
      print(error);
    }
  }
}
