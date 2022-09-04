import 'package:flutter/material.dart';
import 'package:fyp_project_testing/dummy_data/dummy_profile.dart';
import 'package:fyp_project_testing/modal/profile.dart';
import 'package:fyp_project_testing/page/ProfileCard.dart';

class ProfileMainPage extends StatelessWidget {

  static const routeName = "/profileMainPage";
  List<Profile> elderprofile = dummy_profile.toList();


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
          Expanded(
              child: ListView.builder(
            itemCount: dummy_profile.length,
            itemBuilder: (context, index) {
              return ProfileCard(
                  elderprofile[index].name,
                  elderprofile[index].profilePic,
                  elderprofile[index].gender,
                  elderprofile[index].desc,
                  elderprofile[index].color);
            },
          )),
      
        ]));
  }
}
