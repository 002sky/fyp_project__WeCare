
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/ProfileDetailCard.dart';


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
      body: Column(
        children: <Widget>[
          SizedBox(height: 5),
          ProfileDetailCard(id),
         
        ],
      ),
    );
  }


}
