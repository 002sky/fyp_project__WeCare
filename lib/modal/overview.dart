class Overview {
  String time;
  
  List<OverviewItem> item;

  Overview({required this.time, required this.item});

  factory Overview.fromJson(Map<String, dynamic> json) {
    List<OverviewItem> OT = [];
    if (json['Eldelry'].runtimeType.toString() == 'List<dynamic>') {
      Iterable list;
      list = json['Eldelry'] as List;
      OT = list.map((i) => OverviewItem.fromJson(i)).toList();
    } else if (json['time'] != null) {
      var list = json['Eldelry'];
      final result = OverviewItem.fromJson(list);
      OT.add(result);
    } else {
      OT;
    }

    return Overview(time: json['time'] ?? '', item: OT);
  }
}

class OverviewItem {
  String eName;
  String MedicationName;
  String Dose;

  OverviewItem(
      {required this.eName, required this.MedicationName, required this.Dose});

  factory OverviewItem.fromJson(Map<String, dynamic> json) {
    return OverviewItem(
        eName: json['Elderly_Name'] ?? '',
        MedicationName: json['medicationName'] ?? '',
        Dose: json['dose'] ?? '');
  }
}
