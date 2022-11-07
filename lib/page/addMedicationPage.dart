import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fyp_project_testing/provider/medicationUtility.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final medicationNameController = TextEditingController();
  final medicationTypeController = TextEditingController();
  final medicationDescriptionController = TextEditingController();
  late DateTime expireDateController;
  late DateTime manufactureDate;
  final quantityController = TextEditingController();
   final elderlyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Create Elderly profile'),
      ),
      body: Container(
        child: FormBuilder(
          child: Column(children: [
            FormBuilderTextField(
              name: 'Medication Name',
              decoration: InputDecoration(
                labelText: 'Medication Name',
              ),
              controller: medicationNameController,
            ),
            FormBuilderTextField(
              name: 'Medication Type',
              decoration: InputDecoration(
                labelText: 'Medication Type',
              ),
              controller: medicationTypeController,
            ),
            FormBuilderTextField(
              name: 'Description',
              decoration: InputDecoration(
                labelText: 'Description ',
              ),
              controller: medicationDescriptionController,
            ),
            FormBuilderDateTimePicker(
              decoration: InputDecoration(
                labelText: 'Expire Date',
              ),
              name: "expire date",
              inputType: InputType.date,
              format: DateFormat('y-M-d'),
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "roll";
                }
              },
              onChanged: (value) => {
                expireDateController = value!,
              },
              
            ),
            FormBuilderDateTimePicker(
              decoration: InputDecoration(labelText: "Manufacture Date"),
              name: "manufacture date",
              inputType: InputType.date,
              format: DateFormat('y-M-d'),
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "roll";
                }
              },
              onChanged: (value) => {
                manufactureDate = value!,
              },
              
            ),
            FormBuilderTextField(
              name: 'quantity',
              decoration: InputDecoration(
                labelText: 'quantity',
              ),
              controller: quantityController,
            ),
            FormBuilderTextField(
              name: 'elderly relative',
              decoration: InputDecoration(
                labelText: 'elderly relative',
              ),
              controller: elderlyIDController,
            ),
            OutlinedButton(
              child: Text('Submit'),
              onPressed: () {
                String data = json.encode({
                  'medicationName': medicationNameController.text,
                  'type': medicationTypeController.text,
                  'description': medicationDescriptionController.text,
                  'expireDate': expireDateController.toString(),
                  'manufactureDate': manufactureDate.toString(),
                  'quantity': quantityController.text,
                  'elderlyID': elderlyIDController.text,
                });
                print(data);
                setMedicationData(data);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
