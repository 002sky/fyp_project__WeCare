import 'package:flutter/material.dart';
import 'package:fyp_project_testing/main.dart';
import 'package:fyp_project_testing/page/addUserAccount.dart';
import 'package:fyp_project_testing/page/authPage.dart';
import 'package:fyp_project_testing/page/mainPage.dart';

import 'package:fyp_project_testing/provider/auth.dart';

import 'drawerListTile.dart';
import 'logoutButton.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0x405ac18e),
              Color(0x995ac18e),
              Color(0xcc5ac18e),
              Color(0xff5ac18e),
            ])),
        child: Column(
          children: <Widget>[
            DrawerHeader(
                child: Text(
              'WeCare',
              style: TextStyle(fontSize: 40),
            )),
            Expanded(
              child: Column(children: <Widget>[
                DrawerListTile(Icons.person, 'Elderly Relative Profile', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AddUserAccount(),
                      fullscreenDialog: true,
                    ),
                  );
                }),
                DrawerListTile(
                    Icons.document_scanner, 'Status Report', () => {}),
              ]),
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        LogoutButton(Icons.logout, "Logout", () async {
                          await Auth().logout();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()),
                              ModalRoute.withName('/'));
                        })
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
