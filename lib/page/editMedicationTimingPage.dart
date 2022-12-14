import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:fyp_project_testing/provider/medicationTimingProvider.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../modal/medication.dart';

class EditMedicationTiming extends StatefulWidget {
  final id;
  EditMedicationTiming(this.id, {super.key});

  @override
  State<EditMedicationTiming> createState() => _EditMedicationTiming();
}

class _EditMedicationTiming extends State<EditMedicationTiming> {
  var _isInit = true;
  var _isLoading = false;
  var loadedMedication;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<MedicationProvider>(context, listen: false)
          .getMedicationData()
          .then((_) {
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
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Set Medication Timing'),
        ),
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  ContentDisplay(
                      'Medication Name', loadedMedication.first.medicationName),
                  ContentDisplay('Medication Name', loadedMedication.first.id),
                  DynamicAddForm(
                      widget.id, loadedMedication.first.medicationTime),
                ],
              ));
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

class DynamicAddForm extends StatefulWidget {
  final id;
  final List<MedicationTime> list;

  DynamicAddForm(this.id, this.list, {super.key});

  @override
  State<DynamicAddForm> createState() => _DynamicAddFormState();
}

class _DynamicAddFormState extends State<DynamicAddForm> {
  List<TextEditingController> _textEditor = [];
  List<TextFormField> _generating = [];

  late List<Map<String, dynamic>> _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = [];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    for (var i in widget.list) {
      _addInputField(context, i.time);
    }

    super.didChangeDependencies();
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
                    _addInputField(context, '');
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_generating.length > 1) {
                        _generating.removeLast();
                        _textEditor.removeLast();
                      }
                      print(_generating.length);
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shrinkWrap: true,
            itemCount: _generating.length,
            itemBuilder: (context, index) {
              return _generating.elementAt(index);
            }),
        OutlinedButton(
            onPressed: () async {
              gettingValue();
              print(_value);
              if (_value.isNotEmpty) {
                String data = json.encode({
                  'medicationID': widget.id,
                  'time_status': _value,
                });
                Map<String, dynamic>? msg =
                    await Provider.of<MedicationTimingProvder>(context,
                            listen: false)
                        .EditMedicationTiming(data);

                if (msg!.isNotEmpty) {
                  _showErrorDialog(msg['message'].toString(),
                      msg['success'] != true ? 'Error' : 'Message');
                }
              } else {}

              _value.clear();
            },
            child: Text('Update'))
      ],
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

  _addInputField(context, input) {
    final inputFieldController = TextEditingController();
    final inputField = _generateInputFiled(inputFieldController..text = input);

    setState(() {
      _textEditor.add(inputFieldController);
      _generating.add(inputField);
    });
  }

  _generateInputFiled(inputController) {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Time Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: inputController,
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
            Icons.date_range_outlined,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Medication Timing',
          helperText: 'Medication Timing Cannot Be Empty'),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            initialEntryMode: TimePickerEntryMode.input);
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            inputController.text = formatTimeOfDay(picked);
          });
        }
      },
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  List<Map<String, dynamic>> gettingValue() {
    for (var time in _textEditor) {
      if (time.text != '') {
        Map<String, dynamic> json = {'Time': time.text};
        if (_textEditor.length > _value.length) {
          _value.add(json);
        }
      }
    }
    print(_value);
    return _value;
  }
}
