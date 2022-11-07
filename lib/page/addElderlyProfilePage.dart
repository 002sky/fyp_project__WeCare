import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:fyp_project_testing/modal/profileDetail.dart';
import 'package:fyp_project_testing/provider/ElderlyProfile.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddElderlyProfilePage extends StatefulWidget {
  const AddElderlyProfilePage({super.key});

  @override
  State<AddElderlyProfilePage> createState() => _AddElderlyProfilePageState();
}

class _AddElderlyProfilePageState extends State<AddElderlyProfilePage> {
  final elderlyNameContoller = TextEditingController();
  final relativeIDController = TextEditingController();
  final bedIDController = TextEditingController();
  final DOBContoller = TextEditingController();
  final roomIDController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  String? genderController;

  // TextEditingController elderlyNameContoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Create Elderly profile'),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  child: Text('Create Elderly Profile'),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FormBuilderTextField(
                  name: 'Elderly Name',
                  decoration: InputDecoration(
                      labelText: 'Elderly Name',
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  controller: elderlyNameContoller,
                ),
                SizedBox(height: 10),

                FormBuilderRadioGroup(
                  decoration: InputDecoration(labelText: 'gender'),
                  name: 'Gender',
                  options: ['Male', 'Female']
                      .map((lang) => FormBuilderFieldOption(value: lang))
                      .toList(growable: false),
                  onChanged: (value) {
                    genderController = value.toString();
                    print(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FormBuilderDateTimePicker(
                  name: "Date of Birth",
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  inputType: InputType.date,
                  format: DateFormat('y-M-d'),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "roll";
                    }
                  },
                  onChanged: (value) => {},
                  controller: DOBContoller,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                FormBuilderTextField(
                  name: "Room ID",
                  decoration: InputDecoration(labelText: 'Room ID'),
                  controller: roomIDController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FormBuilderTextField(
                  name: "Bed ID",
                  decoration: InputDecoration(labelText: 'Bed ID'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText: 'please enter the Bed No')
                    ],
                  ),
                  controller: bedIDController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FormBuilderImagePicker(
                  name: 'singleAvatarPhoto',
                  decoration: const InputDecoration(
                    labelText: 'Pick Photos',
                  ),
                  transformImageWidget: (context, displayImage) => Card(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox.expand(
                      child: displayImage,
                    ),
                  ),
                  showDecoration: false,
                  maxImages: 1,
                  previewAutoSizeWidth: false,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FormBuilderTextField(
                  name: "Relative ID",
                  decoration: InputDecoration(labelText: 'Relative ID'),
                  controller: relativeIDController,
                ),

                OutlinedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() == true) {
                      String profileData = jsonEncode({
                        'name': elderlyNameContoller.text,
                        'DOB': DOBContoller.text,
                        'gender': genderController,
                        'roomID': roomIDController.text,
                        'bedNo': bedIDController.text,
                        'erID': relativeIDController.text,
                      });
                      addElderlyProfile(profileData);
                    }
                  },
                ),

                // SizedBox(height: 10),
                // Align(
                //   child: Text('Color',
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                //   alignment: Alignment.centerLeft,
                // ),

                // Row(
                //   children: [
                //     OutlinedButton(
                //         onPressed: (() => {},
                //         child: Text('button')),
                //   ],
                // )
              ],
            )),
      ),
    );
  }
}
