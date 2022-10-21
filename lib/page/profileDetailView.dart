import 'package:flutter/material.dart';

class ProfileDetailView extends StatelessWidget {
  final id;

  ProfileDetailView(String this.id);

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
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  // @override
  // void didChangeDependencies{

  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
