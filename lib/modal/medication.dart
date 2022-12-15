class Medication {
  String id;
  String medicationName;
  String type;
  String description;
  DateTime expireDate;
  String dose;
  String image;
  int quantity;
  String elderlyID;
  List<MedicationTime>? medicationTime;


  Medication({
    required this.id,
    required this.medicationName,
    required this.type,
    required this.description,
    required this.expireDate,
    required this.dose,
    required this.image,
    required this.quantity,
    required this.elderlyID,
    required this.medicationTime,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    List<MedicationTime> medTime = [];
    if (json['time'].runtimeType.toString() == 'List<dynamic>') {
      Iterable list;
      list = json['time'] as List;
      medTime = list.map((i) => MedicationTime.fromJson(i)).toList();
    } else if (json['time'] != null) {
      var list = json['time'];
      final result = MedicationTime.fromJson(list);
      medTime.add(result);
    } else {
      medTime;
    }

    return Medication(
      id: json['id'].toString(),
      medicationName: json['medicationName'],
      type: json['type'],
      description: json['description'],
      expireDate: DateTime.parse(json['expireDate']),
      dose: json['dose'],
      image: json['image'] ?? '',
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
    return MedicationTime(time: json['Time'] ?? '');
  }
}
