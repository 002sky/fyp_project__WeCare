import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:fyp_project_testing/dummy_data/dummy_profile.dart';
// import 'package:fyp_project_testing/modal/profile.dart';
import 'package:fyp_project_testing/page/ProfileCard.dart';
import 'package:fyp_project_testing/page/addElderlyProfilePage.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:provider/provider.dart';
import '../provider/ElderlyProfile.dart';

class ProfileMainPage extends StatelessWidget {
  static const routeName = "/profileMainPage";
  // List<Profile> elderprofile = dummy_profile.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            ProfileCareList(),
          ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddElderlyProfilePage(),
                fullscreenDialog: true,
              ))
        },
      ),
    );
  }
}

class ProfileCareList extends StatefulWidget {
  const ProfileCareList({Key? key}) : super(key: key);

  @override
  State<ProfileCareList> createState() => _ProfileCareListState();
}

class _ProfileCareListState extends State<ProfileCareList> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).getPostData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  // @override
  // void initState() {
  //   Provider.of<ProfileProvider>(context,listen: false).getPostData();
  //   super.initState();
  // }

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   postData = Provider.of<ProfileProvider>(context, listen: false);

  // }

  @override
  Widget build(BuildContext context) {
    final postD = Provider.of<ProfileProvider>(context, listen: false).profile;
    if (postD.isEmpty) {
      return Container(
        child: Text('nothing Yet'),
      );
    } else {
      return Expanded(
          child: ListView.builder(
        itemCount: postD.length,
        itemBuilder: (context, index) {
          return ProfileCard(
              postD[index].name,
              postD[index].DOB,
              postD[index].bedID,
              postD[index].gender,
              postD[index].desc,
              postD[index].id);
        },
      ));
    }
    // return Text(postD.post?.last.DOB ?? '') ;
  }
}
