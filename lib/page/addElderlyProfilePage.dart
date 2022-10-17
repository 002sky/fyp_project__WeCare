import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddElderlyProfilePage extends StatefulWidget {
  const AddElderlyProfilePage({super.key});

  @override
  State<AddElderlyProfilePage> createState() => _AddElderlyProfilePageState();
}

class _AddElderlyProfilePageState extends State<AddElderlyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Add Elderly profile'),
      ),
      body: Container(
        child: FormBuilder(
            child: Column(
          children: [
            
          ],
        )),
      ),
    );
  }
}
