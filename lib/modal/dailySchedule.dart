class DailySchedule {
  final String elderlyName;
  final String time;
  final List<DailyScheduleDetail> detail;

  DailySchedule({
    required this.elderlyName,
    required this.time,
    required this.detail,
  });

  factory DailySchedule.fromJson(Map<String, dynamic> parsejson) {
    List<DailyScheduleDetail> scheduleDetail = [];
    if (parsejson['medication'].runtimeType.toString() == 'List<dynamic>') {
      Iterable list;
      list = parsejson['medication'] as List;
      scheduleDetail =
          list.map((i) => DailyScheduleDetail.fromJson(i)).toList();
    } else {
      print('help');
      var list = parsejson['medication'];
      final result = DailyScheduleDetail.fromJson(list);
      scheduleDetail.add(result);
    }

    return DailySchedule(
        elderlyName: parsejson['name'],
        time: parsejson['time'],
        detail: scheduleDetail);
  }
}

class DailyScheduleDetail {
  final String? id;
  final String? medicationName;
  final String? type;

  DailyScheduleDetail(
      {required this.id, this.medicationName, required this.type});

  factory DailyScheduleDetail.fromJson(Map<String, dynamic> json) {
    return DailyScheduleDetail(
        id: json['id'].toString(),
        medicationName: json['medicationName'],
        type: json['type']);
  }
}
