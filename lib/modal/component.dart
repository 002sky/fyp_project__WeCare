import 'package:flutter/material.dart';

class Component {
  final String id;
  final String title;
  final Color color;
  final IconData icon;
 

  const Component(
      {required this.id,
      required this.title,
      this.color = Colors.greenAccent,
      required this.icon});
}
