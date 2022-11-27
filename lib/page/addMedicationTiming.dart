import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:fyp_project_testing/provider/medicationTimingProvider.dart';
import 'package:provider/provider.dart';

class AddMedicationTiming extends StatefulWidget {
  final id;
  const AddMedicationTiming(this.id, {super.key});

  @override
  State<AddMedicationTiming> createState() => _AddMedicationTimingState();
}

class _AddMedicationTimingState extends State<AddMedicationTiming> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = false;
      });

      Provider.of<MedicationProvider>(context, listen: false)
          .getMedicationData();

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

  @override
  Widget build(BuildContext context) {
    final loadedMedication =
        Provider.of<MedicationProvider>(context, listen: false).medicationByID;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Set Medication Timing'),
        ),
        body: _isInit == false
            ? Column(
                children: <Widget>[
                  ContentDisplay(
                      'Medication Name', loadedMedication.first.medicationName),
                  ContentDisplay('Medication Name', loadedMedication.first.id),
                  DynamicAddForm(widget.id),
                ],
              )
            : Column(
                children: <Widget>[
                  Text('wait'),
                ],
              ));
  }

  // Widget ProfileImage(String profileImage, int type) {
  //   return Center(
  //     child: type == 1
  //         ? CircleAvatar(
  //             radius: 50.0,
  //             backgroundImage: MemoryImage(avatarImage(profileImage)),
  //           )
  //         : CircleAvatar(
  //             radius: 50.0,
  //             backgroundColor: Colors.white,
  //             child: Text(
  //               profileImage[0].toUpperCase(),
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
  //             ),
  //           ),
  //   );
  // }

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

class DynamicAddForm extends StatefulWidget {
  final id;

  const DynamicAddForm(this.id, {super.key});

  @override
  State<DynamicAddForm> createState() => _DynamicAddFormState();
}

class _DynamicAddFormState extends State<DynamicAddForm> {
  late int _count;

  late List<Map<String, dynamic>> _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = 0;
    _value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Medications Timeing:'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_count > 1) {
                        _count--;
                        _onDetete(_count);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: _count,
            itemBuilder: (context, index) {
              return _row(index);
            }),
        OutlinedButton(
            onPressed: () async {
              print(widget.id + _value.toString());
              String data = json.encode({
                'elderlyID': widget.id,
                'time_status': _value,
              });

              Map<String, dynamic>? msg =
                  await Provider.of<MedicationTimingProvder>(context,
                          listen: false)
                      .setMedicationTiming(data);
            },
            child: Text('data'))
      ],
    );
  }

  _row(int key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text('id: $key'),
          SizedBox(
            width: 20,
          ),
          Expanded(child: TextFormField(
            onChanged: ((value) {
              _onUpdate(key, value);
            }),
          )),
        ],
      ),
    );
  }

  _onUpdate(int key, String val) {
    int foundKey = -1;

    for (var map in _value) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }

    if (-1 != foundKey) {
      _value.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }

    Map<String, dynamic> json = {'id': key, 'Time': val, 'Status': false};

    _value.add(json);

    print(_value);
  }

  _onDetete(int id) {
    int foundKey = -1;
    for (var map in _value) {
      if (map.containsKey('id')) {
        if (map['id'] == id) {
          foundKey = id;
          break;
        }
      }
    }

    if (-1 != foundKey) {
      _value.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
  }
}
