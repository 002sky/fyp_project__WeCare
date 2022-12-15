import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medication.dart';
import 'package:fyp_project_testing/page/addMedicationTiming.dart';
import 'package:fyp_project_testing/page/editMedicationTimingPage.dart';
import 'package:intl/intl.dart';
import 'package:fyp_project_testing/page/editMedicationPage.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MedicationDetailPage extends StatefulWidget {
  const MedicationDetailPage(this.id, {super.key});
  final id;
  @override
  State<MedicationDetailPage> createState() => _MedicationDetailPageState();
}

class _MedicationDetailPageState extends State<MedicationDetailPage> {
  var _isInit = true;
  var _isLoading = false;
  var loadedMedication = [];

  List<XFile>? _imageFile;
  final ImagePicker _picker = ImagePicker();
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
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Uint8List avatarImage(String img) {
    Uint8List bytes = base64.decode(img);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Detail'),
      ),
      body: _isLoading == true
          ? CircularProgressIndicator()
          : ListView(
              children: <Widget>[
                ProfileImage(
                    loadedMedication.first.image.isEmpty
                        ? loadedMedication.first.medicationName
                        : loadedMedication.first.image,
                    loadedMedication.first.image.isEmpty ? 2 : 1),
                ContentDisplay(
                    "Medication Name", loadedMedication.first.medicationName),
                Row(
                  children: [
                    Flexible(
                      child: ContentDisplay(
                          'Medication Type', loadedMedication.first.type),
                    ),
                    Flexible(
                      child: ContentDisplay('Quantity',
                          loadedMedication.first.quantity.toString()),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: ContentDisplay('Expire Date',
                          loadedMedication.first.expireDate.toString()),
                    ),
                    Flexible(
                      child: ContentDisplay(
                          'Dose', loadedMedication.first.dose.toString()),
                    ),
                  ],
                ),
                ContentDisplay('Elderly ID', loadedMedication.first.elderlyID),
                ContentDisplay(
                    'Description', loadedMedication.first.description),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      EditMedicationPage(
                                          loadedMedication.first.id),
                                  fullscreenDialog: true,
                                ))
                          },
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                loadedMedication.first.medicationTime.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        AddMedicationTiming(
                                            loadedMedication.first.id),
                                    fullscreenDialog: true,
                                  ));
                            },
                            child: Text(
                              'Set Timing',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    : MedicationTimingList(
                        loadedMedication.first.medicationTime),
                loadedMedication.first.medicationTime.isEmpty
                    ? Center()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        EditMedicationTiming(
                                            loadedMedication.first.id),
                                    fullscreenDialog: true,
                                  ));
                            },
                            child: Text(
                              'Edit Timing',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
              ],
            ),
    );
  }

  Widget MedicationTimingList(List<MedicationTime> item) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          int disply = index + 1;
          return ContentDisplay('Time:' + disply.toString(), item[index].time);
        });
  }

  Widget ProfileImage(String profileImage, int type) {
    return Center(
      child: type == 1
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: MemoryImage(avatarImage(profileImage)),
            )
          : CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              child: Text(
                profileImage[0].toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
    );
  }

  Widget ContentDisplay(String label, String data) {
    final display = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        readOnly: true,
        controller: display..text = data,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          labelText: label,
        ),
      ),
    );
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}
