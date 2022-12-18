import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:fyp_project_testing/provider/auth.dart';
import 'package:provider/provider.dart';
import '../provider/scheduleUtility.dart';

class AddSchdeulePage extends StatefulWidget {
  @override
  State<AddSchdeulePage> createState() => _AddSchdeulePage();
}

class _AddSchdeulePage extends State<AddSchdeulePage> {
  TextEditingController tileController = new TextEditingController();
  late DateTime startTime;
  late DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Add Schedule'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: FormBuilder(
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'ScheduleTitle',
                controller: tileController,
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
                      Icons.title,
                      color: Theme.of(context).primaryColor,
                    ),
                    labelText: 'Title',
                    helperText: 'Title Cannot Be Empty'),
              ),
              SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'StartTime',
                onChanged: (val) {
                  startTime = val!;
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
                      Icons.schedule,
                      color: Theme.of(context).primaryColor,
                    ),
                    labelText: 'Start Time',
                    helperText: 'Start Time Cannot Be Empty'),
              ),
              SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'EndTime',
                onChanged: (val) {
                  endTime = val!;
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
                      Icons.schedule,
                      color: Theme.of(context).primaryColor,
                    ),
                    labelText: 'End Time',
                    helperText: 'End Time Cannot Be Empty'),
              ),
              SizedBox(height: 10),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      String data = json.encode({
                        'eventName': tileController.text,
                        'start_time': startTime.toString(),
                        'end_time': endTime.toString(),
                        'userID':
                            Provider.of<Auth>(context, listen: false).userID,
                        'color_display': 'green'
                      });
                      addScheduleData(data);
                    },
                    child: Text('Save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
