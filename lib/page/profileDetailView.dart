import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/ProfileDetailCard.dart';
import 'package:fyp_project_testing/page/elderlyMedicationDetailCard.dart';

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
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          ProfileDetailCard(id),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(
              height: 2,
              thickness: 2,
              color: Colors.black,
            ),
          ),
          ElderlyMedicationDetailCard(id),
        ],
      ),
    );
  }
}
