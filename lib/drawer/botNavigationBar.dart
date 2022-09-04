import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBar();
}

class _bottomNavigationBar extends State<bottomNavigationBar> {
  int _index = 2;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff5ac18e),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.7),
      selectedFontSize: 14,
      unselectedFontSize: 12,
      currentIndex: _index,
      onTap: (int index) => setState(() => _index = index),
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
    );
  }
}
