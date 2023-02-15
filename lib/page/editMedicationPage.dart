import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medication.dart';
import 'package:fyp_project_testing/page/addMedicationTiming.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import '../modal/elderlyMenu.dart';

class EditMedicationPage extends StatefulWidget {
  var id;

  EditMedicationPage(this.id, {super.key});

  @override
  State<EditMedicationPage> createState() => _EditMedicationPage();
}

class _EditMedicationPage extends State<EditMedicationPage> {
  final medicationNameController = TextEditingController();
  final medicationTypeController = TextEditingController();
  final medicationDescriptionController = TextEditingController();
  final expireDateController = TextEditingController();
  final doseController = TextEditingController();
  final quantityController = TextEditingController();
  final elderlyIDController = TextEditingController();
  List<ElderlyMenu> listElderly = [];
  String? selected;
  String ElderlySelected = '';
  var _isInit = true;
  var _isLoading = false;
  List<XFile>? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  List<Medication> loadedMedication = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<MedicationProvider>(
        context,
        listen: false,
      ).getMedicationByID(widget.id).then((_) {
        loadedMedication =
            Provider.of<MedicationProvider>(context, listen: false)
                .medicationByID;

        Provider.of<ProfileProvider>(context, listen: false)
            .getElderlyMenu()
            .then((_) {
          listElderly = Provider.of<ProfileProvider>(context, listen: false)
              .elderlyMunuList;
           ElderlySelected = loadedMedication.first.elderlyID;
          setState(() {
            _isLoading = false;
          });
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  Uint8List avatarImage(String img) {
    Uint8List bytes = base64.decode(img);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Edit  Medication Page'),
      ),
      body: Form(
        key: _formKey,
        child: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: <Widget>[
                    imageMedication(loadedMedication.first.image,
                        loadedMedication.first.medicationName),
                    SizedBox(height: 20),
                    MedicationNameTextField(
                        loadedMedication.first.medicationName),
                    SizedBox(height: 20),
                    MedicationTypeTextField(loadedMedication.first.type),
                    SizedBox(height: 20),
                    MedicationDescTextField(loadedMedication.first.description),
                    SizedBox(height: 20),
                    DoseTextField(loadedMedication.first.dose),
                    SizedBox(height: 20),
                    ExpireDateTextField(
                        loadedMedication.first.expireDate.toString()),
                    SizedBox(height: 20),
                    QuantityTextField(
                        loadedMedication.first.quantity.toString()),
                    SizedBox(height: 20),
                    ElderlyMenuField(loadedMedication.first.elderlyID),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text('Submit',style: TextStyle(color: Colors.white),),
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
                            'id': widget.id,
                            'medicationName': medicationNameController.text,
                            'type': medicationTypeController.text,
                            'description': medicationDescriptionController.text,
                            'expireDate': expireDateController.text,
                            'dose': doseController.text,
                            'image': img64.isEmpty ? null : img64,
                            'quantity': quantityController.text,
                            'elderlyID': ElderlySelected,
                          });

                          Map<String, dynamic>? msg =
                              await Provider.of<MedicationProvider>(context,
                                      listen: false)
                                  .updateMedication(data);

                          if (msg!.isNotEmpty) {
                            _showErrorDialog(msg['message'],
                                msg['success'] != true ? 'Error' : 'Message');
                          }
                        }
                      },
                    ),
                  ]),
      ),
    );
  }

  Future<void> _showErrorDialog(String msg, String title) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
                  if (title == 'Error') {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }

  Widget imageMedication(String elderlyImage, String name) {
    return Center(
        child: Stack(
      children: <Widget>[
        _imageFile == null && elderlyImage.isNotEmpty
            ? CircleAvatar(
                radius: 80,
                backgroundImage: MemoryImage(avatarImage(elderlyImage)))
            : _imageFile != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(_imageFile!.first.path)),
                  )
                : CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.white,
                    child: Text(
                      name[0].toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ),
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

  Widget MedicationNameTextField(String MedicationName) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Medication Name Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationNameController..text = MedicationName,
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

  Widget MedicationTypeTextField(String Type) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Medication Type Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationTypeController..text = Type,
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

  Widget MedicationDescTextField(String desc) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Desciption Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: medicationDescriptionController..text = desc,
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

  Widget ExpireDateTextField(String expireDate) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date of Birth Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: expireDateController..text = expireDate,
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

  Widget DoseTextField(String dose) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Dose Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: doseController..text = dose,
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

  Widget QuantityTextField(String quantity) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Quantity Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: quantityController..text = quantity,
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

  Widget ElderlyMenuField(String relativeID) {
    String selected = relativeID;
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'please select a elderly';
          } else {
            return null;
          }
        },
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
              Icons.face,
              color: Theme.of(context).primaryColor,
            ),
            labelText: 'Elderly',
            helperText: 'Elderly  Cannot Be Empty'),
        value: selected,
        items: listElderly.map((list) {
          return DropdownMenuItem(
            child: Text(list.elderlyName),
            value: list.id.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selected = value.toString();
            ElderlySelected = value.toString();
          });
        });
  }
}
