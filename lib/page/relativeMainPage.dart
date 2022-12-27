import 'package:flutter/material.dart';
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
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            ListTile(
              title: Text('Appointment'),
              trailing: Icon(Icons.open_in_full),
              onTap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Statu Report'),
              trailing: Icon(Icons.open_in_full),
              onTap: () {},
            ),
          ],
        ));
  }
}
