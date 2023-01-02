import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/relativeUser.dart';
import 'package:fyp_project_testing/provider/ElderlyProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../modal/profileDetail.dart';
import '../provider/profileProvider.dart';
import '../provider/userProvider.dart';

class EditElderlyProfilePage extends StatefulWidget {
  const EditElderlyProfilePage(this.id, {super.key});
  final id;

  @override
  State<EditElderlyProfilePage> createState() => _EditElderlyProfilePageState();
}

class _EditElderlyProfilePageState extends State<EditElderlyProfilePage> {
  final DOBcontroller = TextEditingController();
  final bedNoContoller = TextEditingController();
  final roomNoContoller = TextEditingController();
  final nameContoller = TextEditingController();
  final descContoller = TextEditingController();
  final relativeContoller = TextEditingController();
  String genderSelected = 'Male';

  var _isInit = true;
  var _isLoading = false;
  List<ProfileDetail> loadedProfile = [];
  List<RelativeUser> listRelative = [];
  final _formKey = GlobalKey<FormState>();
  String relativeSelected = '';

  List<XFile>? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).getProfileByID(widget.id).then((_) {
        loadedProfile =
            Provider.of<ProfileProvider>(context, listen: false).profileByID;

        Provider.of<UserProvider>(context, listen: false)
            .getAllRelative()
            .then((_) {
          listRelative =
              Provider.of<UserProvider>(context, listen: false).relativeList;
          relativeSelected = loadedProfile.first.erID.toString();
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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Create Elderly profile'),
        ),
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  children: <Widget>[
                    imageProfile(loadedProfile.first.elderlyImage,
                        loadedProfile.first.name),
                    SizedBox(height: 20),
                    nameTextField(loadedProfile.first.name),
                    SizedBox(height: 20),
                    genderManu(loadedProfile.first.gender),
                    SizedBox(height: 20),
                    DOBTextField(loadedProfile.first.DOB),
                    SizedBox(height: 20),
                    BedNoTextField(loadedProfile.first.bedID),
                    SizedBox(height: 20),
                    RoomIDTextField(loadedProfile.first.roomID),
                    SizedBox(height: 20),
                    relativeMenu(loadedProfile.first.erID),
                    SizedBox(height: 20),
                    DescTextField(loadedProfile.first.desc),
                    SizedBox(height: 20),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                        ),
                        onPressed: () async {
                          //conver the Xfile Image to the Base64 String
                          String img64;
                          if (_imageFile == null) {
                            img64 = '';
                          } else {
                            final bytes = await File(_imageFile!.first.path)
                                .readAsBytes();
                            img64 = base64Encode(bytes);
                          }
                          //check the validation of the form, if form not error encode to json send to networkUtil
                          if (_formKey.currentState!.validate()) {
                            String profileData = jsonEncode({
                              'id': widget.id,
                              'name': nameContoller.text,
                              'DOB': DOBcontroller.text,
                              'gender': genderSelected.toString(),
                              'roomID': roomNoContoller.text,
                              'bedNo': bedNoContoller.text,
                              'elderlyImage': img64.isEmpty ? null : img64,
                              'descrition': descContoller.text,
                              'erID': relativeSelected,
                            });
                            Map<String, dynamic>? msg =
                                await editProfile(profileData);

                            if (msg!.isNotEmpty) {
                              _showErrorDialog(msg['message'],
                                  msg['success'] != true ? 'Error' : 'Message');
                            }
                          }
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ));
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
                    Navigator.of(context).pop();
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

  //Image upload widget
  Widget imageProfile(String elderlyImage, String name) {
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

  Widget nameTextField(String name) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: nameContoller..text = name,
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

  Widget RoomIDTextField(String roomID) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Room ID Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: roomNoContoller..text = roomID,
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

  Widget BedNoTextField(String bedID) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bed Number Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: bedNoContoller..text = bedID,
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

  Widget relativeMenu(int erID) {
    String selected = erID.toString();
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'please select a Relative';
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
        ),
        value: selected,
        items: listRelative.map((list) {
          return DropdownMenuItem(
            child: Text(list.name),
            value: list.id.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selected = value.toString();
            relativeSelected = value.toString();
          });
        });
  }

  Widget DOBTextField(String dob) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date of Birth Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: DOBcontroller..text = dob,
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

  Widget DescTextField(String desc) {
    return TextFormField(
      maxLines: 4,
      maxLength: 400,
      controller: descContoller..text = desc,
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

  Widget genderManu(String gender) {
    String dropdownValue;
    if (gender.isNotEmpty) {
      dropdownValue = gender;
    } else {
      dropdownValue = 'Male';
    }

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
