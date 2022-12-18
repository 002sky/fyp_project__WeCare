import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/statusReportProvider.dart';
import 'package:provider/provider.dart';

import '../provider/profileProvider.dart';

class AddElderlyStatusReportPage extends StatefulWidget {
  final String elderlyID;
  final String elderlyName;

  const AddElderlyStatusReportPage(this.elderlyName, this.elderlyID,
      {super.key});

  @override
  State<AddElderlyStatusReportPage> createState() =>
      _AddElderlyStatusReportPageState();
}

class _AddElderlyStatusReportPageState
    extends State<AddElderlyStatusReportPage> {
  TextEditingController statusReportController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5ac18e),
          title: Text('Save Status Report Pages'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: <Widget>[
                avatarImage(widget.elderlyID) != null
                    ? ProfileImage(widget.elderlyID, 1)
                    : ProfileImage(widget.elderlyName, 2),
                ContentDisplay('Elderly Name', widget.elderlyName),
                ReportTextField(),
                OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String data = jsonEncode({
                          'elderlyID': widget.elderlyID,
                          'report' : statusReportController.text,
                        });

                        Map<String, dynamic>? msg =
                            await Provider.of<StatusReportProvider>(context,
                                    listen: false)
                                .setStatuReport(data);

                        if (msg!.isNotEmpty) {
                          _showErrorDialog(msg['message'],
                              msg['success'] != true ? 'Error' : 'Message');
                        }
                      }
                    },
                    child: Text('Save')),
              ],
            )));
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

  Widget ProfileImage(String profileImage, int type) {
    return Center(
      child: type == 1
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: MemoryImage(avatarImage(widget.elderlyID)!),
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

  Widget ReportTextField() {
    return TextFormField(
      maxLines: 15,
      maxLength: 400,
      controller: statusReportController,
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
          labelText: 'Report',
          helperText: 'Report Cannot be Empty'),
    );
  }

  Widget ContentDisplay(String label, String data) {
    final display = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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

  Uint8List? avatarImage(String img) {
    String imgValue;
    Provider.of<ProfileProvider>(context, listen: false).getProfileByID(img);

    imgValue = Provider.of<ProfileProvider>(context, listen: false)
        .profileByID
        .first
        .elderlyImage;

    if (imgValue != '') {
      Uint8List bytes = base64.decode(imgValue);
      return bytes;
    } else {
      return null;
    }
  }
}
