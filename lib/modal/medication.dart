class Medication {
  String id;
  String medicationName;
  String type;
  String description;
  DateTime expireDate;
  DateTime manufactureDate;
  int quantity;
  String elderlyID;
  List<MedicationTime> medicationTime;

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
    required this.medicationTime,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    List<MedicationTime> medTime = [];
    if (json['time'].runtimeType.toString() == 'List<dynamic>') {
      Iterable list;
      list = json['time'] as List;
      medTime =
          list.map((i) => MedicationTime.fromJson(i)).toList();
    } else {
      print('help');
      var list = json['time'];
      final result = MedicationTime.fromJson(list);
      medTime.add(result);
    }

    return Medication(
      id: json['id'].toString(),
      medicationName: json['medicationName'],
      type: json['type'],
      description: json['description'],
      expireDate: DateTime.parse(json['expireDate']),
      manufactureDate: DateTime.parse(json['manufactureDate']),
      quantity: int.parse(json['quantity'].toString()),
      elderlyID: json['elderlyID'].toString(),
      medicationTime: medTime,
    );
  }
}

class MedicationTime {
  String time;

  MedicationTime({required this.time});

  factory MedicationTime.fromJson(Map<String, dynamic> json) {
    return MedicationTime(time: json['time'] ?? '');
  }
}
