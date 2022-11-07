import 'package:flutter/material.dart';

class MedicationDetailPage extends StatelessWidget {
  const MedicationDetailPage({super.key});

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