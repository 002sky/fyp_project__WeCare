import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/addMedicationTiming.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final medicationNameController = TextEditingController();
  final medicationTypeController = TextEditingController();
  final medicationDescriptionController = TextEditingController();
  final expireDateController = TextEditingController();
  final doseController = TextEditingController();
  final quantityController = TextEditingController();
  final elderlyIDController = TextEditingController();

  List<XFile>? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Create Elderly profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: <Widget>[
              imageMedication(),
              SizedBox(height: 20),
              MedicationNameTextField(),
              SizedBox(height: 20),
              MedicationTypeTextField(),
              SizedBox(height: 20),
              MedicationDescTextField(),
              SizedBox(height: 20),
              ManufactureTextField(),
              SizedBox(height: 20),
              ExpireDateTextField(),
              SizedBox(height: 20),
              QuantityTextField(),
              SizedBox(height: 20),
              ERTextField(),
              OutlinedButton(
                child: Text('Submit'),
                onPressed: () async {
                  //cover the image into base64 and bytes to store into database
                  String img64;
                  if (_imageFile == null) {
                    img64 = '';
                  } else {
                    final bytes =
                        await File(_imageFile!.first.path).readAsBytes();
                    img64 = base64Encode(bytes);
                  }

                  if (_formKey.currentState!.validate()) {
                    String data = json.encode({
                      'medicationName': medicationNameController.text,
                      'type': medicationTypeController.text,
                      'description': medicationDescriptionController.text,
                      'expireDate': expireDateController.text,
                      'dose': doseController.text,
                      'image': img64.isEmpty ? null : img64,
                      'quantity': quantityController.text,
                      'elderlyID': elderlyIDController.text,
                    });

                    print(data);

                    Map<String, dynamic>? msg = await Provider.of<MedicationProvider>(context,listen: false).setMedication(data);

                    if (msg!.isNotEmpty) {
                      _showErrorDialog(
                          msg['message'],
                          msg['success'] != true ? 'Error' : 'Message',
                          msg['ID'].toString());
                    }
                  }
                },
              ),
            ]),
      ),
    );
  }

  Future<void> _showErrorDialog(String msg, String title, String id) {

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(id),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          AddMedicationTiming(id),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }

  

  Widget imageMedication() {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage('assets/image/icons8-selfies-50.png')
              : FileImage(File(_imageFile!.first.path)) as ImageProvider,
        ),
        Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 20,
              ),
            ))
      ],
    ));
  }

  //popup box for camera
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              SizedBox(width: 20),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 15);

    List<XFile> fileList = [];
    if (pickedFile == null) {
      return;
    } else {
      fileList.add(pickedFile);
      setState(() {
        _imageFile = fileList;
      });
    }
  }

  Widget MedicationNameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Medication Name Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationNameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.medical_information,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Medication Name',
          helperText: 'Name Cannot Be Empty'),
    );
  }

  Widget MedicationTypeTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Medication Type Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationTypeController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.medical_information,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Medication Type',
          helperText: 'Medication type Cannot Be Empty'),
    );
  }

  Widget MedicationDescTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Desciption Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationDescriptionController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.medical_information,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Description',
          helperText: 'Description Cannot Be Empty'),
    );
  }

  Widget ExpireDateTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date of Birth Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: expireDateController,
      readOnly: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Expired Date',
          helperText: 'Expired Date Cannot Be Empty'),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1940),
            lastDate: DateTime(2100));
        if (pickedDate != null) {
          setState(() {
            String formatedDate = DateFormat('y-M-d').format(pickedDate);
            expireDateController.text = formatedDate.toString();
          });
        } else {
          setState(() {
            expireDateController.text = '';
          });
        }
      },
    );
  }

  Widget ManufactureTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Dose Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: doseController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.numbers,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Dose',
          helperText: 'Dose Cannot Be Empty'),
    );
  }

  Widget QuantityTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Quantity Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: quantityController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.medical_information,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Quantity',
          helperText: 'Quantity Cannot Be Empty'),
    );
  }

  Widget ERTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Elderly Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: elderlyIDController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.medical_information,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Elderly ID',
          helperText: 'Elderly ID Cannot Be Empty'),
    );
  }
}
