import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fyp_project_testing/page/medicationMainPage.dart';
import 'package:fyp_project_testing/page/notificationMainPage.dart';
import 'package:fyp_project_testing/page/profileMainPage.dart';
import 'package:fyp_project_testing/page/scheduleMainPage.dart';
import 'package:fyp_project_testing/page/statusReportPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawer/appDrawer.dart';
import '../provider/auth.dart';

class MainPage extends StatefulWidget {
  static const routeName = "/MainPageRoute";

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _index = 4;
  bool name = true;

  PageController _pageController = PageController();
  List<Widget> _screen = [
    ProfileMainPage(),
    ScheduleMainPage(),
    NotidificationMainPage(),
    MedicationMainPage(),
    StatusReportPage()
  ];

  void _onPageChange(int index) {
    setState(() {
      _index = index;
    });
  }

  void _onItemTapped(int SelectedItem) {
    _pageController.jumpToPage(SelectedItem);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('WeCare'),
      ),
      drawer: AppDrawer(),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: _index,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Elderly'),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_information), label: 'Medication'),
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner), label: 'Report'),
        ],
      ),
    );
  }
}
