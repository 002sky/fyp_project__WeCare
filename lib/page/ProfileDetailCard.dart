import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/editProfilePage.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:provider/provider.dart';

class ProfileDetailCard extends StatefulWidget {
  final id;
  ProfileDetailCard(this.id);
  @override
  State<ProfileDetailCard> createState() => _ProfileDetailCard(id);
}

class _ProfileDetailCard extends State<ProfileDetailCard> {
  var id;
  var _isInit = true;
  var _isLoading = false;
  _ProfileDetailCard(this.id);

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).getProfileByID(widget.id).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  Uint8List avatarImage(String img) {
    Uint8List bytes = base64.decode(img);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    final loadedProfile =
        Provider.of<ProfileProvider>(context, listen: false).profileByID;
    return Container(
      child: Column(
        children: <Widget>[
          ProfileImage(
              loadedProfile.first.elderlyImage.isEmpty
                  ? loadedProfile.first.name
                  : loadedProfile.first.elderlyImage,
              loadedProfile.first.elderlyImage.isEmpty ? 2 : 1),
          ContentDisplay('Elderly Name:', loadedProfile.first.name),
          Row(
            children: [
              Flexible(
                child:
                    ContentDisplay('Date of Birth:', loadedProfile.first.DOB),
              ),
              Flexible(
                child: ContentDisplay('Gender', loadedProfile.first.gender),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: ContentDisplay('Room No', loadedProfile.first.roomID),
              ),
              Flexible(
                child: ContentDisplay('Bed No', loadedProfile.first.bedID),
              ),
            ],
          ),
          ContentDisplay('Description', loadedProfile.first.desc),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  EditElderlyProfilePage(id),
                              fullscreenDialog: true,
                            ))
                      },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
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
