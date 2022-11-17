import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/ProfileDetailCard.dart';
import 'package:fyp_project_testing/page/addElderlyProfilePage.dart';
import 'package:fyp_project_testing/page/editProfilePage.dart';

import 'package:provider/provider.dart';
import '../provider/profileProvider.dart';

class ProfileDetailView extends StatelessWidget {
  final id;

  ProfileDetailView(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('profile detail'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            Text(id),
            ProfileDetailCard(id),
            OutlinedButton(        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>EditElderlyProfilePage(id),
                fullscreenDialog: true,
              ))
        }, child: Text('Edit')),

          ],
        ),
      ),
    );
  }

}
