import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/ProfileDetailCard.dart';

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
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          shadowColor: Colors.greenAccent,
          child: Column(
            children: <Widget>[
              Text(id),
              ProfileDetailCard(id),
            ],
          ),
        ),
      ),
    );
  }
}


