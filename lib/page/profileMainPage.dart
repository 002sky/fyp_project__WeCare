import 'package:flutter/material.dart';
// import 'package:fyp_project_testing/dummy_data/dummy_profile.dart';
// import 'package:fyp_project_testing/modal/profile.dart';
import 'package:fyp_project_testing/page/ProfileCard.dart';
import 'package:provider/provider.dart';
import '../provider/ElderlyProfile.dart';

class ProfileMainPage extends StatelessWidget {
  static const routeName = "/profileMainPage";
  // List<Profile> elderprofile = dummy_profile.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Elderly Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // Expanded(
          //     child: ListView.builder(
          //   itemCount: dummy_profile.length,
          //   itemBuilder: (context, index) {
          //     return ProfileCard(
          //         elderprofile[index].name,
          //         elderprofile[index].profilePic,
          //         elderprofile[index].gender,
          //         elderprofile[index].desc,
          //         elderprofile[index].color);
          //   },
          // )),
          ProfileCareList(),
        ]));
  }
}

class ProfileCareList extends StatefulWidget {
  const ProfileCareList({Key? key}) : super(key: key);

  @override
  State<ProfileCareList> createState() => _ProfileCareListState();
}

class _ProfileCareListState extends State<ProfileCareList> {
  late Future _profileDetail;
  Future _obtainProfileDetail() async {
    await Provider.of<Profile>(context, listen: false).fetcheProfileDetail();
  }

  @override
  void initState() {
    // TODO: implement initState
    _profileDetail = _obtainProfileDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_profileDetail.toString());
  }
}
