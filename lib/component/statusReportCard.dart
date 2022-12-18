import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:provider/provider.dart';

import '../page/addElderlyStatusReport.dart';

class StatusReportCard extends StatefulWidget {
  final String name;
  final String? status;
  final String imgID;
  StatusReportCard(this.name, this.status, this.imgID, {super.key});

  @override
  State<StatusReportCard> createState() => _StatusReportCardState();
}

class _StatusReportCardState extends State<StatusReportCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AddElderlyStatusReportPage(widget.name,widget.imgID),
                  fullscreenDialog: true,
                ),
              )
        },
        leading:  avatarImage(widget.imgID) == null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      widget.name[0].toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: MemoryImage(avatarImage(widget.imgID)!),
                  ),
        title: Text(widget.name),
        trailing: 

           Icon(
            Icons.edit_calendar_outlined,
            color: Colors.blue,
          ),
 
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54, width: 1),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => {
                      
                    },
                    child: Text(widget.status == '0' ? 'incomplete': 'complete'),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)))),
                  ),
                ],
              )
            ],
          ),
        ));
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
