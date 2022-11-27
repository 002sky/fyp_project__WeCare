

class Schedule {
  String id;
  String eventName;
  DateTime start_time;
  DateTime end_time;
  String userID;
  String  color_display;

  Schedule({
    required this.id,
    required this.eventName,
    required this.start_time,
    required this.end_time,
    required this.userID,
    required this.color_display,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'].toString(),
      eventName: json['eventName'] ?? '',
      start_time: DateTime.parse(json['start_time']),
      end_time: DateTime.parse(json['end_time']),
      color_display: json['color_display'] ?? '',
      userID: json['userID'].toString(),
    );
  }
}


