
import 'package:flutter/material.dart';

import 'package:fyp_project_testing/provider/auth.dart';



import 'drawerListTile.dart';
import 'logoutButton.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void logout() {
       Auth().logout();
    }

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
                DrawerListTile(Icons.person, 'Elderly Profile', () => {}),
                DrawerListTile(
                    Icons.table_chart_outlined, 'Schedule', () => {}),
                DrawerListTile(
                    Icons.medical_information, 'Medication', () => {}),
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
                        LogoutButton(Icons.logout, "Logout", () => {

                          logout(),
                        })
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}

    // return Drawer(
    //   child: ListView(
    //     children: <Widget>[
    //       DrawerHeader(
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   begin: Alignment.topCenter,
    //                   end: Alignment.bottomCenter,
    //                   colors: [
    //                 Color(0x405ac18e),
    //                 Color(0x995ac18e),
    //                 Color(0xcc5ac18e),
    //                 Color(0xff5ac18e),
    //               ])),
    //           child: Text('WeCare')),
    //       DrawerListTile(Icons.person, 'Elderly Profile', () => {}),
    //       DrawerListTile(Icons.table_chart_outlined, 'Schedule', () => {}),
    //       DrawerListTile(Icons.medication, 'Medication', () => {}),
    //       DrawerListTile(Icons.document_scanner, 'Status Report', () => {}),
    //       Container(
    //         child: Align(
    //           alignment: FractionalOffset.bottomCenter,
    //           child: Column(
    //             children: <Widget>[
    //               Divider(),
    //               LogoutButton(Icons.logout, "Logout", () => {})
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );