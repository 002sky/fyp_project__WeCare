import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/relativeStatusReportPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawer/appDrawer.dart';
import '../provider/auth.dart';

class RelativeMainPage extends StatefulWidget {
  const RelativeMainPage({super.key});

  @override
  State<RelativeMainPage> createState() => _RelativeMainPageState();
}

class _RelativeMainPageState extends State<RelativeMainPage> {
  bool userType = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('WeCare'),
        ),
        drawer: AppDrawer(),
        body: GridView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
          ),
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('Container tapped');
              },
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          size: 48,
                          color: Colors.greenAccent,
                        ),
                        Text(
                          'Appointment',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => RelativeStatusRpeortPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.green,
                  width: 2,
                )),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.document_scanner,
                        size: 48,
                        color: Colors.greenAccent,
                      ),
                      Text(
                        'Status Report',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
