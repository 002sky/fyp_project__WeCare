import 'package:flutter/material.dart';

class Medication {
  String id;
  String medicationName;
  String type;
  String description;
  DateTime expireDate;
  DateTime manufactureDate;
  int quantity;
  String elderlyID;

  // imgae
  //icon

  Medication({
    required this.id,
    required this.medicationName,
    required this.type,
    required this.description,
    required this.expireDate,
    required this.manufactureDate,
    required this.quantity,
    required this.elderlyID,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'].toString(),
      medicationName: json['medicationName'],
      type: json['type'],
      description:json['description'],
      expireDate: DateTime.parse(json['expireDate']),
      manufactureDate: DateTime.parse(json['manufactureDate']),
      quantity: int.parse(json['quantity'].toString()),
      elderlyID: json['elderlyID'].toString(),
    );
  }
}
