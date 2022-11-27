import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medicaion.dart';
import 'package:fyp_project_testing/page/addMedicationTiming.dart';
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
    final loadedMedication =
        Provider.of<MedicationProvider>(context, listen: false).medicationByID;

    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Detail'),
      ),
      body: ListView(
        children: <Widget>[
          ContentDisplay(
              "Medication Name", loadedMedication.first.medicationName),
          Row(
            children: [
              Flexible(
                child: ContentDisplay(
                    'Medication Type', loadedMedication.first.type),
              ),
              Flexible(
                child: ContentDisplay(
                    'Quantity', loadedMedication.first.quantity.toString()),
              ),
            ],
          ),

                    Row(
            children: [
              Flexible(
                child: ContentDisplay(
                    'Expire Date', loadedMedication.first.expireDate.toString()),
              ),
              Flexible(
                child: ContentDisplay(
                    'Manufacture Date', loadedMedication.first.manufactureDate.toString()),
              ),
            ],

          ),
          ContentDisplay('Elderly ID',loadedMedication.first.elderlyID ),
          ContentDisplay('Description',loadedMedication.first.description ),

          OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  AddMedicationTiming(loadedMedication.first.id),
                              fullscreenDialog: true,
                            ))
                      },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  )),

        ],
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
