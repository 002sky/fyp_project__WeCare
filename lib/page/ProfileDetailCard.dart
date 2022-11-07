import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:provider/provider.dart';
import '';

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

  

  @override
  Widget build(BuildContext context) {
    final loadedProfile =
        Provider.of<ProfileProvider>(context, listen: false).profileByID;
  
    return Container(
      child: Column(
        children: [
          Text(loadedProfile.first.name),
          Text(loadedProfile.first.DOB),

          Text(loadedProfile.first.desc),
          Text(loadedProfile.first.gender),


          
      ]),
    );
  }
}
