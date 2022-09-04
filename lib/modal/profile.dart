import 'package:flutter/material.dart';

class Profile {
  final String id;
  final String name;
  final String profilePic;
  final String desc;
  final Color color;
  final IconData gender;

   Profile(
      {required this.id,
      required this.name,
      required this.profilePic,
      required this.desc,
      this.color = Colors.greenAccent,
      required this.gender});
}
