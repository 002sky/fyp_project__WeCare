import 'package:flutter/cupertino.dart';

import '../provider/ElderlyProfile.dart';
import '../modal/profileDetail.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileDetail>? post;
  // ProfileDetail? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await fetchProfileDetail());
    loading = false;

    notifyListeners();
  }
}
