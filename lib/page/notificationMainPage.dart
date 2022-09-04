import 'package:flutter/material.dart';
import 'package:fyp_project_testing/component/NotificationFilter.dart';
import 'package:fyp_project_testing/component/notificationCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotidificationMainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            NotificationFilter(),
            NotificationCard(),
            SizedBox(height: 4),
            NotificationCard(),

          ],
        ));
  }


}
