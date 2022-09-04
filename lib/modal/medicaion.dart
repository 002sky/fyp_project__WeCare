import 'package:flutter/material.dart';

class Medication {
  final String id;
  final String MedicationName;
  final Image MedicationImage;
  final IconData icon;
 

  const Medication(
      {required this.id,
      required this.MedicationName,
      required this.MedicationImage,
      required this.icon});
}