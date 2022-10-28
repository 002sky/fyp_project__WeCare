import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../provider/ElderlyProfile.dart';
import '../modal/profileDetail.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileDetail>? _Profile = [];
  List<ProfileDetail>? _ProfileByID = [];
  // ProfileDetail? post;
  bool _isloading = false;

  List<ProfileDetail> get profile {
    return [...?_Profile];
  }

  List<ProfileDetail> get profileByID {
    return [...?_ProfileByID];
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

  addProfile(String data) {}
}
