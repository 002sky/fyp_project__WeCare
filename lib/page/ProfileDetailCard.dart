import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    return Row(children: [
      Container(
        child: loadedProfile.first.elderlyImage.isEmpty
            ? CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  loadedProfile.first.name[0].toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              )
            : CircleAvatar(
                backgroundImage:
                    MemoryImage(avatarImage(loadedProfile.first.elderlyImage)),
              ),
      ),
      Column(
        children: <Widget>[
            Text(loadedProfile.first.bedID),
          Text(loadedProfile.first.name),
          Text(loadedProfile.first.DOB),
          Text(loadedProfile.first.desc),
          Text(loadedProfile.first.gender),
        
          
        ],
      ),
    ]);
  }
}
