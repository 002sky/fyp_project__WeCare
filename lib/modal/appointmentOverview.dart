class AppointmentOverview {
  String Date;
  List<AppointmentItem> Aitem;

  AppointmentOverview({required this.Date, required this.Aitem});

  factory AppointmentOverview.fromJson(Map<String, dynamic> json) {
    List<AppointmentItem> AI = [];
    if (json['Relative'].runtimeType.toString() == 'List<dynamic>') {
      Iterable list;
      list = json['Relative'] as List;
      AI = list.map((i) => AppointmentItem.fromJson(i)).toList();
    } else if (json['date'] != null) {
      var list = json['Relative'];
      final result = AppointmentItem.fromJson(list);
      AI.add(result);
    } else {
      AI;
    }

    return AppointmentOverview(Date: json['date'], Aitem: AI);
  }
}

class AppointmentItem {
  String Rname;
  String time;
  String reason;

  AppointmentItem(
      {required this.Rname, required this.time, required this.reason});

  factory AppointmentItem.fromJson(Map<String, dynamic> json) {
    return AppointmentItem(
        Rname: json['relativeName'], time: json['time'], reason: json['reason']);
  }
}
