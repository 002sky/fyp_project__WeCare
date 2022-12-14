import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fyp_project_testing/page/profileDetailView.dart';
// import 'package:fyp_project_testing/modal/profile.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String DOB;
  final String bedID;
  final String gender;
  final String desc;
  final String elderlyImage;
  final String id;
  ProfileCard(this.name, this.DOB, this.bedID, this.gender, this.desc,
      this.elderlyImage, this.id);

  IconData iconType(String gender) {
    if (gender.toLowerCase() == "male") {
      return Icons.male_outlined;
    } else if (gender.toLowerCase() == "female") {
      return Icons.female_outlined;
    } else {
      return Icons.question_mark_outlined;
    }
  }

  Uint8List avatarImage(String img) {
    Uint8List bytes = base64.decode(img);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minVerticalPadding: 10,
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ProfileDetailView(id),
                  fullscreenDialog: true,
                ),
              )
            },
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: elderlyImage.isEmpty
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    name[0].toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                )
              : CircleAvatar(
                  backgroundImage: MemoryImage(avatarImage(elderlyImage)),
                ),
          // child: Text(bedID),
        ),
        title: Text(name),
        trailing: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Icon(
            iconType(gender),
            color: Colors.blue,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54, width: 1),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(
            desc,
            overflow: TextOverflow.clip,
          ),
        ));
  }
}
