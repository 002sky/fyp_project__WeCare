import 'package:flutter/material.dart';

class MedicationDetailPage extends StatelessWidget {
  final id;

  MedicationDetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Detail'),
      ),
      body: Container(
        child: Column(
          children: [Text('data')],
        ),
      ),
    );
  }
}
