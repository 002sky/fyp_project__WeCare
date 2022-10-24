import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/profileProvider.dart';

class ProfileDetailView extends StatelessWidget {
  final id;

  ProfileDetailView(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('profile detail'),
      ),
      body: Container(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          shadowColor: Colors.greenAccent,
          child: Column(
            children: <Widget>[
              Text(id),
              ProfileCard(id),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final id;
  ProfileCard(this.id);
  @override
  State<ProfileCard> createState() => _ProfileCardState(id);
}

class _ProfileCardState extends State<ProfileCard> {
  var id;
  var _isInit = true;
  var _isLoading = false;
  _ProfileCardState(this.id);

  // @override
  // void initState() {
  //   Provider.of<ProfileProvider>(context, listen: false).getProfileByID(id);
  //   super.initState();
  // }

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

  @override
  Widget build(BuildContext context) {
    // final postD =
    //     Provider.of<ProfileProvider>(context, listen: false).profileByID;

    final loadedProfile =
        Provider.of<ProfileProvider>(context, listen: false).profileByID;

    return Container(
      child: Text(loadedProfile.first.name),
    );
  }
}
