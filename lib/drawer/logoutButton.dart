import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  IconData icon;
  String text;
  final VoidCallback onTap;

  LogoutButton(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
