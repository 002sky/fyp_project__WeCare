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
          child: Column(
            children: [
              Align(
                child: Text('Add Schedule'),
                alignment: Alignment.center,
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Schedule Title',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderTextField(
                name: 'ScheduleTitle',
                controller: tileController,
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Start Time',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderDateTimePicker(
                name: 'StartTime',
                onChanged: (val) {
                  startTime = val!;
                },
              ),
              SizedBox(height: 10),
              Align(
                child: Text('End Time',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderDateTimePicker(
                name: 'EndTime',
                onChanged: (val) {
                  endTime = val!;
                },
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Color',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderColorPickerField(
                name: 'Color',
                colorPickerType: ColorPickerType.materialPicker,
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
              
                        String data = json.encode({
                          'eventName': tileController.text,
                          'start_time': startTime.toString(),
                          'end_time': endTime.toString(),
                          'userID': Provider.of<Auth>(context,listen: false).userID,
                          'color_display': 'green'
                        });
                        addScheduleData(data);
                      },
                      child: Text('button')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
