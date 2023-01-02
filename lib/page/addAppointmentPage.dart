import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/appointmentProvider.dart';
import 'package:fyp_project_testing/provider/auth.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  TextEditingController timeController = TextEditingController();
  TextEditingController Datecontroller = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Make Appointment'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: <Widget>[
            ReasonTextField(),
            SizedBox(
              height: 5,
            ),
            DateTextField(),
            SizedBox(
              height: 5,
            ),
            timeTextField(),
            SizedBox(
              height: 5,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () async {
                  //check the validation of the form, if form not error encode to json send to networkUtil
                  if (_formKey.currentState!.validate()) {
                    String data = jsonEncode({
                      'reason': reasonController.text,
                      'date': Datecontroller.text,
                      'time': timeController.text,
                      'userID':
                          Provider.of<Auth>(context, listen: false).userID,
                    });
                    Map<String, dynamic>? msg =
                        await Provider.of<AppointmentProvider>(context,
                                listen: false)
                            .setAppointment(data);

                    if (msg!.isNotEmpty) {
                      _showErrorDialog(msg['message'].toString(),
                          msg['success'] != true ? 'Error' : 'Message');
                    }
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

  Widget timeTextField() {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Time Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: timeController,
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
          labelText: 'Visit Time',
          helperText: 'Time Visiting'),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            initialEntryMode: TimePickerEntryMode.input);
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            timeController.text = formatTimeOfDay(picked);
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

  Widget DateTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Date Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: Datecontroller,
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
          labelText: 'Date',
          helperText: 'Date Visiting'),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1940),
            lastDate: DateTime(2100));
        if (pickedDate != null) {
          setState(() {
            String formatedDate = DateFormat('y-M-d').format(pickedDate);
            Datecontroller.text = formatedDate.toString();
          });
        } else {
          setState(() {
            Datecontroller.text = '';
          });
        }
      },
    );
  }

  Widget ReasonTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Reason Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: reasonController,
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
          labelText: 'Reason',
          helperText: 'Reason to visit'),
    );
  }
}
