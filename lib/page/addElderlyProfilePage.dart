import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/ElderlyProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddElderlyProfilePage extends StatefulWidget {
  const AddElderlyProfilePage({super.key});

  @override
  State<AddElderlyProfilePage> createState() => _AddElderlyProfilePageState();
}

class _AddElderlyProfilePageState extends State<AddElderlyProfilePage> {
  final DOBcontroller = TextEditingController();
  final bedNoContoller = TextEditingController();
  final roomNoContoller = TextEditingController();
  final nameContoller = TextEditingController();
  final descContoller = TextEditingController();
  final relativeContoller = TextEditingController();
  String genderSelected = 'Male';

  final _formKey = GlobalKey<FormState>();

  List<XFile>? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Create Elderly profile'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: <Widget>[
              imageProfile(),
              SizedBox(height: 20),
              nameTextField(),
              SizedBox(height: 20),
              genderManu(),
              SizedBox(height: 20),
              DOBTextField(),
              SizedBox(height: 20),
              BedNoTextField(),
              SizedBox(height: 20),
              RoomIDTextField(),
              SizedBox(height: 20),
              RelativeTextField(),
              SizedBox(height: 20),
              DescTextField(),
              SizedBox(height: 20),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: () async {
                    //conver the Xfile Image to the Base64 image 
                    final bytes =
                        await File(_imageFile!.first.path).readAsBytes();

                    String img64 = base64Encode(bytes);

                    //check the validation of the form, if form not error encode to json send to networkUtil 
                    if (_formKey.currentState!.validate()) {
                      String profileData = jsonEncode({
                        'name': nameContoller.text,
                        'DOB': DOBcontroller.text,
                        'gender': genderSelected.toLowerCase().toString(),
                        'roomID': roomNoContoller.text,
                        'bedNo': bedNoContoller.text,
                        'elderlyImage': img64,
                        'descrition': descContoller.text,
                        'erID': relativeContoller.text,
                      });
                      addElderlyProfile(profileData);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ));
  }

  //Image upload widget
  Widget imageProfile() {
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
    final pickedFile = await _picker.pickImage(source: source);

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

  Widget nameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: nameContoller,
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
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Name',
          helperText: 'Name Cannot Be Empty'),
    );
  }

  Widget RoomIDTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Room ID Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: roomNoContoller,
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
            Icons.house,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Room Number',
          helperText: 'Room Number Cannot Be Empty'),
    );
  }

  Widget BedNoTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bed Number Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: bedNoContoller,
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
            Icons.bed,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Bed Number',
          helperText: 'Bed Number Cannot Be Empty'),
    );
  }

  Widget RelativeTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bed Number Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: relativeContoller,
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
            Icons.bed,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Relative',
          helperText: 'Eldery Raltive Cannot Be Empty'),
    );
  }

  Widget DOBTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date of Birth Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: DOBcontroller,
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
          labelText: 'Date of Birth',
          helperText: 'Bed No Cannot Be Empty'),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1940),
            lastDate: DateTime(2100));
        if (pickedDate != null) {
          setState(() {
            String formatedDate = DateFormat('y-M-d').format(pickedDate);
            DOBcontroller.text = formatedDate.toString();
          });
        } else {
          setState(() {
            DOBcontroller.text = '';
          });
        }
      },
    );
  }

  Widget DescTextField() {
    return TextFormField(
      maxLines: 4,
      maxLength: 400,
      controller: descContoller,
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
            Icons.description,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Description',
          helperText: 'Description Cannot be Empty'),
    );
  }

  Widget genderManu() {
    String dropdownValue = 'Male';
    return DropdownButtonFormField(
        items: <String>['Male', 'Female']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            genderSelected = newValue;
            print(genderSelected);
          });
        },
        value: dropdownValue,
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
        ));
  }
}
