import 'package:flutter/material.dart';

import 'package:fyp_project_testing/page/ProfileCard.dart';
import 'package:fyp_project_testing/page/addElderlyProfilePage.dart';
import 'package:fyp_project_testing/provider/profileProvider.dart';
import 'package:provider/provider.dart';

import '../modal/profileDetail.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({super.key});

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  var _isInit = true;
  var _isLoading = false;
   List<ProfileDetail> postD = [];
  String _searchTerm = '';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).getPostData().then((_) {
        postD = Provider.of<ProfileProvider>(context, listen: false).profile;
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
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Elderly Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 3,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Perform search action here
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
            _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: postD.length,
                    itemBuilder: (context, index) { 
                      final item = postD[index].name;
                      if (item.contains(_searchTerm)) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                          child: ProfileCard(
                              postD[index].name,
                              postD[index].DOB,
                              postD[index].bedID,
                              postD[index].gender,
                              postD[index].desc,
                              postD[index].elderlyImage,
                              postD[index].id),
                        );
                      }
                      return Container();
                    },
                  )),
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddElderlyProfilePage(),
                fullscreenDialog: true,
              ))
        },
      ),
    );
  }
}
