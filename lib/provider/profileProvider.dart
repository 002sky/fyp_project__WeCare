import 'package:flutter/cupertino.dart';

import '../provider/ElderlyProfile.dart';
import '../modal/profileDetail.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileDetail>? _Profile = [];
  // ProfileDetail? post;
  bool loading = false;

  List<ProfileDetail> get profile {
    return [...?_Profile];
  }

  getPostData() async {
    List<ProfileDetail>? loadedProfile = [];

    loading = true;
    loadedProfile = (await fetchProfileDetail());
    loading = false;

    _Profile = loadedProfile;

    notifyListeners();
  }
}
