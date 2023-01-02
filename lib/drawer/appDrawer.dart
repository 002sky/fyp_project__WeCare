import 'package:flutter/material.dart';
import 'package:fyp_project_testing/main.dart';
import 'package:fyp_project_testing/page/MessageBoxMainPage.dart';
import 'package:fyp_project_testing/page/addUserAccount.dart';
import 'package:fyp_project_testing/page/adminAppointment.dart';
import 'package:fyp_project_testing/page/overViewPage.dart';

import 'package:fyp_project_testing/provider/auth.dart';
import 'package:provider/provider.dart';

import 'drawerListTile.dart';
import 'logoutButton.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool usertype = Provider.of<Auth>(context, listen: false).isAdmin;

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
            usertype
                ? Expanded(
                    child: Column(children: <Widget>[
                      DrawerListTile(Icons.person, 'Elderly Relative Profile',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AddUserAccount(),
                            fullscreenDialog: true,
                          ),
                        );
                      }),
                      DrawerListTile(Icons.document_scanner, 'Overview', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => OverViewPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      }),
                      DrawerListTile(Icons.person, 'Message Box', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                MessageBoxMainPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      }),
                      DrawerListTile(Icons.list, 'Appointment', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AdminAppointment(),
                            fullscreenDialog: true,
                          ),
                        );
                      }),
                    ]),
                  )
                : Expanded(
                    child: Column(children: <Widget>[
                      DrawerListTile(Icons.person, 'Message Box', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                MessageBoxMainPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      }),
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
