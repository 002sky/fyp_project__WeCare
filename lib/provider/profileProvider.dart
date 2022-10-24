import 'package:flutter/cupertino.dart';

import '../provider/ElderlyProfile.dart';
import '../modal/profileDetail.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileDetail>? _Profile = [];
  List<ProfileDetail>? _ProfileByID = [];
  // ProfileDetail? post;
  bool loading = false;

  List<ProfileDetail> get profile {
    return [...?_Profile];
  }

  List<ProfileDetail> get profileByID {
    return [...?_ProfileByID];
  }

  getPostData() async {
    List<ProfileDetail>? loadedProfile = [];

    loading = true;
    loadedProfile = (await fetchProfileDetail());
    loading = false;

    _Profile = loadedProfile;

    notifyListeners();
  }

  getProfileByID(String id) async {
    List<ProfileDetail>? loadedProfileByID = [];

    loading = true;
    loadedProfileByID = (await fetchProfileDetailByID(id));
    
    loading = false;

    _ProfileByID = loadedProfileByID;

    notifyListeners();
  }
}
