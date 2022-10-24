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
      Uri.parse( databaseURL().toString() +'api/admin/viewProfile'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      for (var detail in item) {
        for (var item in detail) {
          result = ProfileDetail.fromJson(item);
          resultList.add(result);
        }
      }
      // result = ProfileDetail.fromJson(item[0][0]);
    } else {
      print('error');
    }
  } catch (e) {
    log(e.toString());
  }
  return resultList;
}

Future<List<ProfileDetail>> fetchProfileDetailByID(String id) async{
  List<ProfileDetail>? resultProfile = [];
  ProfileDetail? result;
 try {
    final response = await http.get(
      Uri.parse( databaseURL().toString() +'api/admin/viewProfileByID/'+id),
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



// class Profile with ChangeNotifier {
//   List<ProfileDetail> _profile = [];

//   List<ProfileDetail> get profile{
//     return [..._profile];
//   }

//   Future<ProfileDetail> fetcheProfileDetail() async {
//     var url = Uri.parse('http://192.168.68.108:80/api/admin/viewProfile');

//     try {
//       final reponse = await http.get(url);
//       final reponseData = json.decode(reponse.body);
//       final List<ProfileDetail> loadedDetail = [];
//       if (reponseData.isEmpty) {
//         return;
//       }

//       for (var detail in reponseData) {
//         for (var item in detail) {
//           loadedDetail.add(ProfileDetail(
//               id: item['id'].toString(),
//               name: item['name'],
//               DOB: item['DOB'],
//               gender: item['gender'],
//               roomID: item['roomID'],
//               bedID: item['bedNo'],
//               desc: item['descrition'],
//               erID: item['erID']));
//         }
//       }
//       print(reponseData);
//       _profile = loadedDetail.toList();

//       notifyListeners();
//     } catch (error) {
//       print(error);
//     }
//   }
// }
